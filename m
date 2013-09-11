From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 11 Sep 2013 11:51:07 +0200
Subject: [PATCH 1/2] ARM: dts: imx53-qsb: add TVE entry
Message-ID: <1378893068-22235-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb.dts | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 512a1f6..2031ccc 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -156,6 +156,15 @@
 		};
 	};
 
+	tve {
+		pinctrl_vga_sync_1: vgasync-grp1 {
+			fsl,pins = <
+				/* VGA_HSYNC, VSYNC with max drive strength */
+				MX53_PAD_EIM_OE__IPU_DI1_PIN7     0xe6
+				MX53_PAD_EIM_RW__IPU_DI1_PIN8     0xe6
+			>;
+		};
+	};
 };
 
 &uart1 {
@@ -263,8 +272,8 @@
 			};
 
 			ldo8_reg: ldo8 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <2750000>;
+				regulator-max-microvolt = <2750000>;
 				regulator-always-on;
 			};
 
@@ -297,6 +306,18 @@
 	status = "okay";
 };
 
+&tve {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_vga_sync_1>;
+	ddc = <&i2c2>;
+	fsl,tve-mode = "vga";
+	status = "okay";
+	dac-supply = <&ldo7_reg>;
+
+	fsl,hsync-pin = <7>; /* IPU DI1 PIN7 via EIM_OE */
+	fsl,vsync-pin = <8>; /* IPU DI1 PIN8 via EIM_RW */
+};
+
 &usbh1 {
        status = "okay";
 };
-- 
1.8.4.rc3
