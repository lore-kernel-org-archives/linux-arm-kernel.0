Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D40C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6132133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Je5b0S00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6132133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iBkQxHYC2ApiPfqW/mBsVAkTxhffiL6extxs0eR5og0=; b=Je5b0S00+CQrNH
	nkcsnxnJnjm5W5PwulRqO6TT8uJW1yo6EWDBy0AN9dc8mYdM2qBQYijoFD4jL/gBB17aC6iyF+zWc
	GoPlWEF+WkLbFy4KT9Tk3A61guhbzmDfFMtkHOJzBYt0D1yLcPlKo6jkzyRQ5FNJCgo66Gs+xeo0+
	V6gwmb6Y6pk6Pin046uH3mJlZl8bXPiz6AQC/rGD7MeqIvmgHFgTyo0HSnnYawaUEAW1GsupRt4Uf
	FzQED/lKc7Gg3xYsRc3M1ETdhBG6PQylyjQGRNgpCCXuaUln5ZbHk20tnqJcL7euMt5u3/XsI5O3b
	XR+miwkNuEsSnhrNZutA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdCb-0001Cw-Gx; Wed, 05 Dec 2018 19:51:21 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdCO-00010b-MC
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:51:10 +0000
Received: by mail-oi1-f193.google.com with SMTP id b141so18618716oii.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ipiihTdwGrlX+ons2IhQ9+ZcJCpVaVxx2iEVJRMYgr4=;
 b=WuBqXwbnnxaNk+P8dzY7JJBTNYIBWeOev0GPDE786UMr+60h5fwvAYv0P9r1n3OB1W
 Ed5PXlDhI1AE5vM3tCnFSybHG9RKw5wJTVSzi76uuDp8wkbOqWrpxmmNFlhV/ql+FaNl
 6TA7egOm1wuo+hvkT8qOOGw2bNaaKGzHD+aSgdzCg+5FXUjbQ3ISiwnOfSXsGSUqFO2H
 VvePydXVXC8o3bv/r05Qu8SbD52xNvj539wLeTDILAKFYH17KAoAYxqSPCVzoLFGxwWq
 u/o5kCcbNyip8tUuod2nTTWSlCPEa58Zefz1LMZ9TK9mb9v7KZanxXw/+hEyHlK9Nm/t
 vqgA==
X-Gm-Message-State: AA+aEWZ2JEeHC6gOZh7BCOoI5SpmCNTKXsmCGb8ghcLX5b9PyZbbSRSL
 Vxmr0x5y4beMaPqWDThawg==
X-Google-Smtp-Source: AFSGD/UZvxBqCY3JOfT6rY2Quj+tFDglL3wTaHZAdpELyGuR1Pk+5RHWz0USV747XbenS/KHVaYvrQ==
X-Received: by 2002:aca:e401:: with SMTP id b1mr15022730oih.231.1544039457753; 
 Wed, 05 Dec 2018 11:50:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:50:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:22 -0600
Message-Id: <20181205195050.4759-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115108_720276_0183D5DE 
X-CRM114-Status: GOOD (  14.12  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/devfreq/devfreq-event.c     | 2 +-
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index d67242d87744..87e93406d7cd 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 	}
 
 	list_for_each_entry(edev, &devfreq_event_list, node) {
-		if (!strcmp(edev->desc->name, node->name))
+		if (of_node_name_eq(node, edev->desc->name))
 			goto out;
 	}
 	edev = NULL;
diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0bdf053..c2ea94957501 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
 			if (!ppmu_events[i].name)
 				continue;
 
-			if (!of_node_cmp(node->name, ppmu_events[i].name))
+			if (of_node_name_eq(node, ppmu_events[i].name))
 				break;
 		}
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
