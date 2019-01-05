Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8611F208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u7oDWSUm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO4ANLRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8611F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bqvV1kUtg6c1G4jTikK34cPtF+guAudHulOtdLlRpVc=; b=u7oDWSUmdmW13ZyFeMycGEVkfl
	Nnb21JnfWPbEWtw/swqWQz9MZW/HfXXmMBcd6Szr2soR09Po0/mjmH5pzkB+yaftoAfEHBKQ4wkT3
	6s2Wf0c+Iz37Fw9h10wlbD7ENY/cNslSP00ixlTE71EvH++9ZlT1Fo1AOrlJ4I/lEc3HTwCqkqCHF
	NSRr+/COH6eN+3unSR5iRTb3Um9XuGQYvvkSCtcOB30QGAIh5I7IxArk1Hv01ZpSth2igCMvDDZ5v
	C5oV1UDfrEWTBbgX3DDLGrH1LGFNfD+CcarLmoSn8uHZlC1eJZAmlNWGa5HZzX75EPXSASReOEfD6
	8uBEppMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfgOm-0004zs-LG; Sat, 05 Jan 2019 07:29:36 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfgOb-0004rO-Hb
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 07:29:27 +0000
Received: by mail-pf1-x444.google.com with SMTP id z9so19345453pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OZUqEyntcniqwClwV2ZEKae3jaKSXPzX7XBfIZ1vjmE=;
 b=OO4ANLRLXSOcoQq0Mb5WSPDEQiDZ6hcmo8mueHc7mwoOFgT+R1preB9UxKL27cHYl0
 b8po8WFMgaj6kQNJSlQvLdZWSjLYfTCJ7M/hb3MQxV9fM3KSV8YlXQOEWdWQoEKfywxc
 LnM4FoGJ5ZqIghdVWPeyXEs7ozb+NkyANHcoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OZUqEyntcniqwClwV2ZEKae3jaKSXPzX7XBfIZ1vjmE=;
 b=dJDbsmxCgLFlC8ZwNCOugMNUPopq99hv61tyHJA58s+hIRIex0gQBaxKRr9YB9auYz
 aiGvkaAtFWBKZls8U0ECRsiiw4G9apa62Y02Mzm1UmxsClau1CwLPknIAg0w6J9kjisw
 yiI1kjHMQs1kcpNwvXOaid/2x0jD7DbKDmIu+KfaXqUTwp9ax/CRurU/nTKdoZNJIXpm
 NZOKIW5z99vxPrNTCZat1rUBsj1eLTu+wVwAPD9ICKuJwwBMYK4p8kUgUODssnv8Ojfr
 yoN4JbIi3FaAN6sD8qwtyJ3CbCe6AUr88Va3G6IRvaSq2+qQTZUwmtDszgd6R/IGH6CJ
 QFFw==
X-Gm-Message-State: AJcUukd8LyhYm5s7S08lW2ZxUeEQAGdZPnBUIzughgK3s+90sPadfpkA
 JWbIzNxk87MZ8IogxJtaLABK
X-Google-Smtp-Source: ALg8bN7RAlTBb7eqWaRgnwYK9vxRfmCtvaFnlDbjQe5KPPyB6EmOH5Wyg7wqeK5NGR3qfYUUNStNiw==
X-Received: by 2002:a65:590b:: with SMTP id f11mr4152588pgu.60.1546673363778; 
 Fri, 04 Jan 2019 23:29:23 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 23:29:23 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Date: Sat,  5 Jan 2019 12:58:57 +0530
Message-Id: <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_232925_616530_81E81626 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
similar to HI3660 SoC with almost same IPs. Only major difference in terms
of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
(HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
is added for HI3670 without any fallback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
index a48c44817367..0b83df1a5418 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -6,9 +6,10 @@ Each UFS Host Controller should have its own node.
 Required properties:
 - compatible        : compatible list, contains one of the following -
 					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
-					host controller present on Hi36xx chipset.
+					host controller present on Hi3660 chipset.
+					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
+					host controller present on Hi3670 chipset.
 - reg               : should contain UFS register address space & UFS SYS CTRL register address,
-- interrupt-parent  : interrupt device
 - interrupts        : interrupt number
 - clocks	        : List of phandle and clock specifier pairs
 - clock-names       : List of clock input name strings sorted in the same
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
