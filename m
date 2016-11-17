From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 17 Nov 2016 04:06:15 +0200
Subject: [PATCH] ARM: dts: lpc435x: remove address and size cells from
 gpio-keys-polled nodes
Message-ID: <20161117020615.30383-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change removes redundant #address-cells and #size-cells properties from
gpio-keys-polled compatible device nodes found in lpc4357-ea4357-devkit and
lpc4350-hitex-eval board DTS files.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 2 --
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 874c75d..7649285 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -40,8 +40,6 @@
 
 	pca_buttons {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <100>;
 		autorepeat;
 
diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 9b5fad6..50ee2d5 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -57,8 +57,6 @@
 		compatible = "gpio-keys-polled";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_joystick_pins>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <100>;
 		autorepeat;
 
-- 
2.10.2
