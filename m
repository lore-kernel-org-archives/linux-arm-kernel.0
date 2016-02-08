From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  8 Feb 2016 21:55:12 +0000
Subject: [PATCH] ARM: dts: rockchip: replace gpio-key,
 wakeup with wakeup-source property
Message-ID: <1454968512-11956-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
"gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
source.

Few dts files assign value "1" to gpio-key,wakeup and in one instance a
value "0" is assigned probably assuming it won't be enabled as a wakeup
source. Since the presence of the boolean property indicates it is
enabled, value of "0" have no value.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property which inturn fixes the above mentioned issue.

Cc: linux-rockchip at lists.infradead.org
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          | 3 +--
 arch/arm/boot/dts/rk3066a-rayeager.dts          | 2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          | 2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           | 2 +-
 arch/arm/boot/dts/rk3288-r89.dts                | 2 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     | 2 +-
 11 files changed, 11 insertions(+), 12 deletions(-)

Hi Heiko,

You can reviewed this, however there are couple of ARM64 dts additions.
Also most of the other platform/SoC maintainers preferred to take it via
their tree and few of these got missed during v4.5 merge window.
Can you take it via your tree for v4.6 ?

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 38c91a839795..f92b46b7a6de 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -74,7 +74,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 		button at 1 {
@@ -82,7 +82,6 @@
 			linux,code = <104>;
 			label = "GPIO Key Vol-";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <0>;
 			debounce-interval = <100>;
 		};
 		/* VOL+ comes somehow thru the ADC */
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 341c1f87936a..3a493e407607 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -65,7 +65,7 @@
 		#size-cells = <0>;
 
 		button at 0 {
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <116>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 66fa87d1e2c2..0b6924c97b6b 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -63,7 +63,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4faabdb65868..78d47f7d2938 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -110,7 +110,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 4e3fd9aefe34..792ca4f2ebee 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -91,7 +91,7 @@
 		#size-cells = <0>;
 
 		button at 0 {
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <116>;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 65c475642d5a..2ff9689d2e1b 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -74,7 +74,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 17f13c73fe5e..510a1d0d7abb 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -73,7 +73,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 136d650dd05f..610769d99522 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -108,7 +108,7 @@
 	lid {
 		label = "Lid";
 		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 		linux,code = <0>; /* SW_LID */
 		linux,input-type = <5>; /* EV_SW */
 		debounce-interval = <1>;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 9fce91ffff6f..420ba9b436a5 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -64,7 +64,7 @@
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <100>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 8c219ccf67a3..6e27b22704df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -111,7 +111,7 @@
 		pinctrl-0 = <&pwr_key>;
 
 		button at 0 {
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <116>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 104cbee762bb..1f2b642e794a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -71,7 +71,7 @@
 		pinctrl-0 = <&pwr_key>;
 
 		button at 0 {
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <116>;
-- 
1.9.1
