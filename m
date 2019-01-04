Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB77A21874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j3/ir/dC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI7M1jya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB77A21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VaCqp04NCii9crmOhPiEEyWh8FOWqDLKgkfz0F9DfQ8=; b=j3/ir/dC7nK52gVn/NV+mkDidN
	L2td18Qt3k4LPzfNbNFOTtLOPa+EWnO1nI6LPr541ta+RknSuZZySlqqT66oiYCtAbE6zzEsBanTy
	v63rSRq1tGY4uvIko1JEddmCqdYjinNdYYzW+eNkS/A1vIvTVpLeuAiau58EJst6YNJgxH0UP+lpi
	kANVs+4BXvJLRCU8iAhI01+8yVWiDbhMD1OvEIQglzA0663o6aqyGaEHey7kO8JwPsILmYcZCipZw
	iiAoG2i5XbiSE0WJAINMs3Xu3hM05Q9NuNjOIo9IMizQ99/8SzmMakbyxHRWcYPCUl3k8kmvClaVL
	O/gO3Btg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPVC-0005DH-Dx; Fri, 04 Jan 2019 13:27:06 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPUo-0004m4-AB
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:26:45 +0000
Received: by mail-wr1-x435.google.com with SMTP id x10so36578592wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 05:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pIFsWny5q/WsJE1wcYjhqdWSvWgqlyyQ7NlwfpbMEFw=;
 b=gI7M1jyaZfLlOgZDf02fjt3U3ZAwhj8Mw12v1C60b90tBRmFzWQ41ChygCIXc7VlAI
 rUhSDeNTw0q9zko5BTjE4jBKJPR/S52sQtFw6bVGDxMJC9VjIKK4zcOGG6SbYhw+9Yq5
 SN/MFtur5KySHE2oeGIbLy6W+AcPVqvJo1VqhqUS8fMzP7pzgym07UhEeEjvsF1kyU34
 csWdzvSMGkzPd0icjIkVStkOCS+0qHXLhtNupHS4gKv89Dam1JszlmxIbcVKhsdzrsK1
 dvtloygOYQxd9kyHP7yp9FtlfrraTRUPQdE/CAcYJMXCVgymt1W35tMRPifem89dOb/r
 ENgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pIFsWny5q/WsJE1wcYjhqdWSvWgqlyyQ7NlwfpbMEFw=;
 b=Jtck+FQSl56aqzJBmXVdmqsgxHxdGVobKTKlfGG3/IIV/s9jrDKf265G9YbkEon/ly
 Cmc2a1AKw3feOFr0BuQzyQrVKJzUkJ0G44N9XRHZpjAG53sTW3AxGQ9l7ElJszm8e+oB
 WabqKOEFa8zuP1M4SaNI07gvh6tMsRKf3jP26WpM8ADvDVgRkg019XdfdfTOKYIlQZra
 iakEV33QPiA3gL3jOBHQ/yET6gFssjkhq3Zavsti584PUTL3bPGkMBFs1DSf4mlZT1EP
 F0O1FfxeqoCX4JzMIMf2MEZRB/c/w1cIfW+yFPX8bjNNKcRo91H7umYDx2smBTDPck6S
 HGGQ==
X-Gm-Message-State: AJcUukdzsx+JsP4RwSvv/LbJq/L9SIfyv5VHU4URWm+mpAgkUHiKLxJ3
 np1oEeIGzblIYbNEugd1pg9gwsg4Xv4=
X-Google-Smtp-Source: ALg8bN4LOQj77CTiwO5wrLIcS2RilPzS6f7iKG2uFZVjScUd26cAvfkoJotZ3yLdVifQorMDrXNteQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr42540039wrm.328.1546608399998; 
 Fri, 04 Jan 2019 05:26:39 -0800 (PST)
Received: from localhost (ip1f11350a.dynamic.kabel-deutschland.de.
 [31.17.53.10])
 by smtp.gmail.com with ESMTPSA id i186sm1211415wmd.19.2019.01.04.05.26.39
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 05:26:39 -0800 (PST)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver2000@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2] ARM: dts: add imx6ul-var-dart-nand-wifi.dtb
Date: Fri,  4 Jan 2019 14:26:11 +0100
Message-Id: <1546608371-31472-3-git-send-email-oliver2000@gmx.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546608371-31472-1-git-send-email-oliver2000@gmx.net>
References: <1546608371-31472-1-git-send-email-oliver2000@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_052642_599068_252617AA 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: s.hauer@pengutronix.de, Oliver Graute <oliver.graute@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Oliver Graute <oliver.graute@gmail.com>

added imx6ul-var-dart-nand-wifi.dts
updated Makefile

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 arch/arm/boot/dts/Makefile                      | 1 +
 arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148..64dc9df 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -564,6 +564,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-dart-nand-wifi.dts \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts b/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts
new file mode 100644
index 0000000..66d7acb
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ */
+#include "imx6ul-var-dart.dtsi"
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
