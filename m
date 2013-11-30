From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 30 Nov 2013 10:18:03 +0400
Subject: [PATCH 3/4] ARM: dts: imx27-phytec-phycore-som: Update FEC node
In-Reply-To: <1385792284-22286-1-git-send-email-shc_work@mail.ru>
References: <1385792284-22286-1-git-send-email-shc_work@mail.ru>
Message-ID: <1385792284-22286-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates FEC devicetree node of Phytec PCM038 module:
- Adding missing phy_mode properties.
- Adding fixed regulator to provide functionality without
  dummy-regulator in the kernel.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index fec2d29..861e2e0 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -19,6 +19,20 @@
 	memory {
 		reg = <0xa0000000 0x08000000>;
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3v3: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
 };
 
 &audmux {
@@ -134,7 +148,9 @@
 };
 
 &fec {
+	phy-mode = "mii";
 	phy-reset-gpios = <&gpio3 30 0>;
+	phy-supply = <&reg_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	status = "okay";
-- 
1.8.3.2
