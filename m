Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C58C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:29:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68ED2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MdMuQkRs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDypPRZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68ED2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RiJ5OFKd9G/Nmvy8FeuLJdnu7jhX3r5F2oMCR8HYM1Y=; b=MdMuQkRsarMOVTuM8Net7Sgnjl
	MDDZc8JNXri6ARnKpEmYFbt4hbHhrJB1huzLDAlVa3We8Yu3IcN+6SrKOy5ZytutAgwITzIL52BHp
	4EWLeEJ0y1g8nsbNfZRU6EIZRGPjjqitECpz4luU2CNKKsgI9NeFmkCPaJpHRNKf6YzNwDcAGPOqA
	J47o3OShzmIO3J75ughwCyI3s0yOPWj6ufVbOscm8kLZ9Jw39Jnsd8nQhEwiN6Ed21xgsV0kzzggn
	qK7tOlpYppLPB3RJ/9lVcaQL63TBmmO/kfj3RRPilFnwPIVhZ3ymQcYCXZ8OL/04sJtLkgdgZAOwj
	oIfAAcWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzKe-0006Ks-MC; Thu, 20 Dec 2018 14:29:48 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzKb-0006BL-3C
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:29:46 +0000
Received: by mail-wr1-x436.google.com with SMTP id u4so1983028wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FW2I3Sggmd+278Bn2B6EVC0FYfMyVf+Bw1ea6IqE7gc=;
 b=XDypPRZMDbWUFO26p/nXjalc2fXT+RJWl50v/lO7IO20cXuTdK1TRJRoKn2qtm+imx
 aH0ibxy7zeNhbN72dQGXMLOulE36G2xxTaPsPXuuYKYrRNXt8dHMzlDdAbxb4P5ToVMm
 MVlNCqfAryD5wddGFTJ94RQngzKIkd3AZrINfwfq0lrC6NfGg83foZx3qwqsrM9R5n47
 HVv/VApjs7HgTqQhUrdnQEGsrXrxM2JIGEz6BHEixVzCNqqasEGGLnKd7LdTxOUDIOWh
 840VE3CblumnEKV+QFQUMgcHt9K8l3WWVkUGUnQFoG8W5eMtZcH1uJ9KCHz5fqjxDgJC
 tIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FW2I3Sggmd+278Bn2B6EVC0FYfMyVf+Bw1ea6IqE7gc=;
 b=MlAwyWy8pBjQFf5RiJzJNeeGaJk+VkGVIAnXXft7iuTF1jkFBFekkxXFgYCkWUSk41
 YjEv9XX6G7iQvJZqo7SScWYLeyLO7EI2tEbSm74zNV+YIi/UcmftwJSmTCUuReEfLcJ8
 FzPpjhOHcCIYw0r4FEk5YGiiSZwKfeymL1yz9ExpdNU8wBdCukze/VfEwUz6roR5WN6c
 fZ8rjHlqIks/3JF3o0CbpqAY9tEZLFg9jzQ7HyaR6VwXtk3D/En6xVIzKpFqibMJSIo9
 PaFhDqJNAi9VYjqwwwsa9/zzVMqFSuG6ikoV+yMaEWcFPK6JIyBItygJG+gCUGW4yZj7
 DeWw==
X-Gm-Message-State: AA+aEWYzCf6L8dAmjqtE6Duq7lsMlq+GVQ4YYe2q0UbD8oazzhZgdAC7
 ExZK2XK03/Hw8g6yxwS6UalTWF1jwPk=
X-Google-Smtp-Source: AFSGD/X8qmlSDcRP97b4Ee7JTFJIYyfAha4ZwmcoyN9Y7caSNjv+UObaXGAow+kQyq4FX4Ri9cKqYQ==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr20861937wrp.8.1545316172797; 
 Thu, 20 Dec 2018 06:29:32 -0800 (PST)
Received: from localhost (ip1f11b9d6.dynamic.kabel-deutschland.de.
 [31.17.185.214])
 by smtp.gmail.com with ESMTPSA id s1sm10619890wro.9.2018.12.20.06.29.31
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 06:29:32 -0800 (PST)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver2000@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM: dts: Add support for i.MX6 UltraLite DART NAND/WIFI
Date: Thu, 20 Dec 2018 15:28:38 +0100
Message-Id: <1545316119-18459-2-git-send-email-oliver2000@gmx.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
References: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_062945_135826_18CAC8DB 
X-CRM114-Status: GOOD (  16.35  )
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
 arch/arm/boot/dts/imx6ul-var-dart.dtsi | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-dart.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-var-dart.dtsi b/arch/arm/boot/dts/imx6ul-var-dart.dtsi
new file mode 100644
index 0000000..4cdeb89
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-dart.dtsi
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Support for Variscite DART-6UL Module
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+				MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+				MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
+			>;
+		};
+
+		pinctrl_rtc: rtcgrp {
+			fsl,pins = <
+				MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
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
