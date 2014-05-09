From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 May 2014 08:11:18 +0200
Subject: [PATCH 5/6] ARM: dts: Karo TX25: Add phy reset gpio and supply for FEC
In-Reply-To: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
References: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1399615879-30781-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index aeb1fce..fd0dad3 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -16,6 +16,22 @@
 	model = "Ka-Ro TX25";
 	compatible = "karo,imx25-tx25", "fsl,imx25";
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_fec_phy: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "fec-phy";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 9 0>;
+			enable-active-high;
+		};
+	};
+
 	memory {
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
@@ -77,7 +93,9 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
+	phy-reset-gpios = <&gpio3 7 0>;
 	phy-mode = "rmii";
+	phy-supply = <&reg_fec_phy>;
 	status = "okay";
 };
 
-- 
2.0.0.rc0
