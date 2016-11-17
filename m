From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:07 +0100
Subject: [PATCH v3 18/19] ARM: dts: armada-370-xp: Remove button address and
 fixup names
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-19-gregory.clement@free-electrons.com>
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
index 649dc108bc08..085fe5f2ee91 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -130,7 +130,7 @@
 				compatible = "gpio-keys";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				button at 1 {
+				button {
 					label = "Software Button";
 					linux,code = <KEY_POWER>;
 					gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 6ba394b7a55a..7e624dae8713 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -149,19 +149,19 @@
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
index d5adb8f300ac..f67f375a288e 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -97,19 +97,19 @@
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
index 3bf27a9215e3..f62cdc350e98 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -121,7 +121,7 @@
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_SETUP>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index f17c98d6cd0f..47a9ee09370e 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -275,13 +275,13 @@
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
index 79bb2e7c6252..0ed919cf2088 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -119,7 +119,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				button at 1 {
+				init {
 					label = "Init Button";
 					linux,code = <KEY_POWER>;
 					gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-- 
2.10.2
