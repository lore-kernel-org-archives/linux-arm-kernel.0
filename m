From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:34 +0200
Subject: [PATCH v3 14/14] ARM: dts: sun8i: fix pin name
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-15-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All pinmux nodes should have the suffix "_pins" or "_pin".

In the case where there are multiple choices, the node name should convey
what or which pingroup the choice is.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts              |  8 ++++----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts                |  8 ++++----
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                      | 10 +++++-----
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts                  |  4 ++--
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts                       |  2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts                  |  4 ++--
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                         |  4 ++--
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                      |  8 ++++----
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts                   |  8 ++++----
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts                    |  4 ++--
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts                |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts                     |  6 +++---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                             | 10 +++++-----
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |  6 +++---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts        |  4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts       |  6 +++---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts     |  8 ++++----
 .../arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts |  4 ++--
 18 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 6713d0f2b3f4..8b1e2dace4da 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -113,7 +113,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pf_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -123,7 +123,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc_wifi>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -139,7 +139,7 @@
 	};
 };
 
-&mmc1_pins_a {
+&mmc1_pins {
 	bias-pull-up;
 };
 
@@ -166,7 +166,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index cc20d676a642..575510a5fd01 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -125,7 +125,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
@@ -138,7 +138,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -148,7 +148,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
@@ -194,7 +194,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 10da56e86ab8..2631a3619dc4 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -110,13 +110,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -126,7 +126,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
@@ -166,13 +166,13 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pins_a>;
+	pinctrl-0 = <&spdif_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 818f9bf5df66..7beb10c6940c 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -91,7 +91,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
@@ -104,7 +104,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
index 3a2ccdb28afd..08f3577c9b0a 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
@@ -57,7 +57,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 03ff6f8b93ff..a9d4d0b01439 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -76,7 +76,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -86,7 +86,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index 7646e331bd29..ca63c383d4ed 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -98,7 +98,7 @@
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	status = "okay";
 	vmmc-supply = <&reg_vcc3v3>;
 };
@@ -128,7 +128,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index b20be95b49d5..6845fbcc306b 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -127,13 +127,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -143,7 +143,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -190,7 +190,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index a70a1daf4e2c..cebf0f0c84c4 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -101,13 +101,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -117,7 +117,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
@@ -161,7 +161,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 82e5d28cd698..cf6d273992f7 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -107,7 +107,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -149,7 +149,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index a10281b455f5..2307f750293a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -60,7 +60,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 6d98bcfbe877..76e8fbd22c38 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -127,13 +127,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
@@ -183,7 +183,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 2e4bae988acd..f9d6411f4b39 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -322,7 +322,7 @@
 				function = "i2c2";
 			};
 
-			mmc0_pins_a: mmc0 {
+			mmc0_pf_pins: mmc0 {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -336,7 +336,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins_a: mmc1 {
+			mmc1_pins: mmc1 {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
@@ -354,7 +354,7 @@
 				bias-pull-up;
 			};
 
-			spdif_tx_pins_a: spdif {
+			spdif_pin: spdif {
 				pins = "PA17";
 				function = "spdif";
 			};
@@ -369,7 +369,7 @@
 				function = "spi1";
 			};
 
-			uart0_pins_a: uart0 {
+			uart0_pb_pins: uart0 {
 				pins = "PA4", "PA5";
 				function = "uart0";
 			};
@@ -697,7 +697,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			ir_pins_a: ir {
+			ir_pin: ir {
 				pins = "PL11";
 				function = "s_cir_rx";
 			};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 7c028af58f47..3b242136306c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -135,7 +135,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
@@ -144,7 +144,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
@@ -178,7 +178,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index 968908761194..eafa116b1c18 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -127,7 +127,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
@@ -144,7 +144,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index a8296feee884..3e028b18d703 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -148,7 +148,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
@@ -161,7 +161,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
@@ -186,7 +186,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index d906b302cbcd..bb9554fe7389 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -155,7 +155,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&ir_pin>;
 	status = "okay";
 };
 
@@ -168,7 +168,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
@@ -177,7 +177,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -203,7 +203,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index b6b7a561df8c..71c9b05e1740 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -68,7 +68,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pf_pins>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
@@ -87,6 +87,6 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
-- 
2.13.5
