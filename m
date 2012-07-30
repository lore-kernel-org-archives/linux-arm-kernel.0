From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 30 Jul 2012 16:33:44 -0300
Subject: [PATCH] ARM: imx23-olinuxino.dts: Add AUART0 support
Message-ID: <1343676824-16913-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AUART0 support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    6 ++++++
 arch/arm/boot/dts/imx23.dtsi          |   11 +++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 20912b1..a286873 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -39,6 +39,12 @@
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
+
+			auart0: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index a874dbf..f58118b 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -140,6 +140,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart0_2pins_a: auart0-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x01e2 /* MX23_PAD_I2C_SCL__AUART1_TX */
+						0x01f2 /* MX23_PAD_I2C_SDA__AUART1_RX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				gpmi_pins_a: gpmi-nand at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.1
