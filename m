Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF49EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F39E21A47
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6d5+Hz8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="h24a03GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39E21A47
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Sn1Y+XlnB/U1tuFl+bksENUS1NNcsUZYHxCOpZsabeM=; b=G6d
	5+Hz8nmkoiyWh6GOdu/nzVqVZQUJw2fECGxaez6FTNaH43cZBEgGcpH7wt1vz8MbMQ5ZOAGYqszlt
	CYZkp8nCB3Mxa11quc43cbMYGkflYxW6L49KuQ+wcIFF+lGGFoLzQojkw+tugFCOEL3Tx+tH3qGMa
	J6tL0sERvsILbuGaKnJF/28vrbRV/fkZfgtwz0YZVJ5Gp7TQbWn1gFoGeFYKY/2J+c9zehzHzJa0F
	PDzCuNZ+ayozzI4ywyolSk85jLBsKTUjp3Bu+c8F3MLwKTKKN7Xu2TqoWheFoX/jfFRyS5ZZnjbhM
	ZlPss+4CUgEUNk2qvpP6wle3A4xSeBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaeuw-0001ij-4D; Sat, 22 Dec 2018 10:54:02 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000I2-Mb
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=CQaK6VMBrgwfGl0MU/GfckSQE+1b6kDKoMTGk5aJO/M=; 
 b=h24a03GOxw60hGF0JkNCu0BOMFfrT1AG57/oJfvQtpZ/Al9iwOxNwzPlzuOUrYkI4eTMdgMgNhtsYhNk1Qo+6b7cqRo7dxtqr1FIKIDrOFnG8fj1D24+SMkNVSEfg8vzKXMJ6W0lJY4Qz2jUUYSdsMA6SndBU35yeZi9rTl52hk=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet2-00014B-2V; Sat, 22 Dec 2018 13:52:04 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] ARM: dts: imx21: add i.MX21 SoC device tree
Date: Sat, 22 Dec 2018 13:51:55 +0300
Message-Id: <20181222105200.18502-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31F9CC1A9576710E066F99E3366D06508C1715ED65E5503F9D705A01B18C2C33265
X-7FA49CB5: 0D63561A33F958A5407A2F134D130819857BED211D07E6A3BCCA056EE96095E88941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22493ABEE1F99982DA693AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7CBA14527493D65A1CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7B76F200BB935124242B415E705D398DC75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006866E561C505FCFA4297AF23EEB7B65FE86B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_173124_1B06C114 
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@armlinux.org.uk>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It adds initial device tree support for Freescale i.MX21 SoC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx21-pinfunc.h | 441 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx21.dtsi      | 465 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 906 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx21-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx21.dtsi

diff --git a/arch/arm/boot/dts/imx21-pinfunc.h b/arch/arm/boot/dts/imx21-pinfunc.h
new file mode 100644
index 0000000..6787b23
--- /dev/null
+++ b/arch/arm/boot/dts/imx21-pinfunc.h
@@ -0,0 +1,441 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Author: Alexander Shiyan <shc_work@mail.ru> */
+
+#ifndef __DTS_IMX21_PINFUNC_H
+#define __DTS_IMX21_PINFUNC_H
+
+/*
+ * The pin function ID is a tuple of
+ * <pin mux_id>
+ * mux_id consists of
+ * function + (direction << 2) + (gpio_oconf << 4) + (gpio_iconfa << 8) + (gpio_iconfb << 10)
+ *
+ * function:      0 - Primary function
+ *                1 - Alternate function
+ *                2 - GPIO
+ * direction:     0 - Input
+ *                1 - Output
+ * gpio_oconf:    0 - A_IN
+ *                1 - B_IN
+ *                2 - C_IN
+ *                3 - Data Register
+ * gpio_iconfa/b: 0 - GPIO_IN
+ *                1 - Interrupt Status Register
+ *                2 - 0
+ *                3 - 1
+ *
+ * 'pin' is an integer between 5 and 0xb6. i.MX21 has 6 ports with 32 configurable
+ * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is the pin
+ * number on the specific port (between 0 and 31).
+ */
+
+#define MX21_PAD_LSCLK__LSCLK			0x05 0x004
+#define MX21_PAD_LSCLK__BMI_CLK_CS		0x05 0x001
+#define MX21_PAD_LSCLK__GPIO1_5			0x05 0x032
+#define MX21_PAD_LD0__LD0			0x06 0x004
+#define MX21_PAD_LD0__BMI_D0			0x06 0x001
+#define MX21_PAD_LD0__GPIO1_6			0x06 0x032
+#define MX21_PAD_LD0__SLCDC1_DAT0		0x06 0x006
+#define MX21_PAD_LD1__LD1			0x07 0x004
+#define MX21_PAD_LD1__BMI_D1			0x07 0x001
+#define MX21_PAD_LD1__GPIO1_7			0x07 0x032
+#define MX21_PAD_LD1__SLCDC1_DAT1		0x07 0x006
+#define MX21_PAD_LD2__LD2			0x08 0x004
+#define MX21_PAD_LD2__BMI_D2			0x08 0x001
+#define MX21_PAD_LD2__GPIO1_8			0x08 0x032
+#define MX21_PAD_LD2__SLCDC1_DAT2		0x08 0x006
+#define MX21_PAD_LD3__LD3			0x09 0x004
+#define MX21_PAD_LD3__BMI_D3			0x09 0x001
+#define MX21_PAD_LD3__GPIO1_9			0x09 0x032
+#define MX21_PAD_LD3__SLCDC1_DAT3		0x09 0x006
+#define MX21_PAD_LD4__LD4			0x0a 0x004
+#define MX21_PAD_LD4__BMI_D4			0x0a 0x001
+#define MX21_PAD_LD4__GPIO1_10			0x0a 0x032
+#define MX21_PAD_LD4__SLCDC1_DAT4		0x0a 0x006
+#define MX21_PAD_LD5__LD5			0x0b 0x004
+#define MX21_PAD_LD5__BMI_D5			0x0b 0x001
+#define MX21_PAD_LD5__GPIO1_11			0x0b 0x032
+#define MX21_PAD_LD5__SLCDC1_DAT5		0x0b 0x006
+#define MX21_PAD_LD6__LD6			0x0c 0x004
+#define MX21_PAD_LD6__BMI_D6			0x0c 0x001
+#define MX21_PAD_LD6__GPIO1_12			0x0c 0x032
+#define MX21_PAD_LD6__SLCDC1_DAT6		0x0c 0x006
+#define MX21_PAD_LD7__LD7			0x0d 0x004
+#define MX21_PAD_LD7__BMI_D7			0x0d 0x001
+#define MX21_PAD_LD7__GPIO1_13			0x0d 0x032
+#define MX21_PAD_LD7__SLCDC1_DAT7		0x0d 0x006
+#define MX21_PAD_LD8__LD8			0x0e 0x004
+#define MX21_PAD_LD8__BMI_D8			0x0e 0x001
+#define MX21_PAD_LD8__GPIO1_14			0x0e 0x032
+#define MX21_PAD_LD8__SLCDC1_DAT8		0x0e 0x006
+#define MX21_PAD_LD8__SLCDC1_DAT0		0x0e 0x026
+#define MX21_PAD_LD9__LD9			0x0f 0x004
+#define MX21_PAD_LD9__BMI_D9			0x0f 0x001
+#define MX21_PAD_LD9__GPIO1_15			0x0f 0x032
+#define MX21_PAD_LD9__SLCDC1_DAT9		0x0f 0x006
+#define MX21_PAD_LD9__SLCDC1_DAT1		0x0f 0x026
+#define MX21_PAD_LD10__LD10			0x10 0x004
+#define MX21_PAD_LD10__BMI_D10			0x10 0x001
+#define MX21_PAD_LD10__GPIO1_16			0x10 0x032
+#define MX21_PAD_LD10__SLCDC1_DAT10		0x10 0x006
+#define MX21_PAD_LD10__SLCDC1_DAT2		0x10 0x026
+#define MX21_PAD_LD11__LD11			0x11 0x004
+#define MX21_PAD_LD11__BMI_D11			0x11 0x001
+#define MX21_PAD_LD11__GPIO1_17			0x11 0x032
+#define MX21_PAD_LD11__SLCDC1_DAT11		0x11 0x006
+#define MX21_PAD_LD11__SLCDC1_DAT3		0x11 0x026
+#define MX21_PAD_LD12__LD12			0x12 0x004
+#define MX21_PAD_LD12__BMI_D12			0x12 0x001
+#define MX21_PAD_LD12__GPIO1_18			0x12 0x032
+#define MX21_PAD_LD12__SLCDC1_DAT12		0x12 0x006
+#define MX21_PAD_LD12__SLCDC1_DAT4		0x12 0x026
+#define MX21_PAD_LD13__LD13			0x13 0x004
+#define MX21_PAD_LD13__BMI_D13			0x13 0x001
+#define MX21_PAD_LD13__GPIO1_19			0x13 0x032
+#define MX21_PAD_LD13__SLCDC1_DAT13		0x13 0x006
+#define MX21_PAD_LD13__SLCDC1_DAT5		0x13 0x026
+#define MX21_PAD_LD14__LD14			0x14 0x004
+#define MX21_PAD_LD14__BMI_D14			0x14 0x001
+#define MX21_PAD_LD14__GPIO1_20			0x14 0x032
+#define MX21_PAD_LD14__SLCDC1_DAT14		0x14 0x006
+#define MX21_PAD_LD14__SLCDC1_DAT6		0x14 0x026
+#define MX21_PAD_LD15__LD15			0x15 0x004
+#define MX21_PAD_LD15__BMI_D15			0x15 0x001
+#define MX21_PAD_LD15__GPIO1_21			0x15 0x032
+#define MX21_PAD_LD15__SLCDC1_DAT15		0x15 0x006
+#define MX21_PAD_LD15__SLCDC1_DAT7		0x15 0x026
+#define MX21_PAD_LD16__LD16			0x16 0x004
+#define MX21_PAD_LD16__BMI_READ_REQ		0x16 0x005
+#define MX21_PAD_LD16__GPIO1_22			0x16 0x032
+#define MX21_PAD_LD15__EXT_DMAGRANT		0x16 0x006
+#define MX21_PAD_LD17__LD17			0x17 0x004
+#define MX21_PAD_LD17__BMI_WRITE		0x17 0x001
+#define MX21_PAD_LD17__GPIO1_23			0x17 0x032
+#define MX21_PAD_REV__REV			0x18 0x004
+#define MX21_PAD_REV__GPIO1_24			0x18 0x032
+#define MX21_PAD_REV__SLCDC1_D0			0x18 0x006
+#define MX21_PAD_CLS__CLS			0x19 0x004
+#define MX21_PAD_CLS__GPIO1_25			0x19 0x032
+#define MX21_PAD_CLS__SLCDC1_RS			0x19 0x006
+#define MX21_PAD_PS__PS				0x1a 0x004
+#define MX21_PAD_PS__GPIO1_26			0x1a 0x032
+#define MX21_PAD_PS__SLCDC1_CS			0x1a 0x006
+#define MX21_PAD_SPL_SPR__SPL_SPR		0x1b 0x004
+#define MX21_PAD_SPL_SPR__GPIO1_27		0x1b 0x032
+#define MX21_PAD_SPL_SPR__SLCDC1_CLK		0x1b 0x006
+#define MX21_PAD_HSYNC__HSYNC			0x1c 0x004
+#define MX21_PAD_HSYNC__GPIO1_28		0x1c 0x032
+#define MX21_PAD_VSYNC__VSYNC			0x1d 0x004
+#define MX21_PAD_VSYNC__BMI_RXF_FULL		0x1d 0x005
+#define MX21_PAD_VSYNC__GPIO1_29		0x1d 0x032
+#define MX21_PAD_VSYNC__BMI_WAIT		0x1d 0x002
+#define MX21_PAD_CONTRAST__CONTRAST		0x1e 0x004
+#define MX21_PAD_CONTRAST__BMI_READ		0x1e 0x005
+#define MX21_PAD_CONTRAST__GPIO1_30		0x1e 0x032
+#define MX21_PAD_OE_ACD__OE_ACD			0x1f 0x004
+#define MX21_PAD_OE_ACD__GPIO1_31		0x1f 0x032
+#define MX21_PAD_SD2_D0__SD2_D0			0x24 0x000
+#define MX21_PAD_SD2_D0__GPIO2_4		0x24 0x032
+#define MX21_PAD_SD2_D1__SD2_D1			0x25 0x000
+#define MX21_PAD_SD2_D1__GPIO2_5		0x25 0x032
+#define MX21_PAD_SD2_D2__SD2_D2			0x26 0x000
+#define MX21_PAD_SD2_D2__GPIO2_6		0x26 0x032
+#define MX21_PAD_SD2_D2__SLCDC1_D0		0x26 0x006
+#define MX21_PAD_SD2_D3__SD2_D3			0x27 0x000
+#define MX21_PAD_SD2_D3__GPIO2_7		0x27 0x032
+#define MX21_PAD_SD2_D3__SLCDC1_RS		0x27 0x006
+#define MX21_PAD_SD2_CMD__SD2_CMD		0x28 0x000
+#define MX21_PAD_SD2_CMD__GPIO2_8		0x28 0x032
+#define MX21_PAD_SD2_CMD__SLCDC1_CS		0x28 0x006
+#define MX21_PAD_SD2_CLK__SD2_CLK		0x29 0x004
+#define MX21_PAD_SD2_CLK__GPIO2_9		0x29 0x032
+#define MX21_PAD_SD2_CLK__SLCDC1_CLK		0x29 0x006
+#define MX21_PAD_CSI_D0__CSI_D0			0x2a 0x000
+#define MX21_PAD_CSI_D0__GPIO2_10		0x2a 0x032
+#define MX21_PAD_CSI_D1__CSI_D1			0x2b 0x000
+#define MX21_PAD_CSI_D1__GPIO2_11		0x2b 0x032
+#define MX21_PAD_CSI_D2__CSI_D2			0x2c 0x000
+#define MX21_PAD_CSI_D2__GPIO2_12		0x2c 0x032
+#define MX21_PAD_CSI_D3__CSI_D3			0x2d 0x000
+#define MX21_PAD_CSI_D3__GPIO2_13		0x2d 0x032
+#define MX21_PAD_CSI_D4__CSI_D4			0x2e 0x000
+#define MX21_PAD_CSI_D4__GPIO2_14		0x2e 0x032
+#define MX21_PAD_CSI_MCLK__CSI_MCLK		0x2f 0x004
+#define MX21_PAD_CSI_MCLK__GPIO2_15		0x2f 0x032
+#define MX21_PAD_CSI_PIXCLK__CSI_PIXCLK		0x30 0x000
+#define MX21_PAD_CSI_PIXCLK__GPIO2_16		0x30 0x032
+#define MX21_PAD_CSI_D5__CSI_D5			0x31 0x000
+#define MX21_PAD_CSI_D5__GPIO2_17		0x31 0x032
+#define MX21_PAD_CSI_D6__CSI_D6			0x32 0x000
+#define MX21_PAD_CSI_D6__GPIO2_18		0x32 0x032
+#define MX21_PAD_CSI_D7__CSI_D7			0x33 0x000
+#define MX21_PAD_CSI_D7__GPIO2_19		0x33 0x032
+#define MX21_PAD_CSI_VSYNC__CSI_VSYNC		0x34 0x000
+#define MX21_PAD_CSI_VSYNC__GPIO2_20		0x34 0x032
+#define MX21_PAD_CSI_HSYNC__CSI_HSYNC		0x35 0x000
+#define MX21_PAD_CSI_HSYNC__GPIO2_21		0x35 0x032
+#define MX21_PAD_USB_BYP__USB_BYP		0x36 0x000
+#define MX21_PAD_USB_BYP__GPIO2_22		0x36 0x032
+#define MX21_PAD_USB_PWR__USB_PWR		0x37 0x004
+#define MX21_PAD_USB_PWR__GPIO2_23		0x37 0x032
+#define MX21_PAD_USB_OC__USB_OC			0x38 0x000
+#define MX21_PAD_USB_OC__GPIO2_24		0x38 0x032
+#define MX21_PAD_USBH_ON__USBH_ON		0x39 0x004
+#define MX21_PAD_USBH_ON__GPIO2_25		0x39 0x032
+#define MX21_PAD_USBH_ON__SLCDC1_DAT0		0x39 0x006
+#define MX21_PAD_USBH1_FS__USBH1_FS		0x3a 0x004
+#define MX21_PAD_USBH1_FS__UART4_RTS		0x3a 0x001
+#define MX21_PAD_USBH1_FS__GPIO2_26		0x3a 0x032
+#define MX21_PAD_USBH1_FS__SLCDC1_DAT1		0x3a 0x006
+#define MX21_PAD_USBH1_FS__USBH1_RXDAT		0x3a 0x026
+#define MX21_PAD_USBH1_OE__USBH1_OE		0x3b 0x000
+#define MX21_PAD_USBH1_OE__GPIO2_27		0x3b 0x032
+#define MX21_PAD_USBH1_OE__SLCDC1_DAT2		0x3b 0x006
+#define MX21_PAD_USBH1_TXDM__USBH1_TXDM		0x3c 0x004
+#define MX21_PAD_USBH1_TXDM__UART4_TXD		0x3c 0x005
+#define MX21_PAD_USBH1_TXDM__GPIO2_28		0x3c 0x032
+#define MX21_PAD_USBH1_TXDM__SLCDC1_DAT3	0x3c 0x006
+#define MX21_PAD_USBH1_TXDP__USBH1_TXDP		0x3d 0x004
+#define MX21_PAD_USBH1_TXDP__UART4_CTS		0x3d 0x005
+#define MX21_PAD_USBH1_TXDP__GPIO2_29		0x3d 0x032
+#define MX21_PAD_USBH1_TXDP__SLCDC1_DAT4	0x3d 0x006
+#define MX21_PAD_USBH1_TXDP__UART4_RXD		0x3d 0x002
+#define MX21_PAD_USBH1_RXDM__USBH1_RXDM		0x3e 0x000
+#define MX21_PAD_USBH1_RXDM__GPIO2_30		0x3e 0x032
+#define MX21_PAD_USBH1_RXDM__SLCDC1_DAT5	0x3e 0x006
+#define MX21_PAD_USBH1_RXDM__UART4_CTS		0x3e 0x026
+#define MX21_PAD_USBH1_RXDP__USBH1_RXDP		0x3f 0x000
+#define MX21_PAD_USBH1_RXDP__UART4_RXD		0x3f 0x001
+#define MX21_PAD_USBH1_RXDP__GPIO2_31		0x3f 0x032
+#define MX21_PAD_USBH1_RXDP__SLCDC1_DAT6	0x3f 0x006
+#define MX21_PAD_USBH1_RXDP__UART4_RTS		0x3f 0x002
+#define MX21_PAD_USBG_SDA__USBG_SDA		0x45 0x000
+#define MX21_PAD_USBG_SDA__GPIO3_5		0x45 0x032
+#define MX21_PAD_USBG_SDA__SLCDC1_DAT7		0x45 0x006
+#define MX21_PAD_USBG_SCL__USBG_SCL		0x46 0x000
+#define MX21_PAD_USBG_SCL__GPIO3_6		0x46 0x032
+#define MX21_PAD_USBG_SCL__SLCDC1_DAT8		0x46 0x006
+#define MX21_PAD_USBG_ON__USBG_ON		0x47 0x004
+#define MX21_PAD_USBG_ON__GPIO3_7		0x47 0x032
+#define MX21_PAD_USBG_ON__SLCDC1_DAT9		0x47 0x006
+#define MX21_PAD_USBG_FS__USBG_FS		0x48 0x004
+#define MX21_PAD_USBG_FS__GPIO3_8		0x48 0x032
+#define MX21_PAD_USBG_FS__SLCDC1_DAT10		0x48 0x006
+#define MX21_PAD_USBG_FS__USBBG_TXR_INT		0x48 0x002
+#define MX21_PAD_USBG_OE__USBG_OE		0x49 0x004
+#define MX21_PAD_USBG_OE__GPIO3_9		0x49 0x032
+#define MX21_PAD_USBG_OE__SLCDC1_DAT11		0x49 0x006
+#define MX21_PAD_USBG_TXDM__USBG_TXDM		0x4a 0x004
+#define MX21_PAD_USBG_TXDM__GPIO3_10		0x4a 0x032
+#define MX21_PAD_USBG_TXDM__SLCDC1_DAT12	0x4a 0x006
+#define MX21_PAD_USBG_TXDP__USBG_TXDP		0x4b 0x004
+#define MX21_PAD_USBG_TXDP__GPIO3_11		0x4b 0x032
+#define MX21_PAD_USBG_TXDP__SLCDC1_DAT13	0x4b 0x006
+#define MX21_PAD_USBG_RXDM__USBG_RXDM		0x4c 0x000
+#define MX21_PAD_USBG_RXDM__GPIO3_12		0x4c 0x032
+#define MX21_PAD_USBG_RXDM__SLCDC1_DAT14	0x4c 0x006
+#define MX21_PAD_USBG_RXDP__USBG_RXDP		0x4d 0x000
+#define MX21_PAD_USBG_RXDP__GPIO3_13		0x4d 0x032
+#define MX21_PAD_USBG_RXDP__SLCDC1_DAT15	0x4d 0x006
+#define MX21_PAD_TOUT__TOUT			0x4e 0x004
+#define MX21_PAD_TOUT__GPIO3_14			0x4e 0x032
+#define MX21_PAD_TOUT__SYS_CLK			0x4e 0x006
+#define MX21_PAD_TIN__TIN			0x4f 0x000
+#define MX21_PAD_TIN__GPIO3_15			0x4f 0x032
+#define MX21_PAD_TIN__WKGD			0x4f 0x002
+#define MX21_PAD_SAP_FS__SAP_FS			0x50 0x000
+#define MX21_PAD_SAP_FS__GPIO3_16		0x50 0x032
+#define MX21_PAD_SAP_RXD__SAP_RXD		0x51 0x000
+#define MX21_PAD_SAP_RXD__GPIO3_17		0x51 0x032
+#define MX21_PAD_SAP_TXD__SAP_TXD		0x52 0x000
+#define MX21_PAD_SAP_TXD__GPIO3_18		0x52 0x032
+#define MX21_PAD_SAP_CLK__SAP_CLK		0x53 0x000
+#define MX21_PAD_SAP_CLK__GPIO3_19		0x53 0x032
+#define MX21_PAD_SSI1_FS__SSI1_FS		0x54 0x000
+#define MX21_PAD_SSI1_FS__GPIO3_20		0x54 0x032
+#define MX21_PAD_SSI1_RXD__SSI1_RXD		0x55 0x000
+#define MX21_PAD_SSI1_RXD__GPIO3_21		0x55 0x032
+#define MX21_PAD_SSI1_TXD__SSI1_TXD		0x56 0x000
+#define MX21_PAD_SSI1_TXD__GPIO3_22		0x56 0x032
+#define MX21_PAD_SSI1_CLK__SSI1_CLK		0x57 0x000
+#define MX21_PAD_SSI1_CLK__GPIO3_23		0x57 0x032
+#define MX21_PAD_SSI2_FS__SSI2_FS		0x58 0x000
+#define MX21_PAD_SSI2_FS__GPIO3_24		0x58 0x032
+#define MX21_PAD_SSI2_RXD__SSI2_RXD		0x59 0x000
+#define MX21_PAD_SSI2_RXD__GPIO3_25		0x59 0x032
+#define MX21_PAD_SSI2_TXD__SSI2_TXD		0x5a 0x000
+#define MX21_PAD_SSI2_TXD__GPIO3_26		0x5a 0x032
+#define MX21_PAD_SSI2_CLK__SSI2_CLK		0x5b 0x000
+#define MX21_PAD_SSI2_CLK__GPIO3_27		0x5b 0x032
+#define MX21_PAD_SSI3_FS__SSI3_FS		0x5c 0x000
+#define MX21_PAD_SSI3_FS__SLCDC2_D0		0x5c 0x001
+#define MX21_PAD_SSI3_FS__GPIO3_28		0x5c 0x032
+#define MX21_PAD_SSI3_RXD__SSI3_RXD		0x5d 0x000
+#define MX21_PAD_SSI3_RXD__SLCDC2_RS		0x5d 0x001
+#define MX21_PAD_SSI3_RXD__GPIO3_29		0x5d 0x032
+#define MX21_PAD_SSI3_TXD__SSI3_TXD		0x5e 0x000
+#define MX21_PAD_SSI3_TXD__SLCDC2_CS		0x5e 0x001
+#define MX21_PAD_SSI3_TXD__GPIO3_30		0x5e 0x032
+#define MX21_PAD_SSI3_CLK__SSI3_CLK		0x5f 0x000
+#define MX21_PAD_SSI3_CLK__SLCDC2_CLK		0x5f 0x001
+#define MX21_PAD_SSI3_CLK__GPIO3_31		0x5f 0x032
+#define MX21_PAD_I2C_DATA__I2C_DATA		0x71 0x000
+#define MX21_PAD_I2C_DATA__GPIO4_17		0x71 0x032
+#define MX21_PAD_I2C_CLK__I2C_CLK		0x72 0x000
+#define MX21_PAD_I2C_CLK__GPIO4_18		0x72 0x032
+#define MX21_PAD_CSPI2_SS2__CSPI2_SS2		0x73 0x000
+#define MX21_PAD_CSPI2_SS2__GPIO4_19		0x73 0x032
+#define MX21_PAD_CSPI2_SS2__USBH2_RXDM		0x73 0x002
+#define MX21_PAD_CSPI2_SS1__CSPI2_SS1		0x74 0x000
+#define MX21_PAD_CSPI2_SS1__GPIO4_20		0x74 0x032
+#define MX21_PAD_CSPI2_SS1__USBH2_RXDP		0x74 0x002
+#define MX21_PAD_CSPI2_SS0__CSPI2_SS0		0x75 0x000
+#define MX21_PAD_CSPI2_SS0__USBH2_FS		0x75 0x006
+#define MX21_PAD_CSPI2_SS0__GPIO4_21		0x75 0x032
+#define MX21_PAD_CSPI2_SCLK__CSPI2_SCLK		0x76 0x000
+#define MX21_PAD_CSPI2_SCLK__USBH2_OE		0x76 0x006
+#define MX21_PAD_CSPI2_SCLK__GPIO4_22		0x76 0x032
+#define MX21_PAD_CSPI2_MISO__CSPI2_MISO		0x77 0x000
+#define MX21_PAD_CSPI2_MISO__GPIO4_23		0x77 0x032
+#define MX21_PAD_CSPI2_MISO__USBH2_TXDM		0x77 0x006
+#define MX21_PAD_CSPI2_MOSI__CSPI2_MOSI		0x78 0x000
+#define MX21_PAD_CSPI2_MOSI__GPIO4_24		0x78 0x032
+#define MX21_PAD_CSPI2_MOSI__USBH2_TXDP		0x78 0x006
+#define MX21_PAD_CSPI1_RDY__CSPI1_RDY		0x79 0x000
+#define MX21_PAD_CSPI1_RDY__GPIO4_25		0x79 0x032
+#define MX21_PAD_CSPI1_RDY__EXT_DMAREQ		0x79 0x002
+#define MX21_PAD_CSPI1_SS2__CSPI1_SS2		0x7a 0x000
+#define MX21_PAD_CSPI1_SS2__GPIO4_26		0x7a 0x032
+#define MX21_PAD_CSPI1_SS2__USBG_RXDAT		0x7a 0x002
+#define MX21_PAD_CSPI1_SS1__CSPI1_SS1		0x7b 0x000
+#define MX21_PAD_CSPI1_SS1__GPIO4_27		0x7b 0x032
+#define MX21_PAD_CSPI1_SS1__EXT_DMA_GRANT	0x7b 0x016
+#define MX21_PAD_CSPI1_SS0__CSPI1_SS0		0x7c 0x000
+#define MX21_PAD_CSPI1_SS0__GPIO4_28		0x7c 0x032
+#define MX21_PAD_CSPI1_SCLK__CSPI1_SCLK		0x7d 0x000
+#define MX21_PAD_CSPI1_SCLK__GPIO4_29		0x7d 0x032
+#define MX21_PAD_CSPI1_MISO__CSPI1_MISO		0x7e 0x000
+#define MX21_PAD_CSPI1_MISO__GPIO4_30		0x7e 0x032
+#define MX21_PAD_CSPI1_MOSI__CSPI1_MOSI		0x7f 0x000
+#define MX21_PAD_CSPI1_MOSI__GPIO4_31		0x7f 0x032
+#define MX21_PAD_TEST_WB2__TEST_WB2		0x80 0x000
+#define MX21_PAD_TEST_WB2__KP_COL6		0x80 0x001
+#define MX21_PAD_TEST_WB2__GPIO5_0		0x80 0x032
+#define MX21_PAD_TEST_WB1__TEST_WB1		0x81 0x000
+#define MX21_PAD_TEST_WB1__KP_ROW6		0x81 0x001
+#define MX21_PAD_TEST_WB1__GPIO5_1		0x81 0x032
+#define MX21_PAD_TEST_WB0__TEST_WB0		0x82 0x000
+#define MX21_PAD_TEST_WB0__KP_ROW7		0x82 0x001
+#define MX21_PAD_TEST_WB0__GPIO5_2		0x82 0x032
+#define MX21_PAD_UART2_CTS__UART2_CTS		0x83 0x004
+#define MX21_PAD_UART2_CTS__KP_COL7		0x83 0x001
+#define MX21_PAD_UART2_CTS__GPIO5_3		0x83 0x032
+#define MX21_PAD_UART2_RTS__UART2_RTS		0x84 0x000
+#define MX21_PAD_UART2_RTS__KP_ROW7		0x84 0x001
+#define MX21_PAD_UART2_RTS__GPIO5_4		0x84 0x032
+#define MX21_PAD_PWMO__PWMO			0x85 0x004
+#define MX21_PAD_PWMO__GPIO5_5			0x85 0x032
+#define MX21_PAD_PWMO__PC_SPKOUT		0x85 0x006
+#define MX21_PAD_PWMO__TOUT2			0x85 0x016
+#define MX21_PAD_PWMO__TOUT3			0x85 0x026
+#define MX21_PAD_UART2_TXD__UART2_TXD		0x86 0x004
+#define MX21_PAD_UART2_TXD__KP_COL6		0x86 0x001
+#define MX21_PAD_UART2_TXD__GPIO5_6		0x86 0x032
+#define MX21_PAD_UART2_RXD__UART2_RXD		0x87 0x000
+#define MX21_PAD_UART2_RXD__KP_ROW6		0x87 0x001
+#define MX21_PAD_UART2_RXD__GPIO5_7		0x87 0x032
+#define MX21_PAD_UART3_TXD__UART3_TXD		0x88 0x004
+#define MX21_PAD_UART3_TXD__GPIO5_8		0x88 0x032
+#define MX21_PAD_UART3_TXD__IR_TXD		0x88 0x006
+#define MX21_PAD_UART3_RXD__UART3_RXD		0x89 0x000
+#define MX21_PAD_UART3_RXD__GPIO5_9		0x89 0x032
+#define MX21_PAD_UART3_RXD__IR_RXD		0x89 0x002
+#define MX21_PAD_UART3_CTS__UART3_CTS		0x8a 0x004
+#define MX21_PAD_UART3_CTS__GPIO5_10		0x8a 0x032
+#define MX21_PAD_UART3_RTS__UART3_RTS		0x8b 0x000
+#define MX21_PAD_UART3_RTS__GPIO5_11		0x8b 0x032
+#define MX21_PAD_UART1_TXD__UART1_TXD		0x8c 0x004
+#define MX21_PAD_UART1_TXD__GPIO5_12		0x8c 0x032
+#define MX21_PAD_UART1_RXD__UART1_RXD		0x8d 0x000
+#define MX21_PAD_UART1_RXD__GPIO5_13		0x8d 0x032
+#define MX21_PAD_UART1_CTS__UART1_CTS		0x8e 0x004
+#define MX21_PAD_UART1_CTS__GPIO5_14		0x8e 0x032
+#define MX21_PAD_UART1_RTS__UART1_RTS		0x8f 0x000
+#define MX21_PAD_UART1_RTS__GPIO5_15		0x8f 0x032
+#define MX21_PAD_RTCK__RTCK			0x90 0x004
+#define MX21_PAD_RTCK__OWIRE			0x90 0x001
+#define MX21_PAD_RTCK__GPIO5_16			0x90 0x032
+#define MX21_PAD_RESET_OUT__RESET_OUT		0x91 0x004
+#define MX21_PAD_RESET_OUT__GPIO5_17		0x91 0x032
+#define MX21_PAD_SD1_D0__SD1_D0			0x92 0x000
+#define MX21_PAD_SD1_D0__CSPI3_MISO		0x92 0x001
+#define MX21_PAD_SD1_D0__GPIO5_18		0x92 0x032
+#define MX21_PAD_SD1_D1__SD1_D1			0x93 0x000
+#define MX21_PAD_SD1_D1__GPIO5_19		0x93 0x032
+#define MX21_PAD_SD1_D2__SD1_D2			0x94 0x000
+#define MX21_PAD_SD1_D2__GPIO5_20		0x94 0x032
+#define MX21_PAD_SD1_D3__SD1_D3			0x95 0x000
+#define MX21_PAD_SD1_D3__CSPI3_SS		0x95 0x005
+#define MX21_PAD_SD1_D3__GPIO5_21		0x95 0x032
+#define MX21_PAD_SD1_CMD__SD1_CMD		0x96 0x000
+#define MX21_PAD_SD1_CMD__CSPI3_MOSI		0x96 0x005
+#define MX21_PAD_SD1_CMD__GPIO5_22		0x96 0x032
+#define MX21_PAD_SD1_CLK__SD1_CLK		0x97 0x004
+#define MX21_PAD_SD1_CLK__CSPI3_SCLK		0x97 0x005
+#define MX21_PAD_SD1_CLK__GPIO5_23		0x97 0x032
+#define MX21_PAD_NFRB__NFRB			0xa0 0x000
+#define MX21_PAD_NFRB__GPIO6_0			0xa0 0x032
+#define MX21_PAD_NFRB__PC_RST			0xa0 0x006
+#define MX21_PAD_NFCE__NFCE			0xa1 0x004
+#define MX21_PAD_NFCE__GPIO6_1			0xa1 0x032
+#define MX21_PAD_NFCE__PC_CE1			0xa1 0x006
+#define MX21_PAD_NFWP__NFWP			0xa2 0x004
+#define MX21_PAD_NFWP__GPIO6_2			0xa2 0x032
+#define MX21_PAD_NFWP__PC_CE2			0xa2 0x006
+#define MX21_PAD_NFCLE__NFCLE			0xa3 0x004
+#define MX21_PAD_NFCLE__GPIO6_3			0xa3 0x032
+#define MX21_PAD_NFCLE__PC_POE			0xa3 0x006
+#define MX21_PAD_NFALE__NFALE			0xa4 0x004
+#define MX21_PAD_NFALE__GPIO6_4			0xa4 0x032
+#define MX21_PAD_NFALE__PC_OE			0xa4 0x006
+#define MX21_PAD_NFRE__NFRE			0xa5 0x004
+#define MX21_PAD_NFRE__GPIO6_5			0xa5 0x032
+#define MX21_PAD_NFRE__PC_RW			0xa5 0x006
+#define MX21_PAD_NFWE__NFWE			0xa6 0x004
+#define MX21_PAD_NFWE__GPIO6_6			0xa6 0x032
+#define MX21_PAD_NFWE__PC_BVD2			0xa6 0x002
+#define MX21_PAD_NFIO0__NFIO0			0xa7 0x000
+#define MX21_PAD_NFIO0__GPIO6_7			0xa7 0x032
+#define MX21_PAD_NFIO0__PC_BVD2			0xa7 0x002
+#define MX21_PAD_NFIO1__NFIO1			0xa8 0x000
+#define MX21_PAD_NFIO1__GPIO6_8			0xa8 0x032
+#define MX21_PAD_NFIO1__PC_VS2			0xa8 0x002
+#define MX21_PAD_NFIO2__NFIO2			0xa9 0x000
+#define MX21_PAD_NFIO2__GPIO6_9			0xa9 0x032
+#define MX21_PAD_NFIO2__PC_VS1			0xa9 0x002
+#define MX21_PAD_NFIO3__NFIO3			0xaa 0x004
+#define MX21_PAD_NFIO3__GPIO6_10		0xaa 0x032
+#define MX21_PAD_NFIO3__PC_WP			0xaa 0x002
+#define MX21_PAD_NFIO4__NFIO4			0xab 0x000
+#define MX21_PAD_NFIO4__GPIO6_11		0xab 0x032
+#define MX21_PAD_NFIO4__PC_READY		0xab 0x002
+#define MX21_PAD_NFIO5__NFIO5			0xac 0x000
+#define MX21_PAD_NFIO5__GPIO6_12		0xac 0x032
+#define MX21_PAD_NFIO5__PC_WAIT			0xac 0x002
+#define MX21_PAD_NFIO6__NFIO6			0xad 0x000
+#define MX21_PAD_NFIO6__GPIO6_13		0xad 0x032
+#define MX21_PAD_NFIO6__PC_CD2			0xad 0x002
+#define MX21_PAD_NFIO7__NFIO7			0xae 0x000
+#define MX21_PAD_NFIO7__GPIO6_14		0xae 0x032
+#define MX21_PAD_NFIO7__PC_CD1			0xae 0x002
+#define MX21_PAD_CLKO__CLKO			0xaf 0x004
+#define MX21_PAD_CLKO__GPIO6_15			0xaf 0x032
+#define MX21_PAD_RESERVED__RESERVED		0xb0 0x000
+#define MX21_PAD_RESERVED__GPIO6_16		0xb0 0x032
+#define MX21_PAD_CS4__CS4			0xb5 0x004
+#define MX21_PAD_CS4__GPIO6_21			0xb5 0x032
+#define MX21_PAD_CS4__DTACK			0xb5 0x002
+#define MX21_PAD_CS5__CS5			0xb6 0x004
+#define MX21_PAD_CS5__GPIO6_22			0xb6 0x032
+
+#endif
diff --git a/arch/arm/boot/dts/imx21.dtsi b/arch/arm/boot/dts/imx21.dtsi
new file mode 100644
index 0000000..e2f09dd
--- /dev/null
+++ b/arch/arm/boot/dts/imx21.dtsi
@@ -0,0 +1,465 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Author: Alexander Shiyan <shc_work@mail.ru> */
+
+#include "imx21-pinfunc.h"
+
+#include <dt-bindings/clock/imx21-clock.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {};
+
+	memory {
+		device_type = "memory";
+	};
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		gpio5 = &gpio6;
+		i2c0 = &i2c;
+		serial0 = &serial1;
+		serial1 = &serial2;
+		serial2 = &serial3;
+		serial3 = &serial4;
+		spi0 = &cspi1;
+		spi1 = &cspi2;
+		spi2 = &cspi3;
+	};
+
+	aitc: aitc-interrupt-controller@10040000 {
+		compatible = "fsl,imx21-aitc", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x10040000 0x1000>;
+	};
+
+	clocks {
+		clk_ckil: ckil {
+			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		clk_ckih: ckih {
+			compatible = "fsl,imx-ckih", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+	};
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu: cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			compatible = "arm,arm926ej-s";
+			operating-points = <266000 1550000>;
+			clock-latency = <62500>;
+			clocks = <&clks IMX21_CLK_FCLK>;
+			voltage-tolerance = <6>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&aitc>;
+		ranges;
+
+		aipi1: aipi@10000000 {
+			compatible = "fsl,aipi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x10000000 0x20000>;
+			ranges;
+
+			dma: dma@10001000 {
+				compatible = "fsl,imx21-dma";
+				reg = <0x10001000 0x1000>;
+				interrupts = <32>;
+				clocks = <&clks IMX21_CLK_DMA_GATE>,
+					 <&clks IMX21_CLK_DMA_HCLK_GATE>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <1>;
+				#dma-channels = <16>;
+			};
+
+			wdog: wdog@10002000 {
+				compatible = "fsl,imx21-wdt";
+				reg = <0x10002000 0x1000>;
+				interrupts = <27>;
+				clocks = <&clks IMX21_CLK_WDOG_GATE>;
+			};
+
+			gpt1: timer@10003000 {
+				compatible = "fsl,imx21-gpt";
+				reg = <0x10003000 0x1000>;
+				interrupts = <26>;
+				clocks = <&clks IMX21_CLK_GPT1_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+			};
+
+			gpt2: timer@10004000 {
+				compatible = "fsl,imx21-gpt";
+				reg = <0x10004000 0x1000>;
+				interrupts = <25>;
+				clocks = <&clks IMX21_CLK_GPT2_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+			};
+
+			gpt3: timer@10005000 {
+				compatible = "fsl,imx21-gpt";
+				reg = <0x10005000 0x1000>;
+				interrupts = <24>;
+				clocks = <&clks IMX21_CLK_GPT3_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+			};
+
+			pwm: pwm@10006000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx21-pwm", "fsl,imx1-pwm";
+				reg = <0x10006000 0x1000>;
+				interrupts = <23>;
+				clocks = <&clks IMX21_CLK_PWM_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+			};
+
+			rtc: rtc@10007000 {
+				compatible = "fsl,imx21-rtc";
+				reg = <0x10007000 0x1000>;
+				interrupts = <22>;
+				clocks = <&clks IMX21_CLK_CKIL>,
+					 <&clks IMX21_CLK_RTC_GATE>;
+				clock-names = "ref", "ipg";
+			};
+
+			kpp: kpp@10008000 {
+				compatible = "fsl,imx21-kpp";
+				reg = <0x10008000 0x1000>;
+				interrupts = <21>;
+				clocks = <&clks IMX21_CLK_KPP_GATE>;
+				status = "disabled";
+			};
+
+			owire: owire@10009000 {
+				compatible = "fsl,imx21-owire";
+				reg = <0x10009000 0x1000>;
+				clocks = <&clks IMX21_CLK_OWIRE_GATE>;
+				status = "disabled";
+			};
+
+			serial1: serial@1000a000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x1000a000 0x1000>;
+				interrupts = <20>;
+				clocks = <&clks IMX21_CLK_UART1_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 26>, <&dma 27>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			serial2: serial@1000b000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x1000b000 0x1000>;
+				interrupts = <19>;
+				clocks = <&clks IMX21_CLK_UART2_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 24>, <&dma 25>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			serial3: serial@1000c000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x1000c000 0x1000>;
+				interrupts = <18>;
+				clocks = <&clks IMX21_CLK_UART3_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 22>, <&dma 23>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			serial4: serial@1000d000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x1000d000 0x1000>;
+				interrupts = <17>;
+				clocks = <&clks IMX21_CLK_UART4_IPG_GATE>,
+					 <&clks IMX21_CLK_PER1>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 20>, <&dma 21>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			cspi1: spi@1000e000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx21-cspi";
+				reg = <0x1000e000 0x1000>;
+				interrupts = <16>;
+				clocks = <&clks IMX21_CLK_CSPI1_IPG_GATE>,
+					 <&clks IMX21_CLK_PER2>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 18>, <&dma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			cspi2: spi@1000f000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx21-cspi";
+				reg = <0x1000f000 0x1000>;
+				interrupts = <15>;
+				clocks = <&clks IMX21_CLK_CSPI2_IPG_GATE>,
+					 <&clks IMX21_CLK_PER2>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 16>, <&dma 17>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			ssi1: ssi@10010000 {
+				#sound-dai-cells = <0>;
+				compatible ="fsl,imx21-ssi";
+				reg = <0x10010000 0x1000>;
+				interrupts = <14>;
+				clocks = <&clks IMX21_CLK_SSI1_BAUD_GATE>;
+				dmas = <&dma 12>, <&dma 13>, <&dma 14>, <&dma 15>;
+				dma-names = "rx0", "tx0", "rx1", "tx1";
+				fsl,fifo-depth = <8>;
+				status = "disabled";
+			};
+
+			ssi2: ssi@10011000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx21-ssi";
+				reg = <0x10011000 0x1000>;
+				interrupts = <13>;
+				clocks = <&clks IMX21_CLK_SSI2_BAUD_GATE>;
+				dmas = <&dma 8>, <&dma 9>, <&dma 10>, <&dma 11>;
+				dma-names = "rx0", "tx0", "rx1", "tx1";
+				fsl,fifo-depth = <8>;
+				status = "disabled";
+			};
+
+			i2c: i2c@10012000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx21-i2c";
+				reg = <0x10012000 0x1000>;
+				interrupts = <12>;
+				clocks = <&clks IMX21_CLK_I2C_GATE>;
+				status = "disabled";
+			};
+
+			sdhci1: sdhci@10013000 {
+				compatible = "fsl,imx21-mmc";
+				reg = <0x10013000 0x1000>;
+				interrupts = <11>;
+				clocks = <&clks IMX21_CLK_SDHC1_IPG_GATE>,
+					 <&clks IMX21_CLK_PER2>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 7>;
+				dma-names = "rx-tx";
+				bus-width = <4>;
+				status = "disabled";
+			};
+
+			sdhci2: sdhci@10014000 {
+				compatible = "fsl,imx21-mmc";
+				reg = <0x10014000 0x1000>;
+				interrupts = <10>;
+				clocks = <&clks IMX21_CLK_SDHC2_IPG_GATE>,
+					 <&clks IMX21_CLK_PER2>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 6>;
+				dma-names = "rx-tx";
+				bus-width = <4>;
+				status = "disabled";
+			};
+
+			iomuxc: iomuxc@10015000 {
+				compatible = "fsl,imx27-iomuxc";
+				reg = <0x10015000 0x600>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				gpio1: gpio@10015000 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015000 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio2: gpio@10015100 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015100 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio3: gpio@10015200 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015200 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio4: gpio@10015300 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015300 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio5: gpio@10015400 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015400 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio6: gpio@10015500 {
+					compatible = "fsl,imx21-gpio";
+					reg = <0x10015500 0x100>;
+					clocks = <&clks IMX21_CLK_GPIO_GATE>;
+					interrupts = <8>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+			};
+
+			audmux: audmux@10016000 {
+				compatible = "fsl,imx21-audmux";
+				reg = <0x10016000 0x1000>;
+				clocks = <&clks IMX21_CLK_DUMMY>;
+				clock-names = "audmux";
+				status = "disabled";
+			};
+
+			cspi3: spi@10017000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx21-cspi";
+				reg = <0x10017000 0x1000>;
+				interrupts = <6>;
+				clocks = <&clks IMX21_CLK_CSPI3_IPG_GATE>,
+					 <&clks IMX21_CLK_PER2>;
+				clock-names = "ipg", "per";
+				dmas = <&dma 1>, <&dma 2>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+		};
+
+		aipi2: aipi@10020000 {
+			compatible = "fsl,aipi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x10020000 0x20000>;
+			ranges;
+
+
+			fb: lcdc@10021000 {
+				compatible = "fsl,imx21-fb";
+				interrupts = <61>;
+				reg = <0x10021000 0x1000>;
+				clocks = <&clks IMX21_CLK_LCDC_IPG_GATE>,
+					 <&clks IMX21_CLK_LCDC_HCLK_GATE>,
+					 <&clks IMX21_CLK_PER3>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			emmaprp: emmaprp@10026400 {
+				compatible = "fsl,imx21-emmaprp";
+				reg = <0x10026400 0x100>;
+				interrupts = <51>;
+				clocks = <&clks IMX21_CLK_EMMA_GATE>,
+					 <&clks IMX21_CLK_EMMA_HCLK_GATE>;
+				clock-names = "ipg", "ahb";
+				status = "disabled";
+			};
+
+			clks: ccm@10027000{
+				compatible = "fsl,imx21-ccm";
+				reg = <0x10027000 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		eim: eim@df001000 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "fsl,imx21-weim", "fsl,imx1-weim";
+			reg = <0xdf001000 0x1000>;
+			clocks = <&clks IMX21_CLK_HCLK>;
+			ranges = <
+				0 0 0xc8000000 0x04000000
+				1 0 0xcc000000 0x04000000
+				2 0 0xd0000000 0x01000000
+				3 0 0xd1000000 0x01000000
+				4 0 0xd2000000 0x01000000
+				5 0 0xd3000000 0x01000000
+			>;
+			status = "disabled";
+		};
+
+		nandfc: nand@df003000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,imx21-nand";
+			reg = <0xdf003000 0x1000>;
+			interrupts = <29>;
+			clocks = <&clks IMX21_CLK_NFC_GATE>;
+			status = "disabled";
+		};
+
+		vram: vram@ffffe800 {
+			compatible = "mmio-sram";
+			reg = <0xffffe800 0x1800>;
+		};
+	};
+};
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
