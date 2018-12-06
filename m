Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F79620700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BecUC7Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F79620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UJeXdQiA4QZxBse2WMzKh/E2COXVVU71inzva5zmQdI=; b=BecUC7Xyu309du
	1ULj77E0djcYsbp6U9qYqy9kRoKYOeXBj0hOxvQLlJ6G2D7P1TTLylvb7wy46kkhR94NtS7JWntZL
	FZhSgkGPXcDRiZcj3Piw3mhFWdcdLHA3oz17Tdzd2xz0lGiVMWAzyrrFUguf8V/dSLmzoPr+8BNh4
	5KVh8S3M5jUaS//eZSDI6MPQqWuhsJ58QpjCzUcmqNbmaFef80qdPJwPEGFOLDLcV2f6HQmw5b3On
	jP5YJc8NjqyztEPziEDRikhzLzbutT1gsJdcqmmtQOQcYviNzXz7v8FEK4jGSVXKlq9BpJo/mxQ85
	P7QqkQ8QZ/N5Cl95KfXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqdH-0004CQ-Hs; Thu, 06 Dec 2018 10:11:47 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbr-0001lP-Gt
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:38 +0000
Received: by mail-qt1-f196.google.com with SMTP id d19so25617215qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=hCoU2gbIkFUvFKy10Gd09lC8DMzvZQ0iMHClYT3ZpAo=;
 b=FVJXL1pUPEs4Wp4cBVeXUSOz9wQinsH4ACm/rjpQM/62Vf7cML82e9Sny3nQeOmCmt
 bLNHO6444vEAeYLNQdPz9h0SLgoCibX7xX9vFEtu4F6idNr6IWO2Pn9dSBT61nXDexGP
 L1Yn6VoAw7QMNlbWmUOdHCLy+w4IEkiyq98dJYVvzV4UqGGPvcQzG2bAEOp1DwWF9P5b
 +CjmetQnZsRtG0OumO5bCLcu0T3OAQ/kFUh6SvDe0X/2fj2ZcNhZywrAsAECAEmJuoE+
 70ch5BfeXvmZDkUVH2hfrzPvcUIUac5HDnLUmxEyDsIrpyoIWkBmrpIC1o0ESDy8K19O
 PXEQ==
X-Gm-Message-State: AA+aEWYtB7fVrNGW+LtLIK4HmLOdhUkbDP+40lPd0sy75opmvaojHSQY
 UQnQQ+vjKZjygTZR95TST5SwJADG
X-Google-Smtp-Source: AFSGD/XZdZbc4s/yzcYwlKZHdBoMnBXDb9hCzDx/mpYCsZpMx/7KIRlduCXjuEgmWvSx2qFD8Qj+8g==
X-Received: by 2002:a0c:e394:: with SMTP id a20mr26129000qvl.42.1544091008052; 
 Thu, 06 Dec 2018 02:10:08 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id c49sm14363057qtc.94.2018.12.06.02.10.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:10:07 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:10:01 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/9] ARM: dts: imx7d-pico: Extend peripherals support
Date: Thu,  6 Dec 2018 08:09:03 -0200
Message-Id: <20181206100905.15053-8-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021019_917901_9AC182AE 
X-CRM114-Status: GOOD (  15.44  )
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

Changes in v2:
- replace fsl,uart-has-rtscts with uart-has-rtscts

 arch/arm/boot/dts/imx7d-pico.dtsi | 183 ++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 417f034fb354..3fd595a71202 100644
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
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart7 { /* Bluetooth */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
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
