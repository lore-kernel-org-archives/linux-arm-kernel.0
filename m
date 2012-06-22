From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jun 2012 11:14:53 +0200
Subject: [PATCH 1/2] ARM:MX28: Add additionnal muxing options to iMX28 DTSI
In-Reply-To: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1340356494-24664-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..babc604 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -159,7 +159,7 @@
 					#interrupt-cells = <2>;
 				};
 
-				duart_pins_a: duart at 0 {
+				duart_pins_a: duart-a at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x3102 0x3112>;
 					fsl,drive-strength = <0>;
@@ -167,6 +167,14 @@
 					fsl,pull-up = <0>;
 				};
 
+				duart_pins_b: duart-b at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3022 0x3032>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x4000 0x4010 0x4020
@@ -196,6 +204,15 @@
 					fsl,pull-up = <1>;
 				};
 
+				mmc0_4bit_pins_a: mmc0-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2000 0x2010 0x2020
+						0x2030 0x2080 0x2090 0x20a0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				mmc0_cd_cfg: mmc0-cd-cfg {
 					fsl,pinmux-ids = <0x2090>;
 					fsl,pull-up = <0>;
-- 
1.7.9.5
