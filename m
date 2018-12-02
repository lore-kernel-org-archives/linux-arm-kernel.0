Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CBC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185762081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhyY1M57";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTOqwNkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185762081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pr/IQh+7Mkh8DDL0Y9YnAIelNGyq9PIxhR50TcDoVJE=; b=LhyY1M57ucVVtr
	hKm9Cvk7E+V6XVUmIp1Nv3fYvFJHghexQ1+xnxdJnIiXHMvf1Hpgr5oxEMFSVAiUkRKdTrfKDDGGS
	SyZFChoGUDR99yS3xuzjnxUSAUsbjWfQCcdy6Mf0/CAZh5Ct1UlgWB6N4z+JtbNshwX2xDhy9jfQe
	+nDpQTk70ZPvo5Qy+zIUOe3QEHeW+RjYUHnV+hUS51tPQ1JYuYl6bAG3SeujpIG0Ldqj5bZwelRTX
	tF0yZERuus4iuZOnhGOXyizDV6xCYNCk64V+zuj7EDNfwlss8CT1na5gUG0S4L/6DJWANjnOkHcqL
	bsGaB5QyzvuT+epa6DZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZVg-0003yS-Hp; Sun, 02 Dec 2018 21:42:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZVe-0003wX-FZ
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 21:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fGEc1kNsVdjialDo7Zh7TuJC/qFAJNtJfYxwQMewdeo=; b=FTOqwNkFS1L4TfTuiSQQU10TqM
 PogXqF5cBdtdW3lbMZGd/QkfDidZ4a0OkHgpNP8aCe1bX8qlP3KqG0F+tqsSCHHONKRylmzsqdO+T
 LmBRhZcnSWrF7HB86RazVK+ipqgk6dn8II/heAEuRyPYKeChdmooszmg8hTWDFGEpAxdQ5nIWFu3v
 Dpe4YgpuVEOEHS8qpeVlXVxnmSXUmVECfIz0vSL/Vtpu8kVkW6MwDE8RMpIqbx+pBnLhgDZkgDV3d
 +JgUSaQaGwproKJIWhJBElTPpOm954PZeQEPG/fXcjHAFHPlzaGnLJkWKJOtyKeJQimC07KJTtC2J
 37mdY2Yg==;
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZG4-0001YO-U3
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:35 +0000
Received: by mail-qt1-f193.google.com with SMTP id n21so11653916qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=fGEc1kNsVdjialDo7Zh7TuJC/qFAJNtJfYxwQMewdeo=;
 b=bIbcA2MM//huooRXmpNaSnMPdjhA5tSMi3909u6qx6hy9bVMDEZV+q3a8LwJwah0oC
 0aXgia1KWEnQw/G6JQbUsQue/EX55hp2Ut9H6GWoRQbD4yuRiyTkoG6ZhrNyurvCCvnP
 vgYvDU8Wr+Ip+HisgpB6a37ura7Jd+fOXF1xDeVJb6OxI+wJYlpO5JPa8IivWJUbJvjH
 8PyUYFiJ+9IFl3qoCPb6SMbpdHPG6HKv6+fvRtVk5D4UD6bxR22aO8a5yPXdIpWo6pjB
 k8IX/QbVhbK7VYEZivbJELmTRz8fEXu/oTcIMkBxg3azzpiTPSNhx+JTjHwvjcihvxqG
 7Pgg==
X-Gm-Message-State: AA+aEWbi1fM2TYE8sdcL9OiL7WE4G+XPm+q9lpr8/WJnzCXa61DE6vEa
 4MXV/6GvVcLX0ayJq9J/i+pLhzAR
X-Google-Smtp-Source: AFSGD/VBYTkqqDz0F0JpSZHKRmvasXNRQVJSoDrrDSdPXA0f9EfC9mO5D0+5rfWKroYaw1xoTAQNRA==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr12616264qtq.287.1543785980235; 
 Sun, 02 Dec 2018 13:26:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id 86sm9103593qky.92.2018.12.02.13.26.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:26:19 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:26:13 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] ARM: dts: imx7d-pico: Extend peripherals support
Date: Sun,  2 Dec 2018 19:25:18 -0200
Message-Id: <20181202212520.16650-8-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_212632_994777_E4F7D1C9 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

This extends the peripherals supported by the imx7d-pico.dtsi. It
adds:

 - I2C2
 - Flexcan (flexcan1 and flexcan2 ports)
 - USDHC1
 - UART (6 and 7 ports)
 - PWM (4 ports)
 - eCSPI3

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 183 ++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 417f034fb354..6c7581336f96 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -78,6 +78,13 @@
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&ecspi3 {
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -103,6 +110,18 @@
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -110,6 +129,12 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
@@ -215,6 +240,29 @@
 	status = "okay";
 };
 
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 { /* Backlight */
+	status = "okay";
+};
+
 &uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
@@ -223,6 +271,24 @@
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart7 { /* Bluetooth */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
@@ -234,6 +300,21 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	tuning-step = <2>;
+	vmmc-supply = <&reg_3p3v>;
+	wakeup-source;
+	no-1-8-v;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
@@ -268,6 +349,15 @@
 };
 
 &iomuxc {
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
@@ -275,6 +365,13 @@
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_UART2_TX_DATA__I2C2_SDA	0x4000007f
+			MX7D_PAD_UART2_RX_DATA__I2C2_SCL	0x4000007f
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
@@ -295,6 +392,20 @@
 		>;
 	};
 
+	pinctrl_can1: can1frp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_DATA__FLEXCAN1_RX	0x59
+			MX7D_PAD_SAI1_TX_BCLK__FLEXCAN1_TX	0x59
+		>;
+	};
+
+	pinctrl_can2: can2frp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_TX_SYNC__FLEXCAN2_RX	0x59
+			MX7D_PAD_SAI1_TX_DATA__FLEXCAN2_TX	0x59
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
@@ -302,6 +413,24 @@
 		>;
 	};
 
+	pinctrl_pwm1: pwm1 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
+		>;
+	};
+
+	pinctrl_pwm2: pwm2 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__PWM2_OUT   0x7f
+		>;
+	};
+
+	pinctrl_pwm3: pwm3 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__PWM3_OUT   0x7f
+		>;
+	};
+
 	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
@@ -324,12 +453,66 @@
 		>;
 	};
 
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA08__UART6_DCE_RX	0x79
+			MX7D_PAD_EPDC_DATA09__UART6_DCE_TX	0x79
+			MX7D_PAD_EPDC_DATA10__UART6_DCE_RTS	0x79
+			MX7D_PAD_EPDC_DATA11__UART6_DCE_CTS	0x79
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_MOSI__UART7_DCE_TX	0x79
+			MX7D_PAD_ECSPI2_SCLK__UART7_DCE_RX	0x79
+			MX7D_PAD_ECSPI2_SS0__UART7_DCE_CTS	0x79
+			MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79
+		>;
+	};
+
 	pinctrl_usbotg1_pwr: usbotg_pwr {
 		fsl,pins = <
 			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
 		>;
 	};
 
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
