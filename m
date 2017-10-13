From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:43:01 +0200
Subject: [PATCH 5/7] ARM: dts: imx6ul-txul: use interrupts-extended property
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the 'interrupts-extended' property instead of pairs of
'interrupt-parent', 'interrupts' properties.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index f8f7685..97c7047 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -325,8 +325,7 @@
 			reg = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_etnphy0_int>;
-			interrupt-parent = <&gpio5>;
-			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&gpio5 5 IRQ_TYPE_EDGE_FALLING>;
 			status = "okay";
 		};
 
@@ -335,8 +334,7 @@
 			reg = <2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_etnphy1_int>;
-			interrupt-parent = <&gpio4>;
-			interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&gpio4 27 IRQ_TYPE_EDGE_FALLING>;
 			status = "okay";
 		};
 	};
@@ -383,8 +381,7 @@
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
 		wakeup-source;
@@ -395,8 +392,7 @@
 		reg = <0x48>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tsc2007>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <26 IRQ_TYPE_NONE>;
+		interrupts-extended = <&gpio3 26 IRQ_TYPE_NONE>;
 		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <660>;
 		wakeup-source;
-- 
2.1.4
