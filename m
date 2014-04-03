From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 2 Apr 2014 21:40:34 -0500
Subject: [PATCH 2/2] ARM: dts: socfpga: Remove hard coded clock-frequency
 property
In-Reply-To: <1396492834-26035-1-git-send-email-dinguyen@altera.com>
References: <1396492834-26035-1-git-send-email-dinguyen@altera.com>
Message-ID: <1396492834-26035-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The timers and uart can get their clock frequencies using the common clock
driver.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi          |   10 ++++++++++
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   24 ------------------------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   24 ------------------------
 3 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 039cebb..df43702 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -630,24 +630,32 @@
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 167 4>;
 			reg = <0xffc08000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			clock-names = "timer";
 		};
 
 		timer1: timer1 at ffc09000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 168 4>;
 			reg = <0xffc09000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			clock-names = "timer";
 		};
 
 		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 169 4>;
 			reg = <0xffd00000 0x1000>;
+			clocks = <&osc1>;
+			clock-names = "timer";
 		};
 
 		timer3: timer3 at ffd01000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 170 4>;
 			reg = <0xffd01000 0x1000>;
+			clocks = <&osc1>;
+			clock-names = "timer";
 		};
 
 		uart0: serial0 at ffc02000 {
@@ -656,6 +664,7 @@
 			interrupts = <0 162 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		uart1: serial1 at ffc03000 {
@@ -664,6 +673,7 @@
 			interrupts = <0 163 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		rstmgr at ffd05000 {
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 373b340..12d1c2c 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -38,32 +38,8 @@
 			};
 		};
 
-		serial0 at ffc02000 {
-			clock-frequency = <100000000>;
-		};
-
-		serial1 at ffc03000 {
-			clock-frequency = <100000000>;
-		};
-
 		sysmgr at ffd08000 {
 			cpu1-start-addr = <0xffd080c4>;
 		};
-
-		timer0 at ffc08000 {
-			clock-frequency = <100000000>;
-		};
-
-		timer1 at ffc09000 {
-			clock-frequency = <100000000>;
-		};
-
-		timer2 at ffd00000 {
-			clock-frequency = <25000000>;
-		};
-
-		timer3 at ffd01000 {
-			clock-frequency = <25000000>;
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 63a9513..bf51182 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -45,30 +45,6 @@
 			status = "okay";
 		};
 
-		timer0 at ffc08000 {
-			clock-frequency = <100000000>;
-		};
-
-		timer1 at ffc09000 {
-			clock-frequency = <100000000>;
-		};
-
-		timer2 at ffd00000 {
-			clock-frequency = <25000000>;
-		};
-
-		timer3 at ffd01000 {
-			clock-frequency = <25000000>;
-		};
-
-		serial0 at ffc02000 {
-			clock-frequency = <100000000>;
-		};
-
-		serial1 at ffc03000 {
-			clock-frequency = <100000000>;
-		};
-
 		sysmgr at ffd08000 {
 			cpu1-start-addr = <0xffd080c4>;
 		};
-- 
1.7.9.5
