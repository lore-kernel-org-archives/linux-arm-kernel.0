Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16889C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD3221871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xka7oM0w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFJZMtwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD3221871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2b972hP+jLMVPc0toLr5nOAqG+jLP0Yz2RzIhvbJI5Q=; b=Xka7oM0w3FlYQsrGTUndjDni5x
	BehRLjIRknFbpNo6hn1HVauTp8WpyWotqNVV9ZOSJpSzC+5thABXSvJxvvfA2+IA3pQnGmtHH74wY
	qUeYN12X8XL/tif15iaNz6wC9Gf4N9r0MoR6IyIfSzyQ5Quv5x2l/Jvys3wk7P1Gcpgj+enr+fItl
	p8c9EO9yt1IhRmJAHDebPxjxguCLtZur6Dyk1Ma871FNQ3c6QS/hop10c6h9nE3SHqJaSFA4EJ1bA
	CypT1aPklPEL7hlasB797rGQvtuYsQ22vW5y5Rybye8PLnHKVKV2ZXLQF+gREPiaYfh5GK0RcKGVR
	k8elMrXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPUy-0004ya-U6; Fri, 04 Jan 2019 13:26:52 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPUj-0004jf-Lc
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:26:39 +0000
Received: by mail-wr1-x42a.google.com with SMTP id u4so36568872wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6KK+tz5MPsBg1cvlTkN5+njRnqcozgcCR8St9f7e2aA=;
 b=JFJZMtwE2hlnyiEoJ/mXhhrovuatJoJ3z+KtTZROhS3JRJPmy5i5kH+zVx/J0yuchc
 hSvdGngzodWTIIsWSjvY8mujDYA6Ar6pz4lFulo7J1VK+cRqQJ1SQyU/IfQ1DZsipwkm
 v+GQuNESAZsa1fWXaqlBp5vlNJSh14ya5lavIDrLOdGOAK1rEAwPDusICbeRwptQQVHd
 thfxmZMyx6NVgJN8nHp85TuPX1ZMPa2GnOsHniLV+xk4xgm9yHmstIwhSB6F3lDvrCPx
 uOE2xSeyKnYZipYOpwIPXN2Z0UsMTgkzatdOEofXsX0NeG+yEDfDvT7Nyyytni0ILduI
 wJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6KK+tz5MPsBg1cvlTkN5+njRnqcozgcCR8St9f7e2aA=;
 b=ibB7BSGHbE3NGrgkWWdeAt8ZcVAd1DwRthFtT1HRLhfP3RImU/QX5qpSHjw/m6pxHK
 Ywap7XPSoZ2U5KmpYbVH/QQjioOAM2Z2W3H61Y17yK3VX0uVZHqXrtvOkPpxkatYWr2k
 HY2Olv04zIMIwZHQKuSN7omjudXSHu8BwUXVbKA4GldtmoLi2Muj8XCytcDI7H4YeUaB
 AgHscUI2+q94uqfzXhubvxFAhYdwOmPcqNLR/UL1JcS/qdcC9+87ntDR1t5XXLBDb9VM
 6Rb5gufYw/kzz3oNth0jqmMYGv+rILhTcTxuTrONNP1gPiof1g37cn8Wzbp+tBLzFAZe
 FzgQ==
X-Gm-Message-State: AJcUukd6xjY99lJa4mQqx3HksqS6Ud4n7zZLdA/h/NOYmvxUgjYqBgIU
 O0dUiwICbLfYXjOoS9Jd4RBCR6rMv7c=
X-Google-Smtp-Source: ALg8bN58m8Ft0Bozk9CefdxImyVh56jeQksYc8HOl4Rzs8iyVrAxaLusKUIB1/bZZe8qw823Hs7szw==
X-Received: by 2002:adf:e707:: with SMTP id c7mr41516593wrm.196.1546608395745; 
 Fri, 04 Jan 2019 05:26:35 -0800 (PST)
Received: from localhost (ip1f11350a.dynamic.kabel-deutschland.de.
 [31.17.53.10])
 by smtp.gmail.com with ESMTPSA id s16sm38200938wrt.77.2019.01.04.05.26.34
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 05:26:35 -0800 (PST)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver2000@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2] ARM: dts: Add support for i.MX6 UltraLite DART NAND/WIFI
Date: Fri,  4 Jan 2019 14:26:10 +0100
Message-Id: <1546608371-31472-2-git-send-email-oliver2000@gmx.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546608371-31472-1-git-send-email-oliver2000@gmx.net>
References: <1546608371-31472-1-git-send-email-oliver2000@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_052637_704217_C6A2377E 
X-CRM114-Status: GOOD (  14.29  )
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

This patch adds DeviceTree Bindings for the i.MX6 UltraLite DART NAND/WIFI

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 arch/arm/boot/dts/imx6ul-var-dart.dtsi | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-dart.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-var-dart.dtsi b/arch/arm/boot/dts/imx6ul-var-dart.dtsi
new file mode 100644
index 0000000..d4476b6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-dart.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Support for Variscite DART-6UL Module
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ */
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "imx6ul.dtsi"
+#include "imx6ul-imx6ull-var-dart-common.dtsi"
+
+/ {
+	model = "Variscite i.MX6 UltraLite DART NAND/WIFI";
+	compatible = "fsl,imx6ul-var-dart", "fsl,imx6ul";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_1
+		     &pinctrl_hog_2>;
+	imx6ul-evk {
+		pinctrl_hog_2: hoggrp-2 {
+			fsl,pins = <
+				MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
+				MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT Enable */
+				MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029	/* WLAN enable */
+			>;
+		};
+
+		pinctrl_rtc: rtcgrp {
+			fsl,pins = <
+				MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0 /* RTC alarm IRQ */
+			>;
+		};
+	};
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
