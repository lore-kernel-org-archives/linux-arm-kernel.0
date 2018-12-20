Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704422084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEVkTveT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXuv5a1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704422084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=425NgddBRdcyscj9ZG3LofrxdvAnAw3pwAJu/vYxaFY=; b=WEVkTveTPidTTz
	pbV7qUb368KLqps5F2dt1eGB0rsNjrMhlPK6Y4vAPrNEmMFnnwJk2Ux9eBvDeNQc81un5W39YoQ4r
	Ntg43gUcLEZ0aTNSm2hcqzBu9a1pjTWdTFx+i76GArXoih6/VqoGORYn8Y+ZNcQcB+O2V1exjAR0C
	fvPON+20Nbp6jlnb7mKTXfb4dmi5zVy2lZGGzODjErEM47HnYSQKrJpd5EX94uUhiI0QpQryo+pTv
	MOl969UUYeXGRUMJTIVwN7q4ddEJ25z+YZF7MjJlcJ3isIU5KWQhVVZ1Xt23hb7BkkC3f67ANoC0n
	pNAm2/ArVyj2VfCC4lbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZmoQ-0005RM-A3; Thu, 20 Dec 2018 01:07:42 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZmoE-0005HS-Ba
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 01:07:32 +0000
Received: by mail-pg1-x544.google.com with SMTP id g189so32567pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5yjanOGqKt2X+U7hCj9lgZEDI+E4lAi/78Tud6Gou4k=;
 b=SXuv5a1OCUHNyKNaMxDprIbGfDeEKrx58PuZDsQ0dJwByr5+GzAY/pwSFQg24GVr3x
 riOR1QnI3pQ0AN9+4RuE02rXLLovNKDAgTa9H0CE9FOWMmdDIC3Gzcp9Y6jntUR+giQg
 XxkAsu0HQWnH0aKSFCSRhGWFFZBgH6Y9DOJwREBneunzBZ+t5MWLWJdDP3V5EycYdLMJ
 EmxLnQEdli2Xm828Twrn9v6E3LIdrztQf2JVZofL30lfn6m4bkZMEAg3g36xSsxCy0Yg
 t3k+ROm8x4RJNzVBNHiIQmO58sMCpoT1A67y/xlFu2fhYj54ZygwMNq07XM2HIuLrZlD
 wgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5yjanOGqKt2X+U7hCj9lgZEDI+E4lAi/78Tud6Gou4k=;
 b=cNuhBHvthL2ZTb/T9lcrUHtqZ85GInmefvJdcnNAr+0SJShGHNfyMS1nb8ImIYyKLY
 8LqjcblDrMA7h8WBVLusbB3xpHPl5gxhZsM2qfCalSPM2VkaZRH18JnKESimLaIaYvVX
 gs5fjAo0qjOqquWQMiOJBGIQckxxjSoS2nckficCoUubocbDhLHcUxEhVFHwRRTKx0nt
 5JaZET7c7gidMygK+LnygFHi7QKdLBrfiiEMQTYP1fV9Qlxh63BOaf2AX9gi47E0+FyS
 z67XagB/uYPpeEnxKwjaUodDapF7bwRFdMkvGQwbsrnoHEc5+YlIxxvpIO5HYeaZDQOs
 QQWg==
X-Gm-Message-State: AA+aEWbkfNuxqs6mY6Lz7a33i6WYJSyhm4rU6oRVTHisAmadNUduMNDK
 uTXyGYYRlx3QLrUlAnHdOck=
X-Google-Smtp-Source: AFSGD/UZX7hxQiGJ7N+TmkRcCoGyRG1EJFhMgIghejLALlKQkU3rDwumifoK4h6FMHOJC2v62hXIxQ==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr21657772pgj.17.1545268042911; 
 Wed, 19 Dec 2018 17:07:22 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 17:07:22 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on i.MX8MQ
 SoCs
Date: Wed, 19 Dec 2018 17:06:59 -0800
Message-Id: <20181220010700.8598-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_170730_444019_43528401 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The driver now supports i.MX8MQ, so update bindings accordingly.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/reset/fsl,imx7-src.txt           |  7 +-
 include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 1ab1d109318e..2ecf33815d18 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "fsl,imx7d-src", "syscon"
+- compatible:
+	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
+	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -44,4 +46,5 @@ Example:
 
 
 For list of all valid reset indicies see
-<dt-bindings/reset/imx7-reset.h>
+<dt-bindings/reset/imx7-reset.h> for i.MX7 and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
new file mode 100644
index 000000000000..57c592498aa0
--- /dev/null
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ */
+
+#ifndef DT_BINDING_RESET_IMX8MQ_H
+#define DT_BINDING_RESET_IMX8MQ_H
+
+#define IMX8MQ_RESET_A53_CORE_POR_RESET0	0
+#define IMX8MQ_RESET_A53_CORE_POR_RESET1	1
+#define IMX8MQ_RESET_A53_CORE_POR_RESET2	2
+#define IMX8MQ_RESET_A53_CORE_POR_RESET3	3
+#define IMX8MQ_RESET_A53_CORE_RESET0		4
+#define IMX8MQ_RESET_A53_CORE_RESET1		5
+#define IMX8MQ_RESET_A53_CORE_RESET2		6
+#define IMX8MQ_RESET_A53_CORE_RESET3		7
+#define IMX8MQ_RESET_A53_DBG_RESET0		8
+#define IMX8MQ_RESET_A53_DBG_RESET1		9
+#define IMX8MQ_RESET_A53_DBG_RESET2		10
+#define IMX8MQ_RESET_A53_DBG_RESET3		11
+#define IMX8MQ_RESET_A53_ETM_RESET0		12
+#define IMX8MQ_RESET_A53_ETM_RESET1		13
+#define IMX8MQ_RESET_A53_ETM_RESET2		14
+#define IMX8MQ_RESET_A53_ETM_RESET3		15
+#define IMX8MQ_RESET_A53_SOC_DBG_RESET		16
+#define IMX8MQ_RESET_A53_L2RESET		17
+#define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST	18
+#define IMX8MQ_RESET_OTG1_PHY_RESET		19
+#define IMX8MQ_RESET_OTG2_PHY_RESET		20
+#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
+#define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
+#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N	23
+#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N	24
+#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N	25
+#define IMX8MQ_RESET_PCIEPHY			26
+#define IMX8MQ_RESET_PCIEPHY_PERST		27
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29
+#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30
+#define IMX8MQ_RESET_DISP_RESET			31
+#define IMX8MQ_RESET_GPU_RESET			32
+#define IMX8MQ_RESET_VPU_RESET			33
+#define IMX8MQ_RESET_PCIEPHY2			34
+#define IMX8MQ_RESET_PCIEPHY2_PERST		35
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37
+#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38
+#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39
+#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40
+#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41
+#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42
+#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43
+#define IMX8MQ_RESET_DDRC1_PRST			44
+#define IMX8MQ_RESET_DDRC1_CORE_RESET		45
+#define IMX8MQ_RESET_DDRC1_PHY_RESET		46
+#define IMX8MQ_RESET_DDRC2_PRST			47
+#define IMX8MQ_RESET_DDRC2_CORE_RESET		48
+#define IMX8MQ_RESET_DDRC2_PHY_RESET		49
+
+#define IMX8MQ_RESET_NUM			50
+
+#endif
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
