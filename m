Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69DC2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PB6B7p73";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knPpRNPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69DC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ghZJo6ZiZ/y0HJzz7JWgGmJPkoa0xc2CP+Pm+q39pKY=; b=PB6B7p73rFOW0B
	7M02EMhW5eBCN3u7G3+wHuEgz31YJUe0cw3OnQycOAKZpKOdmgUYiav39rqvcDEqtNTx9JS89Dczl
	RaXyq+f863fCpRNRgGaRppNdoBB2sKzGOHjUMHApdkH4pmnbfd1OLbOahNgXDfMbg2EZEtJ0JET88
	GEWIgvXUelrH2A9XOQ4W7AmVRbTxXCOxswVBmdY/6Kt073D7N/pIFaDwSmv8LWnaT9LVaQhrZXj/A
	W/I1VGh5XRYHCtLCrgfkJB5lmQublOJygv7SQ3eNmqC3+cXTz2Yh/vNRt8QGwjHlpqtF1EpIaWArN
	sNWcllLVRQlzPE/pPowQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZmp1-0005w7-7v; Thu, 20 Dec 2018 01:08:19 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZmoJ-0005HX-Rx
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 01:07:45 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so38221pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eDj9Bbt2oCf40baWi7GsmAunPoJ7bQGVVCa01DH/lM=;
 b=knPpRNPve/QpAk838saOm0fzqBMDJZUpf9ZwdhpSbcqX1+2m6ewzdTVo7P0Pkh5R8s
 prneLkG9ohhukGXVYDYumezv99MF4Jb+dO9aJ0ucF+LpsSesZXYf929WmdGi+AgwVI7G
 wkDZKarPWboOwmQlSgrYKl8fI4gt1BrzybodmiWB5wDEwlPHjopVYu4hepIqz9MvMR5s
 dSyRN8Z9geJuD6v7nB00lmcbTf2C+O6lsJAM5sXjASoVzey/PlQ4xRSywUW/naG+ymKq
 CsnlFmOdqhpgxOuBEY/b3vURJYVidVXI3xPaioHeCzqrKVDsPZDn9YQCoBEBAlWu4cZT
 iuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eDj9Bbt2oCf40baWi7GsmAunPoJ7bQGVVCa01DH/lM=;
 b=oVgmvBUyl2kr+8Rn2lznX932kRfVxEAdQTaQyzjuceVrjWdto9fw8yoBsFDMo5SwNY
 r4M5kvnOEl2b34IbyCFgw5HkQsF+4ImZEv924NFh/thvYUwKVLIDGGFvC2nnSQ/frew7
 PikR37lAtYU2TiDFhu5gIfSylBt/32rG3Q9Lxyl7+AYCYxNJ70wsiCrFfdGeT75x8gIq
 LhQYrrLMePY1ZBMH+vO/WuMmPWXjp5nyKsZoQ2BzndORmBpPq6+55i6b5lH75uAB4hBX
 j8NhmczoffTygRyc151JHGCcvERrVNkYm6ecZOS73PVyi88WnkQkyQCsXVKw7bf7q1m0
 pRWQ==
X-Gm-Message-State: AA+aEWb/Vywe4YbjLdiCXNACcitG4JuoPCBcAHkLWxddSka19oHQ5qHQ
 nZlQfdbXfhZ0vCmpqLZse+s=
X-Google-Smtp-Source: AFSGD/Xk4iEb/3kumYvsWax7BIovJuhImdrqNN/gjgnOhxLr/GDDsrxdgU540Fs4qQL43q0ijfx80A==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr23262096pfd.2.1545268044860; 
 Wed, 19 Dec 2018 17:07:24 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 17:07:24 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v4 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
Date: Wed, 19 Dec 2018 17:07:00 -0800
Message-Id: <20181220010700.8598-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_170736_359069_B8D2CC39 
X-CRM114-Status: GOOD (  18.22  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add bits and pieces needed to support IP block variant found on
i.MX8MQ SoCs.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/Kconfig      |   4 +-
 drivers/reset/reset-imx7.c | 106 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c21da9fe51ec..add84b523be1 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -48,9 +48,9 @@ config RESET_HSDK
 	  This enables the reset controller driver for HSDK board.
 
 config RESET_IMX7
-	bool "i.MX7 Reset Driver" if COMPILE_TEST
+	bool "i.MX7/8 Reset Driver" if COMPILE_TEST
 	depends on HAS_IOMEM
-	default SOC_IMX7D
+	default SOC_IMX7D || (ARM64 && ARCH_MXC)
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 3a36d5863891..bb826935db6d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -22,6 +22,7 @@
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 
 struct imx7_src_signal {
 	unsigned int offset, bit;
@@ -113,6 +114,110 @@ static const struct imx7_src_variant variant_imx7 = {
 	.prepare = imx7_src_prepare,
 };
 
+enum imx8mq_src_registers {
+	SRC_A53RCR0		= 0x0004,
+	SRC_HDMI_RCR		= 0x0030,
+	SRC_DISP_RCR		= 0x0034,
+	SRC_GPU_RCR		= 0x0040,
+	SRC_VPU_RCR		= 0x0044,
+	SRC_PCIE2_RCR		= 0x0048,
+	SRC_MIPIPHY1_RCR	= 0x004c,
+	SRC_MIPIPHY2_RCR	= 0x0050,
+	SRC_DDRC2_RCR		= 0x1004,
+};
+
+static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
+	[IMX8MQ_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET2]	= { SRC_A53RCR0, BIT(2) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET3]	= { SRC_A53RCR0, BIT(3) },
+	[IMX8MQ_RESET_A53_CORE_RESET0]		= { SRC_A53RCR0, BIT(4) },
+	[IMX8MQ_RESET_A53_CORE_RESET1]		= { SRC_A53RCR0, BIT(5) },
+	[IMX8MQ_RESET_A53_CORE_RESET2]		= { SRC_A53RCR0, BIT(6) },
+	[IMX8MQ_RESET_A53_CORE_RESET3]		= { SRC_A53RCR0, BIT(7) },
+	[IMX8MQ_RESET_A53_DBG_RESET0]		= { SRC_A53RCR0, BIT(8) },
+	[IMX8MQ_RESET_A53_DBG_RESET1]		= { SRC_A53RCR0, BIT(9) },
+	[IMX8MQ_RESET_A53_DBG_RESET2]		= { SRC_A53RCR0, BIT(10) },
+	[IMX8MQ_RESET_A53_DBG_RESET3]		= { SRC_A53RCR0, BIT(11) },
+	[IMX8MQ_RESET_A53_ETM_RESET0]		= { SRC_A53RCR0, BIT(12) },
+	[IMX8MQ_RESET_A53_ETM_RESET1]		= { SRC_A53RCR0, BIT(13) },
+	[IMX8MQ_RESET_A53_ETM_RESET2]		= { SRC_A53RCR0, BIT(14) },
+	[IMX8MQ_RESET_A53_ETM_RESET3]		= { SRC_A53RCR0, BIT(15) },
+	[IMX8MQ_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
+	[IMX8MQ_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
+	[IMX8MQ_RESET_SW_NON_SCLR_M4C_RST]	= { SRC_M4RCR, BIT(0) },
+	[IMX8MQ_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
+	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
+	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
+	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
+	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
+						    BIT(2) | BIT(1) },
+	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
+	[IMX8MQ_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
+	[IMX8MQ_RESET_DISP_RESET]		= { SRC_DISP_RCR, BIT(0) },
+	[IMX8MQ_RESET_GPU_RESET]		= { SRC_GPU_RCR, BIT(0) },
+	[IMX8MQ_RESET_VPU_RESET]		= { SRC_VPU_RCR, BIT(0) },
+	[IMX8MQ_RESET_PCIEPHY2]			= { SRC_PCIE2_RCR,
+						    BIT(2) | BIT(1) },
+	[IMX8MQ_RESET_PCIEPHY2_PERST]		= { SRC_PCIE2_RCR, BIT(3) },
+	[IMX8MQ_RESET_PCIE2_CTRL_APPS_EN]	= { SRC_PCIE2_RCR, BIT(6) },
+	[IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF]	= { SRC_PCIE2_RCR, BIT(11) },
+	[IMX8MQ_RESET_MIPI_CSI1_CORE_RESET]	= { SRC_MIPIPHY1_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET]	= { SRC_MIPIPHY1_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_CSI1_ESC_RESET]	= { SRC_MIPIPHY1_RCR, BIT(2) },
+	[IMX8MQ_RESET_MIPI_CSI2_CORE_RESET]	= { SRC_MIPIPHY2_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET]	= { SRC_MIPIPHY2_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_CSI2_ESC_RESET]	= { SRC_MIPIPHY2_RCR, BIT(2) },
+	[IMX8MQ_RESET_DDRC1_PRST]		= { SRC_DDRC_RCR, BIT(0) },
+	[IMX8MQ_RESET_DDRC1_CORE_RESET]		= { SRC_DDRC_RCR, BIT(1) },
+	[IMX8MQ_RESET_DDRC1_PHY_RESET]		= { SRC_DDRC_RCR, BIT(2) },
+	[IMX8MQ_RESET_DDRC2_PHY_RESET]		= { SRC_DDRC2_RCR, BIT(0) },
+	[IMX8MQ_RESET_DDRC2_CORE_RESET]		= { SRC_DDRC2_RCR, BIT(1) },
+	[IMX8MQ_RESET_DDRC2_PRST]		= { SRC_DDRC2_RCR, BIT(2) },
+};
+
+static unsigned int
+imx8mq_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
+{
+	const unsigned int bit = imx7src->variant->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
+
+	switch (id) {
+	case IMX8MQ_RESET_PCIEPHY:
+	case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
+		/*
+		 * wait for more than 10us to release phy g_rst and
+		 * btnrst
+		 */
+		if (!assert)
+			udelay(10);
+		break;
+
+	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
+		value = assert ? 0 : bit;
+		break;
+	}
+
+	return value;
+}
+
+static const struct imx7_src_variant variant_imx8mq = {
+	.signals = imx8mq_src_signals,
+	.signals_num = ARRAY_SIZE(imx8mq_src_signals),
+	.prepare = imx8mq_src_prepare,
+};
+
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct imx7_src, rcdev);
@@ -175,6 +280,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
+	{ .compatible = "fsl,imx8mq-src", .data = &variant_imx8mq },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
