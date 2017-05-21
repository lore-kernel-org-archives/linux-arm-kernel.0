From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:51 +0200
Subject: [PATCH 02/13] ARM: dts: armada-385-linksys: label nodes
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-3-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add labels to nodes used by dependants. Also rename node gpio_keys to
gpio-keys to mach the style of the rest of the file as well as the
documented example.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 481e4a3..b7f0a16 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -79,7 +79,7 @@
 		gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 	};
 
-	gpio_keys {
+	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -99,7 +99,7 @@
 		};
 	};
 
-	gpio-leds {
+	gpio_leds: gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&power_led_pin &sata_led_pin>;
 		pinctrl-names = "default";
@@ -210,7 +210,7 @@
 		reg = <0x4c>;
 	};
 
-	pca9635 at 68 {
+	expander0: pca9635 at 68 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nxp,pca9635";
-- 
2.10.2
