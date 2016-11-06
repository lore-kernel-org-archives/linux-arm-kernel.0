From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun,  6 Nov 2016 23:27:11 +0100
Subject: [PATCH 18/19] ARM: dts: armada-370-xp: Remove button address and
 fixup names
In-Reply-To: <20161106222712.27366-1-gregory.clement@free-electrons.com>
References: <20161106222712.27366-1-gregory.clement@free-electrons.com>
Message-ID: <20161106222712.27366-19-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-key nodes do not have a reg property, so remove the address from
the unit name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts                      | 2 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi       | 6 +++---
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 6 +++---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 4 ++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts         | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index cff178004f59..4e9ad4b5bf94 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -122,7 +122,7 @@
 				compatible = "gpio-keys";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				button at 1 {
+				button {
 					label = "Software Button";
 					linux,code = <KEY_POWER>;
 					gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 15d6aee02e17..d0c749cf369c 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -141,19 +141,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		button at 2 {
+		backup {
 			label = "Backup button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		button at 3 {
+		reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index f77a08ebe7b6..1937a0991179 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -89,19 +89,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
 			debounce-interval = <100>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		button at 3 {
+		button {
 			label = "USB VBUS error";
 			linux,code = <KEY_UNKNOWN>;
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 4c199ef539c1..1b294b3814c5 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -113,7 +113,7 @@
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_SETUP>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index fd16af578fa8..ee10e1aa9225 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -267,13 +267,13 @@
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 		};
 
-		button at 2 {
+		reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index cf7b6759baf1..229ec4b2dae1 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -111,7 +111,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				button at 1 {
+				init {
 					label = "Init Button";
 					linux,code = <KEY_POWER>;
 					gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-- 
2.10.1
