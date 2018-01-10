From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Jan 2018 09:21:01 +0100
Subject: [PATCH 1/7] ARM: dts: STi: fix bindings notation
In-Reply-To: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515572469-19276-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove leading 0x and 0s from bindings notation
Add missing unit-address and remove some which are useless.

This allows to fix several warnings like :

Warning (unit_address_vs_reg): Node XXXX has a reg or ranges property, but no unit name
Warning (simple_bus_reg): Node XXXX simple-bus unit address format error, expected "123456"
Warning (unit_address_vs_reg): Node XXXX has a unit name, but no reg property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-b2120.dts    |  2 +-
 arch/arm/boot/dts/stih407-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stih407-family.dtsi  |  8 ++++----
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++++-----
 arch/arm/boot/dts/stih410-b2120.dts    |  2 +-
 arch/arm/boot/dts/stih410-b2260.dts    |  4 ++--
 arch/arm/boot/dts/stih410-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stih410-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/stih410.dtsi         |  2 +-
 arch/arm/boot/dts/stih418-b2199.dts    |  4 ++--
 arch/arm/boot/dts/stih418-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 ++--
 12 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index c8ad905..cf8bc8a 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index d0a24d9..b882dcf 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -83,7 +83,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0 at 13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -260,7 +260,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2 at x9106000 {
+		clockgen-d2 at 9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index cf37569..1608c70 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -92,7 +92,7 @@
 		clocks = <&arm_periph_clk>;
 	};
 
-	l2: cache-controller {
+	l2: cache-controller at 8762000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x08762000 0x1000>;
 		arm,data-latency = <3 3 3>;
@@ -389,7 +389,7 @@
 			reset-names = "global", "port";
 		};
 
-		miphy28lp_phy: miphy28lp at 9b22000 {
+		miphy28lp_phy: miphy28lp {
 			compatible = "st,miphy28lp-phy";
 			st,syscfg = <&syscfg_core>;
 			#address-cells	= <1>;
@@ -803,7 +803,7 @@
 			status		= "okay";
 		};
 
-		st231_gp0: st231-gp0 at 0 {
+		st231_gp0: st231-gp0 {
 			compatible	= "st,st231-rproc";
 			memory-region	= <&gp0_reserved>;
 			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
@@ -816,7 +816,7 @@
 			mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
 		};
 
-		st231_delta: st231-delta at 0 {
+		st231_delta: st231-delta {
 			compatible	= "st,st231-rproc";
 			memory-region	= <&delta_reserved>;
 			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a290900..53c6888 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -45,7 +45,7 @@
 	};
 
 	soc {
-		pin-controller-sbc {
+		pin-controller-sbc at 961f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-sbc-pinctrl";
@@ -369,7 +369,7 @@
 			};
 		};
 
-		pin-controller-front0 {
+		pin-controller-front0 at 920f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-front-pinctrl";
@@ -929,7 +929,7 @@
 			};
 		};
 
-		pin-controller-front1 {
+		pin-controller-front1 at 921f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-front-pinctrl";
@@ -962,7 +962,7 @@
 			};
 		};
 
-		pin-controller-rear {
+		pin-controller-rear at 922f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-rear-pinctrl";
@@ -1157,7 +1157,7 @@
 			};
 		};
 
-		pin-controller-flash {
+		pin-controller-flash at 923f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-flash-pinctrl";
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9830be5..37a42af 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c663b70..faafc7b 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -19,7 +19,7 @@
 		linux,stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
@@ -201,7 +201,7 @@
 			};
 		};
 
-		miphy28lp_phy: miphy28lp at 9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port1: port at 9b2a000 {
 				st,osc-force-ext;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index fde5df1..4df1b21 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -85,7 +85,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0 at 13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -272,7 +272,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2 at x9106000 {
+		clockgen-d2 at 9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stih410-pinctrl.dtsi b/arch/arm/boot/dts/stih410-pinctrl.dtsi
index b3e9dfc..5ae1fd6 100644
--- a/arch/arm/boot/dts/stih410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih410-pinctrl.dtsi
@@ -10,7 +10,7 @@
 / {
 
 	soc {
-		pin-controller-rear {
+		pin-controller-rear at 922f080 {
 
 			usb0 {
 				pinctrl_usb0: usb2-0 {
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index cffa50d..07b02a3 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -234,7 +234,7 @@
 					 <&clk_s_d2_quadfs 1>;
 			};
 
-			sti-hqvdp at 9c000000 {
+			sti-hqvdp at 9c00000 {
 				compatible = "st,stih407-hqvdp";
 				reg = <0x9C00000 0x100000>;
 				clock-names = "hqvdp", "pix_main";
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 4e6d915..5418a0e 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0xc0000000>;
 	};
@@ -88,7 +88,7 @@
 			non-removable;
 		};
 
-		miphy28lp_phy: miphy28lp at 9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port0: port at 9b22000 {
 				st,osc-rdy;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 9a157c1..e68bf28 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -85,7 +85,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0 at 13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -265,7 +265,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2 at x9106000 {
+		clockgen-d2 at 9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 7f80c2c..68783e8 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -80,7 +80,7 @@
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
 
-		miphy28lp_phy: miphy28lp at 9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port0: port at 9b22000 {
 				st,osc-rdy;
@@ -126,7 +126,7 @@
 			clock-names	= "c8sectpfe";
 
 			/* tsin0 is TSA on NIMA */
-			tsin0: port at 0 {
+			tsin0: port {
 				tsin-num	= <0>;
 				serial-not-parallel;
 				i2c-bus		= <&ssc2>;
-- 
1.9.1
