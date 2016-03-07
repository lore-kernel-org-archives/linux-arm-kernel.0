From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  7 Mar 2016 12:12:15 +0000
Subject: [PATCH 2/2] ARM: dts: vexpress: fix node name unit-address presence
 warnings
In-Reply-To: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
References: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1457352735-24453-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fa38a82096a1 ("scripts/dtc: Update to upstream version
53bf130b1cdd") added warnings on node name unit-address presence/absence
mismatch in device trees.

This patch fixes those warning on all the vexpress platforms where
unit-address is present in node name while the reg/ranges property is
not present.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     | 44 ++++++++++++++---------------
 arch/arm/boot/dts/vexpress-v2m.dtsi         | 44 ++++++++++++++---------------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 24 ++++++++--------
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 42 +++++++++++++--------------
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     | 16 +++++------
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      | 28 +++++++++---------
 6 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 21b02874bea3..e0e4f8a15752 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -75,19 +75,19 @@
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x010000 0x1000>;
 
-				v2m_led_gpios: sys_led at 08 {
+				v2m_led_gpios: sys_led {
 					compatible = "arm,vexpress-sysreg,sys_led";
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
 
-				v2m_mmc_gpios: sys_mci at 48 {
+				v2m_mmc_gpios: sys_mci {
 					compatible = "arm,vexpress-sysreg,sys_mci";
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
 
-				v2m_flash_gpios: sys_flash at 4c {
+				v2m_flash_gpios: sys_flash {
 					compatible = "arm,vexpress-sysreg,sys_flash";
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -286,7 +286,7 @@
 			};
 		};
 
-		v2m_fixed_3v3: fixedregulator at 0 {
+		v2m_fixed_3v3: fixedregulator0 {
 			compatible = "regulator-fixed";
 			regulator-name = "3V3";
 			regulator-min-microvolt = <3300000>;
@@ -318,49 +318,49 @@
 		leds {
 			compatible = "gpio-leds";
 
-			user at 1 {
+			user1 {
 				label = "v2m:green:user1";
 				gpios = <&v2m_led_gpios 0 0>;
 				linux,default-trigger = "heartbeat";
 			};
 
-			user at 2 {
+			user2 {
 				label = "v2m:green:user2";
 				gpios = <&v2m_led_gpios 1 0>;
 				linux,default-trigger = "mmc0";
 			};
 
-			user at 3 {
+			user3 {
 				label = "v2m:green:user3";
 				gpios = <&v2m_led_gpios 2 0>;
 				linux,default-trigger = "cpu0";
 			};
 
-			user at 4 {
+			user4 {
 				label = "v2m:green:user4";
 				gpios = <&v2m_led_gpios 3 0>;
 				linux,default-trigger = "cpu1";
 			};
 
-			user at 5 {
+			user5 {
 				label = "v2m:green:user5";
 				gpios = <&v2m_led_gpios 4 0>;
 				linux,default-trigger = "cpu2";
 			};
 
-			user at 6 {
+			user6 {
 				label = "v2m:green:user6";
 				gpios = <&v2m_led_gpios 5 0>;
 				linux,default-trigger = "cpu3";
 			};
 
-			user at 7 {
+			user7 {
 				label = "v2m:green:user7";
 				gpios = <&v2m_led_gpios 6 0>;
 				linux,default-trigger = "cpu4";
 			};
 
-			user at 8 {
+			user8 {
 				label = "v2m:green:user8";
 				gpios = <&v2m_led_gpios 7 0>;
 				linux,default-trigger = "cpu5";
@@ -371,7 +371,7 @@
 			compatible = "arm,vexpress,config-bus";
 			arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-			osc at 0 {
+			osc0 {
 				/* MCC static memory clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 0>;
@@ -380,7 +380,7 @@
 				clock-output-names = "v2m:oscclk0";
 			};
 
-			v2m_oscclk1: osc at 1 {
+			v2m_oscclk1: osc1 {
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
@@ -389,7 +389,7 @@
 				clock-output-names = "v2m:oscclk1";
 			};
 
-			v2m_oscclk2: osc at 2 {
+			v2m_oscclk2: osc2 {
 				/* IO FPGA peripheral clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 2>;
@@ -398,7 +398,7 @@
 				clock-output-names = "v2m:oscclk2";
 			};
 
-			volt at 0 {
+			volt {
 				/* Logic level voltage */
 				compatible = "arm,vexpress-volt";
 				arm,vexpress-sysreg,func = <2 0>;
@@ -407,34 +407,34 @@
 				label = "VIO";
 			};
 
-			temp at 0 {
+			temp {
 				/* MCC internal operating temperature */
 				compatible = "arm,vexpress-temp";
 				arm,vexpress-sysreg,func = <4 0>;
 				label = "MCC";
 			};
 
-			reset at 0 {
+			reset {
 				compatible = "arm,vexpress-reset";
 				arm,vexpress-sysreg,func = <5 0>;
 			};
 
-			muxfpga at 0 {
+			muxfpga {
 				compatible = "arm,vexpress-muxfpga";
 				arm,vexpress-sysreg,func = <7 0>;
 			};
 
-			shutdown at 0 {
+			shutdown {
 				compatible = "arm,vexpress-shutdown";
 				arm,vexpress-sysreg,func = <8 0>;
 			};
 
-			reboot at 0 {
+			reboot {
 				compatible = "arm,vexpress-reboot";
 				arm,vexpress-sysreg,func = <9 0>;
 			};
 
-			dvimode at 0 {
+			dvimode {
 				compatible = "arm,vexpress-dvimode";
 				arm,vexpress-sysreg,func = <11 0>;
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index e712c0af149b..f0d22a4cd3b6 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -74,19 +74,19 @@
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x00000 0x1000>;
 
-				v2m_led_gpios: sys_led at 08 {
+				v2m_led_gpios: sys_led {
 					compatible = "arm,vexpress-sysreg,sys_led";
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
 
-				v2m_mmc_gpios: sys_mci at 48 {
+				v2m_mmc_gpios: sys_mci {
 					compatible = "arm,vexpress-sysreg,sys_mci";
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
 
-				v2m_flash_gpios: sys_flash at 4c {
+				v2m_flash_gpios: sys_flash {
 					compatible = "arm,vexpress-sysreg,sys_flash";
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -285,7 +285,7 @@
 			};
 		};
 
-		v2m_fixed_3v3: fixedregulator at 0 {
+		v2m_fixed_3v3: fixedregulator0 {
 			compatible = "regulator-fixed";
 			regulator-name = "3V3";
 			regulator-min-microvolt = <3300000>;
@@ -317,49 +317,49 @@
 		leds {
 			compatible = "gpio-leds";
 
-			user at 1 {
+			user1 {
 				label = "v2m:green:user1";
 				gpios = <&v2m_led_gpios 0 0>;
 				linux,default-trigger = "heartbeat";
 			};
 
-			user at 2 {
+			user2 {
 				label = "v2m:green:user2";
 				gpios = <&v2m_led_gpios 1 0>;
 				linux,default-trigger = "mmc0";
 			};
 
-			user at 3 {
+			user3 {
 				label = "v2m:green:user3";
 				gpios = <&v2m_led_gpios 2 0>;
 				linux,default-trigger = "cpu0";
 			};
 
-			user at 4 {
+			user4 {
 				label = "v2m:green:user4";
 				gpios = <&v2m_led_gpios 3 0>;
 				linux,default-trigger = "cpu1";
 			};
 
-			user at 5 {
+			user5 {
 				label = "v2m:green:user5";
 				gpios = <&v2m_led_gpios 4 0>;
 				linux,default-trigger = "cpu2";
 			};
 
-			user at 6 {
+			user6 {
 				label = "v2m:green:user6";
 				gpios = <&v2m_led_gpios 5 0>;
 				linux,default-trigger = "cpu3";
 			};
 
-			user at 7 {
+			user7 {
 				label = "v2m:green:user7";
 				gpios = <&v2m_led_gpios 6 0>;
 				linux,default-trigger = "cpu4";
 			};
 
-			user at 8 {
+			user8 {
 				label = "v2m:green:user8";
 				gpios = <&v2m_led_gpios 7 0>;
 				linux,default-trigger = "cpu5";
@@ -370,7 +370,7 @@
 			compatible = "arm,vexpress,config-bus";
 			arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-			osc at 0 {
+			osc0 {
 				/* MCC static memory clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 0>;
@@ -379,7 +379,7 @@
 				clock-output-names = "v2m:oscclk0";
 			};
 
-			v2m_oscclk1: osc at 1 {
+			v2m_oscclk1: osc1 {
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
@@ -388,7 +388,7 @@
 				clock-output-names = "v2m:oscclk1";
 			};
 
-			v2m_oscclk2: osc at 2 {
+			v2m_oscclk2: osc2 {
 				/* IO FPGA peripheral clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 2>;
@@ -397,7 +397,7 @@
 				clock-output-names = "v2m:oscclk2";
 			};
 
-			volt at 0 {
+			volt {
 				/* Logic level voltage */
 				compatible = "arm,vexpress-volt";
 				arm,vexpress-sysreg,func = <2 0>;
@@ -406,34 +406,34 @@
 				label = "VIO";
 			};
 
-			temp at 0 {
+			temp {
 				/* MCC internal operating temperature */
 				compatible = "arm,vexpress-temp";
 				arm,vexpress-sysreg,func = <4 0>;
 				label = "MCC";
 			};
 
-			reset at 0 {
+			reset {
 				compatible = "arm,vexpress-reset";
 				arm,vexpress-sysreg,func = <5 0>;
 			};
 
-			muxfpga at 0 {
+			muxfpga {
 				compatible = "arm,vexpress-muxfpga";
 				arm,vexpress-sysreg,func = <7 0>;
 			};
 
-			shutdown at 0 {
+			shutdown {
 				compatible = "arm,vexpress-shutdown";
 				arm,vexpress-sysreg,func = <8 0>;
 			};
 
-			reboot at 0 {
+			reboot {
 				compatible = "arm,vexpress-reboot";
 				arm,vexpress-sysreg,func = <9 0>;
 			};
 
-			dvimode at 0 {
+			dvimode {
 				compatible = "arm,vexpress-dvimode";
 				arm,vexpress-sysreg,func = <11 0>;
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 9420053acc14..a58a7a2fbff4 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -126,7 +126,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		osc at 0 {
+		osc0 {
 			/* CPU PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -135,7 +135,7 @@
 			clock-output-names = "oscclk0";
 		};
 
-		osc at 4 {
+		osc4 {
 			/* Multiplexed AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -144,7 +144,7 @@
 			clock-output-names = "oscclk4";
 		};
 
-		oscclk5: osc at 5 {
+		oscclk5: osc5 {
 			/* HDLCD PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
@@ -153,7 +153,7 @@
 			clock-output-names = "oscclk5";
 		};
 
-		smbclk: osc at 6 {
+		smbclk: osc6 {
 			/* SMB clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 6>;
@@ -162,7 +162,7 @@
 			clock-output-names = "oscclk6";
 		};
 
-		oscclk7: osc at 7 {
+		oscclk7: osc7 {
 			/* SYS PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 7>;
@@ -171,7 +171,7 @@
 			clock-output-names = "oscclk7";
 		};
 
-		osc at 8 {
+		osc8 {
 			/* DDR2 PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 8>;
@@ -180,7 +180,7 @@
 			clock-output-names = "oscclk8";
 		};
 
-		volt at 0 {
+		volt0 {
 			/* CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -191,28 +191,28 @@
 			label = "Cores";
 		};
 
-		amp at 0 {
+		amp0 {
 			/* Total current for the two cores */
 			compatible = "arm,vexpress-amp";
 			arm,vexpress-sysreg,func = <3 0>;
 			label = "Cores";
 		};
 
-		temp at 0 {
+		temp0 {
 			/* DCC internal temperature */
 			compatible = "arm,vexpress-temp";
 			arm,vexpress-sysreg,func = <4 0>;
 			label = "DCC";
 		};
 
-		power at 0 {
+		power0 {
 			/* Total power */
 			compatible = "arm,vexpress-power";
 			arm,vexpress-sysreg,func = <12 0>;
 			label = "Cores";
 		};
 
-		energy at 0 {
+		energy0 {
 			/* Total energy */
 			compatible = "arm,vexpress-energy";
 			arm,vexpress-sysreg,func = <13 0>;
@@ -220,7 +220,7 @@
 		};
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 17f63f7dfd9e..791beaac2509 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -227,7 +227,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		osc at 0 {
+		osc0 {
 			/* A15 PLL 0 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -236,7 +236,7 @@
 			clock-output-names = "oscclk0";
 		};
 
-		osc at 1 {
+		osc1 {
 			/* A15 PLL 1 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -245,7 +245,7 @@
 			clock-output-names = "oscclk1";
 		};
 
-		osc at 2 {
+		osc2 {
 			/* A7 PLL 0 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -254,7 +254,7 @@
 			clock-output-names = "oscclk2";
 		};
 
-		osc at 3 {
+		osc3 {
 			/* A7 PLL 1 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 3>;
@@ -263,7 +263,7 @@
 			clock-output-names = "oscclk3";
 		};
 
-		osc at 4 {
+		osc4 {
 			/* External AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -272,7 +272,7 @@
 			clock-output-names = "oscclk4";
 		};
 
-		oscclk5: osc at 5 {
+		oscclk5: osc5 {
 			/* HDLCD PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
@@ -281,7 +281,7 @@
 			clock-output-names = "oscclk5";
 		};
 
-		smbclk: osc at 6 {
+		smbclk: osc6 {
 			/* Static memory controller clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 6>;
@@ -290,7 +290,7 @@
 			clock-output-names = "oscclk6";
 		};
 
-		osc at 7 {
+		osc7 {
 			/* SYS PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 7>;
@@ -299,7 +299,7 @@
 			clock-output-names = "oscclk7";
 		};
 
-		osc at 8 {
+		osc8 {
 			/* DDR2 PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 8>;
@@ -308,7 +308,7 @@
 			clock-output-names = "oscclk8";
 		};
 
-		volt at 0 {
+		volt0 {
 			/* A15 CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -319,7 +319,7 @@
 			label = "A15 Vcore";
 		};
 
-		volt at 1 {
+		volt1 {
 			/* A7 CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
@@ -330,49 +330,49 @@
 			label = "A7 Vcore";
 		};
 
-		amp at 0 {
+		amp0 {
 			/* Total current for the two A15 cores */
 			compatible = "arm,vexpress-amp";
 			arm,vexpress-sysreg,func = <3 0>;
 			label = "A15 Icore";
 		};
 
-		amp at 1 {
+		amp1 {
 			/* Total current for the three A7 cores */
 			compatible = "arm,vexpress-amp";
 			arm,vexpress-sysreg,func = <3 1>;
 			label = "A7 Icore";
 		};
 
-		temp at 0 {
+		temp0 {
 			/* DCC internal temperature */
 			compatible = "arm,vexpress-temp";
 			arm,vexpress-sysreg,func = <4 0>;
 			label = "DCC";
 		};
 
-		power at 0 {
+		power0 {
 			/* Total power for the two A15 cores */
 			compatible = "arm,vexpress-power";
 			arm,vexpress-sysreg,func = <12 0>;
 			label = "A15 Pcore";
 		};
 
-		power at 1 {
+		power1 {
 			/* Total power for the three A7 cores */
 			compatible = "arm,vexpress-power";
 			arm,vexpress-sysreg,func = <12 1>;
 			label = "A7 Pcore";
 		};
 
-		energy at 0 {
+		energy0 {
 			/* Total energy for the two A15 cores */
 			compatible = "arm,vexpress-energy";
 			arm,vexpress-sysreg,func = <13 0>, <13 1>;
 			label = "A15 Jcore";
 		};
 
-		energy at 2 {
+		energy2 {
 			/* Total energy for the three A7 cores */
 			compatible = "arm,vexpress-energy";
 			arm,vexpress-sysreg,func = <13 2>, <13 3>;
@@ -387,7 +387,7 @@
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
 		port {
-			etb_in_port: endpoint at 0 {
+			etb_in_port: endpoint {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port0>;
 			};
@@ -401,7 +401,7 @@
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
 		port {
-			tpiu_in_port: endpoint at 0 {
+			tpiu_in_port: endpoint {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port1>;
 			};
@@ -578,7 +578,7 @@
 		};
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index d2709b73316b..dd6fbbe08a23 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -128,7 +128,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		oscclk0: osc at 0 {
+		oscclk0: osc0 {
 			/* CPU and internal AXI reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -137,7 +137,7 @@
 			clock-output-names = "oscclk0";
 		};
 
-		oscclk1: osc at 1 {
+		oscclk1: osc1 {
 			/* Multiplexed AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -146,7 +146,7 @@
 			clock-output-names = "oscclk1";
 		};
 
-		osc at 2 {
+		osc2 {
 			/* DDR2 */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -155,7 +155,7 @@
 			clock-output-names = "oscclk2";
 		};
 
-		oscclk3: osc at 3 {
+		oscclk3: osc3 {
 			/* HDLCD */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 3>;
@@ -164,7 +164,7 @@
 			clock-output-names = "oscclk3";
 		};
 
-		osc at 4 {
+		osc4 {
 			/* Test chip gate configuration */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -173,7 +173,7 @@
 			clock-output-names = "oscclk4";
 		};
 
-		smbclk: osc at 5 {
+		smbclk: osc5 {
 			/* SMB clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
@@ -182,7 +182,7 @@
 			clock-output-names = "oscclk5";
 		};
 
-		temp at 0 {
+		temp0 {
 			/* DCC internal operating temperature */
 			compatible = "arm,vexpress-temp";
 			arm,vexpress-sysreg,func = <4 0>;
@@ -190,7 +190,7 @@
 		};
 	};
 
-	smb {
+	smb at 0,08000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index d949facba376..ef883e2015ac 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -190,7 +190,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		osc at 0 {
+		osc0 {
 			/* ACLK clock to the AXI master port on the test chip */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -199,7 +199,7 @@
 			clock-output-names = "extsaxiclk";
 		};
 
-		oscclk1: osc at 1 {
+		oscclk1: osc1 {
 			/* Reference clock for the CLCD */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -208,7 +208,7 @@
 			clock-output-names = "clcdclk";
 		};
 
-		smbclk: oscclk2: osc at 2 {
+		smbclk: oscclk2: osc2 {
 			/* Reference clock for the test chip internal PLLs */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -217,7 +217,7 @@
 			clock-output-names = "tcrefclk";
 		};
 
-		volt at 0 {
+		volt0 {
 			/* Test Chip internal logic voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -226,7 +226,7 @@
 			label = "VD10";
 		};
 
-		volt at 1 {
+		volt1 {
 			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
@@ -235,7 +235,7 @@
 			label = "VD10_S2";
 		};
 
-		volt at 2 {
+		volt2 {
 			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 2>;
@@ -244,7 +244,7 @@
 			label = "VD10_S3";
 		};
 
-		volt at 3 {
+		volt3 {
 			/* DDR2 SDRAM and Test Chip DDR2 I/O supply */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 3>;
@@ -253,7 +253,7 @@
 			label = "VCC1V8";
 		};
 
-		volt at 4 {
+		volt4 {
 			/* DDR2 SDRAM VTT termination voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 4>;
@@ -262,7 +262,7 @@
 			label = "DDR2VTT";
 		};
 
-		volt at 5 {
+		volt5 {
 			/* Local board supply for miscellaneous logic external to the Test Chip */
 			arm,vexpress-sysreg,func = <2 5>;
 			compatible = "arm,vexpress-volt";
@@ -271,28 +271,28 @@
 			label = "VCC3V3";
 		};
 
-		amp at 0 {
+		amp0 {
 			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
 			compatible = "arm,vexpress-amp";
 			arm,vexpress-sysreg,func = <3 0>;
 			label = "VD10_S2";
 		};
 
-		amp at 1 {
+		amp1 {
 			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
 			compatible = "arm,vexpress-amp";
 			arm,vexpress-sysreg,func = <3 1>;
 			label = "VD10_S3";
 		};
 
-		power at 0 {
+		power0 {
 			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
 			compatible = "arm,vexpress-power";
 			arm,vexpress-sysreg,func = <12 0>;
 			label = "PVD10_S2";
 		};
 
-		power at 1 {
+		power1 {
 			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
 			compatible = "arm,vexpress-power";
 			arm,vexpress-sysreg,func = <12 1>;
@@ -300,7 +300,7 @@
 		};
 	};
 
-	smb {
+	smb at 0,04000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
-- 
1.9.1
