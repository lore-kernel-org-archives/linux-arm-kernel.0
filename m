Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4FCC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862EF208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0bIxVnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862EF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zIKsVTR+A9XvvoQOJ960FWmzmYf74as6AcbR0mtzpoM=; b=q0bIxVnNhNSRvX
	SL/HHnJUnRuu4g0hjOfMxt2DPd5yDy8/Z+Ekttf9K8W1Fpelc3DrzBU+ZtPe0XY76V1C8CFSaunh3
	RrynmfoJpZE02bt+vddf3HV7uVx4XcBRtTDRrQqa5scIo/SrStAsdpBlE5h1njUsWtiF9IBmzsQJ0
	30+79VRiBzoofZuwTv82YYWJ+KTjULk+uzA8fQA3sdcwT4QHwLMapP7nRH6ndltBplM+tyjnBsqwy
	3WoIpQwjx3ORkla+gGDtPTAVncgQumjzHSaLEEnfoTNtBc+xNdeU5pm4B4rZbKwMjFWEyy3EBv1D8
	B45F8DJnd4RaA1Jon3pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdDf-0002Is-77; Wed, 05 Dec 2018 19:52:27 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdCu-0001OD-Vr
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:52:11 +0000
Received: by mail-ot1-f66.google.com with SMTP id s5so19789018oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qctK2c2J3l+tBzpOg1oUnoGeCH3cH1/L4PcrunO1KLU=;
 b=h1NY+7H6GvOGSUkDk0e/N14NY5HOKlez5XkXsEHbXBCU1HJTCDZ8ujlZgQa/HXdwBx
 xLyu0gq8D8QOMthMWR7mBOIl3mEe6AqGf85mvQ1NW5LRF6Pcyx/3Qu40cX/WhC8QUX4R
 H+/M6wSF+uMRfflnl0VpkMFPAvhEG9xE0+kpLErz1lgLVJ8ufebpIQQ6oP9vnShdqFHn
 /A+27WAokgm+BsoYulLBGkzq2q+oeYnlFf32XMjMQqyU3XHKsGlwtXxZQ9h8b9MrEHyN
 Fq/ks+AuF1javAm0FmdFl77uZ7zqMIUKAUzgniNXGwSUxcsjSN6/t1p4hM89H+eMgCu7
 U9gw==
X-Gm-Message-State: AA+aEWaNQ40j4kVOAegqEgrFWYEQki3Sk6CbHIpGXY80z60lxKOcW640
 iM8mHYcqenRjrVW3tT8kSw==
X-Google-Smtp-Source: AFSGD/XEunTCNxwJ7ZaoCxnPQQsLCOY0gMVg7PKStnA23jdS3FZI8iGSRFUk95tHVp+E03CMk+WeSw==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr15762782otl.196.1544039489380; 
 Wed, 05 Dec 2018 11:51:29 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:28 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:50 -0600
Message-Id: <20181205195050.4759-34-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115141_770411_F20820F5 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 89092f83567e..7045930fc958 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 	 * Skip one-level up to the real device node, if we
 	 * are using the new bindings.
 	 */
-	if (!of_node_cmp(parent->name, "in-ports") ||
-	    !of_node_cmp(parent->name, "out-ports"))
+	if (of_node_name_eq(parent, "in-ports") ||
+	    of_node_name_eq(parent, "out-ports"))
 		parent = of_get_next_parent(parent);
 
 	return parent;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
