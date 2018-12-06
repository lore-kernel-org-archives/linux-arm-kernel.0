Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A73520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nI8pqvFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A73520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DxlMrhPxRIXAsIN30vteRRXN7118TT/HEV/khGS6ULs=; b=nI8pqvFJeNlTL9
	E83B8yXOHivkGzyr9Y5uZoW5Fu9n2BU2/TlssjhHNXvorau0RwsGm570nJZ7nogg2ZVZZ6orRHMME
	1LiDhZC2uZXM7pF47llCZ5jlCxP7sRpX5mZDai6kOg5yhmkXCrQPvvkemBg792YPNTT51l7v2nkMV
	aPYH5kBhdvhRBDrjj0CMsEkGcrPVzF3a2HMIp5nf/Q7Fja9ijpEhx23j1AKIeitfm5YO8C5SZV96V
	wxy3v/xUrZvM/I0ESBKwfYvLW94kMbZWk+nTkj8oMeJJ0fptySRHnkTeLzBOhJHiVVNh+kNNND0Do
	HIDA2CVMZqXFjgP4nsZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqbs-0002Ub-Mz; Thu, 06 Dec 2018 10:10:20 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbN-0000wi-Qp
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:09:55 +0000
Received: by mail-qk1-f195.google.com with SMTP id o125so13689082qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=/nlCIta1oav3yjs0hofTdbkUO3Goz/S4uSCxgxGrp8Y=;
 b=Wy6imQiefDEbJItz6How3E+14CoDNENcQXwJ/dNXWyV3Y8A61XS5h3XbyL762MCfR4
 prkVDD0xYeAniiq7tSkE8RS6iSu7tXNOgsgEeNom+eDLJaYmFCKmLAiqX4SYv/VKRWik
 1aUodutBD0BcMcjhiJmoyslRwPT4SHrR04WmSHX9fYHkNVlGanKbycnISTkoQvbcUyJx
 I1JjWEjFQxd/FNcodK3tB2EdgwUE9GfsxXpH/nghM3WalDZO512Ld9wdpfJY4xQfsRC+
 GU7+RLJEtZLZ48tVYgH11GB9pWRWnu8DkMteu0odeQOIS43l6+4l5eue14G9emCzKn8v
 1QmA==
X-Gm-Message-State: AA+aEWac72LKFgIfc4QnRIZHwmfqmvKTGIMpqZdwskPsrK9vd331lFIM
 Ec9oooFzM9J/otHp9g3TX92DqcIz
X-Google-Smtp-Source: AFSGD/WmxMTH1c3I1JMO/aGbkbGt2ZgJraUFm57EtBPKVW8JO8AWeB3KwP9Ebez0F+GjZS4MngmcGg==
X-Received: by 2002:ae9:df02:: with SMTP id t2mr25874952qkf.230.1544090978286; 
 Thu, 06 Dec 2018 02:09:38 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id q84sm16072344qkh.56.2018.12.06.02.09.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:37 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:31 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/9] ARM: dts: imx7d-pico-pi: Move SoM related part to
 imx7d-pico.dtsi
Date: Thu,  6 Dec 2018 08:08:59 -0200
Message-Id: <20181206100905.15053-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_020950_738265_74ACBE79 
X-CRM114-Status: GOOD (  16.19  )
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

imx7d-pico-pi board contains:

- One SoM board (imx7d pico)
- One base board (pi).

In order to make it easier for adding support for other board variants,
move the commom SoM part to the imx7d-pico.dtsi file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico-pi.dts | 116 ++--------------------------
 arch/arm/boot/dts/imx7d-pico.dtsi   | 111 +++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
index 33951f4c7f41..039c17066fe0 100644
--- a/arch/arm/boot/dts/imx7d-pico-pi.dts
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -5,6 +5,9 @@
 #include "imx7d-pico.dtsi"
 
 / {
+	model = "TechNexion PICO-IMX7D Board and PI baseboard";
+	compatible = "technexion,imx7d-pico-pi", "fsl,imx7d";
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -16,43 +19,14 @@
 		};
 
 		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&sgtl5000>;
 			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
 		};
 	};
 };
 
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
-	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
-			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
-	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			status = "okay";
-		};
-	};
-};
-
 &i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	codec: sgtl5000@a {
+	sgtl5000: codec@a {
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		compatible = "fsl,sgtl5000";
@@ -61,83 +35,3 @@
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
 };
-
-
-&sai1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai1>;
-	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
-			  <&clks IMX7D_SAI1_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
-	assigned-clock-rates = <0>, <24576000>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	vbus-supply = <&reg_usb_otg2_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
-			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
-			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
-			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
-			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
-			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
-			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
-			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
-			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
-			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
-			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
-			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
-			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
-			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
-			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
-		>;
-	};
-
-	pinctrl_sai1: sai1grp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK	0x1f
-			MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
-			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
-			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
-			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
-		>;
-	};
-
-	pinctrl_usbotg1_pwr: usbotg_pwr {
-		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index d957454ce16b..7319e2ecec5c 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -7,9 +7,6 @@
 #include "imx7d.dtsi"
 
 / {
-	model = "Technexion Pico i.MX7D Board";
-	compatible = "technexion,imx7d-pico", "fsl,imx7d";
-
 	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
@@ -79,6 +76,37 @@
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
@@ -174,6 +202,35 @@
 	};
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <24576000>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
@@ -208,6 +265,32 @@
 };
 
 &iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
+			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
@@ -221,6 +304,28 @@
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK	0x1f
+			MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
+		>;
+	};
+
+	pinctrl_usbotg1_pwr: usbotg_pwr {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
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
