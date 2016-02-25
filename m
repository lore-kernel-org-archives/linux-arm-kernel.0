From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:04 +0900
Subject: [PATCH 15/19] ARM: dts: r8a7794: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <c816617e8b09c13b1b5a66de8a32db8e5e61dff1.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Changelog text from a similar patch by Sudeep Holla.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index cfe142c2ba38..87e89ec9dd47 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -67,77 +67,77 @@
 		        gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_1>;
 		        label = "SW2-1";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-2 {
 		        gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_2>;
 		        label = "SW2-2";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-3 {
 		        gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_3>;
 		        label = "SW2-3";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-4 {
 		        gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_4>;
 		        label = "SW2-4";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-a {
 		        gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_A>;
 		        label = "SW30";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-b {
 		        gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_B>;
 		        label = "SW31";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-c {
 		        gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_C>;
 		        label = "SW32";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-d {
 		        gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_D>;
 		        label = "SW33";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-e {
 		        gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_E>;
 		        label = "SW34";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-f {
 		        gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_F>;
 		        label = "SW35";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 		key-g {
 		        gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 		        linux,code = <KEY_G>;
 		        label = "SW36";
-		        gpio-key,wakeup;
+		        wakeup-source;
 		        debounce-interval = <20>;
 		};
 	};
-- 
2.7.0.rc3.207.g0ac5344
