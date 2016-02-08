From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  8 Feb 2016 21:55:35 +0000
Subject: [PATCH] ARM: dts: spear: replace gpio-key,
 wakeup with wakeup-source property
Message-ID: <1454968535-11994-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
"gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
source.

Few dts files assign value "1" to gpio-key,wakeup which is incorrect.
Since the presence of the boolean property indicates it is enabled,
value of "0" or "1" have no significance.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property which inturn fixes the above mentioned issue.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/spear1310-evb.dts | 2 +-
 arch/arm/boot/dts/spear1340-evb.dts | 2 +-
 arch/arm/boot/dts/spear320-hmi.dts  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

Hi ARM-SoC guys,

This is the only platform which doesn't have regular pull request,
Viresh has acked it already. Can you pick this up directly for v4.6 ?

Regards,
Sudeep

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
 
-- 
1.9.1
