From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:41 +0200
Subject: [PATCH 7/7] ARM: dts: imx53-tx53: fix interrupt flags and use
 interrupts-extended property
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct interrupt flags and change the 'interrupt-parent',
'interrupts' property pairs to 'interrupts-extended'.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 6 ++----
 arch/arm/boot/dts/imx53-tx53.dtsi     | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index aa9ae84..632a097 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -242,8 +242,7 @@
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06_1>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&gpio6 15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 	};
@@ -253,8 +252,7 @@
 		reg = <0x48>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tsc2007>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <26 0>;
+		interrupts-extended = <&gpio3 26 IRQ_TYPE_EDGE_FALLING>;
 		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <660>;
 		wakeup-source;
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 8e10c47..76e7186 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -226,8 +226,7 @@
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
-		interrupt-parent = <&gpio2>;
-		interrupts = <4>;
+		interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
 		device_type = "ethernet-phy";
 	};
 };
@@ -246,8 +245,7 @@
 		reg = <0x68>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ds1339>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <20 0>;
+		interrupts-extended = <&gpio4 20 IRQ_TYPE_EDGE_FALLING>;
 		trickle-resistor-ohms = <250>;
 		trickle-diode-disable;
 	};
-- 
2.1.4
