From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:40 +0900
Subject: [PATCH 12/33] ARM: shmobile: Add DTS gpio-keys support for SW2 on
 Koelsch
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <7f168b1e921f137db4f323428819f4c86ede4320.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DTS gpio-keys support for SW2 on the Koelsch board.
This makes the DT code match the legacy board code. Also
update the existing gpio-keys nodes to make use of KEY_n.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 43 +++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index e24fed9..fd1d6ee 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -13,6 +13,7 @@
 /dts-v1/;
 #include "r8a7791.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Koelsch";
@@ -40,51 +41,79 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 
+		key-1 {
+			gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_1>;
+			label = "SW2-1";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-2 {
+			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_2>;
+			label = "SW2-2";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-3 {
+			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_3>;
+			label = "SW2-3";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-4 {
+			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_4>;
+			label = "SW2-4";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
 		key-a {
 			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
-			linux,code = <30>;
+			linux,code = <KEY_A>;
 			label = "SW30";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-b {
 			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
-			linux,code = <48>;
+			linux,code = <KEY_B>;
 			label = "SW31";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-c {
 			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
-			linux,code = <46>;
+			linux,code = <KEY_C>;
 			label = "SW32";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-d {
 			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
-			linux,code = <32>;
+			linux,code = <KEY_D>;
 			label = "SW33";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-e {
 			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
-			linux,code = <18>;
+			linux,code = <KEY_E>;
 			label = "SW34";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-f {
 			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
-			linux,code = <33>;
+			linux,code = <KEY_F>;
 			label = "SW35";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
 		};
 		key-g {
 			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-			linux,code = <34>;
+			linux,code = <KEY_G>;
 			label = "SW36";
 			gpio-key,wakeup;
 			debounce-interval = <20>;
-- 
1.8.5.2
