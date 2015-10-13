From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 13 Oct 2015 15:38:53 +0100
Subject: [PATCH 2/2][UPDATE] ARM: dts: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
References: <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <1444747133-22671-1-git-send-email-sudeep.holla@arm.com>
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

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts      | 3 +--
 arch/arm/boot/dts/rk3066a-rayeager.dts      | 2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts      | 2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi       | 2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts       | 2 +-
 arch/arm/boot/dts/rk3288-r89.dts            | 2 +-
 arch/arm/boot/dts/spear1310-evb.dts         | 2 +-
 arch/arm/boot/dts/spear1340-evb.dts         | 2 +-
 arch/arm/boot/dts/spear320-hmi.dts          | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 2 +-
 11 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index c0273755431a..93be8f066e6d 100644
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
index e36383c701dc..da1c37a721c0 100644
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
index d2180e5d2b05..acd3bb940e9a 100644
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
index f6d2e7894b05..e35cebc69e87 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -103,7 +103,7 @@
 			linux,code = <116>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 20fa0ef0b96b..c5dd26139b63 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -67,7 +67,7 @@
 		#size-cells = <0>;
 
 		button at 0 {
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <116>;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index f82b956ebf17..34a0b063b3ec 100644
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
index 14b9fc73c8a4..dc2f83a38d4f 100644
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
diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index e48857249ce7..84101e4eebbf 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -161,7 +161,7 @@
 				linux,code = <0x100>;
 				gpios = <&gpio0 7 0x4>;
 				debounce-interval = <20>;
-				gpio-key,wakeup = <1>;
+				wakeup-source;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index c611f5606dfe..6565f3cb866f 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -223,7 +223,7 @@
 				linux,code = <0x100>;
 				gpios = <&gpio1 1 0x4>;
 				debounce-interval = <20>;
-				gpio-key,wakeup = <1>;
+				wakeup-source;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0aa6fef5ce22..0d0da1f65f0e 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -141,7 +141,7 @@
 				linux,code = <0x100>;
 				gpios = <&stmpegpio 3 0x4>;
 				debounce-interval = <20>;
-				gpio-key,wakeup = <1>;
+				wakeup-source;
 			};
 
 			button at 2 {
@@ -149,7 +149,7 @@
 				linux,code = <0x200>;
 				gpios = <&stmpegpio 2 0x4>;
 				debounce-interval = <20>;
-				gpio-key,wakeup = <1>;
+				wakeup-source;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 401a81231eb9..730bac3a1c0a 100644
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
