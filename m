From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:16:35 +0200
Subject: [PATCH 2/2] ARM i.MX53: dts: Add TVE to i.MX53-QSB device tree
In-Reply-To: <1365437795-30074-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437795-30074-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365437795-30074-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb.dts | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 8f0e9ae..9141d19 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -129,6 +129,15 @@
 		};
 	};
 
+	tve {
+		pinctrl_vga_sync_1: vgasync-grp1 {
+			fsl,pins = <
+				/* VGA_HSYNC, VSYNC with max drive strength */
+				614 0xe6	/* MX53_PAD_EIM_OE__IPU_DI1_PIN7 */
+				619 0xe6	/* MX53_PAD_EIM_RW__IPU_DI1_PIN8 */
+			>;
+		};
+	};
 };
 
 &uart1 {
@@ -235,8 +244,8 @@
 			};
 
 			ldo8_reg: ldo8 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <2750000>;
+				regulator-max-microvolt = <2750000>;
 				regulator-always-on;
 			};
 
@@ -268,3 +277,15 @@
 	phy-reset-gpios = <&gpio7 6 0>;
 	status = "okay";
 };
+
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
-- 
1.8.2.rc2
