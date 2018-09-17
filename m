From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 17 Sep 2018 10:10:29 -0500
Subject: [PATCH] ARM: dts: socfpga: add timer resets for SoCFPGA platform
Message-ID: <1537197029-27693-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the resets property for all the timers on the Cyclone5/Arria5/Arria10
platforms.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi         | 8 ++++++++
 arch/arm/boot/dts/socfpga_arria10.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c2..fa33cd1 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -841,6 +841,8 @@
 			reg = <0xffc08000 0x1000>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
+			resets = <&rst SPTIMER0_RESET>;
+			reset-names = "timer";
 		};
 
 		timer1: timer1 at ffc09000 {
@@ -849,6 +851,8 @@
 			reg = <0xffc09000 0x1000>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
+			resets = <&rst SPTIMER1_RESET>;
+			reset-names = "timer";
 		};
 
 		timer2: timer2 at ffd00000 {
@@ -857,6 +861,8 @@
 			reg = <0xffd00000 0x1000>;
 			clocks = <&osc1>;
 			clock-names = "timer";
+			resets = <&rst OSC1TIMER0_RESET>;
+			reset-names = "timer";
 		};
 
 		timer3: timer3 at ffd01000 {
@@ -865,6 +871,8 @@
 			reg = <0xffd01000 0x1000>;
 			clocks = <&osc1>;
 			clock-names = "timer";
+			resets = <&rst OSC1TIMER1_RESET>;
+			reset-names = "timer";
 		};
 
 		uart0: serial0 at ffc02000 {
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index a4dcb68..c84c5b8 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -770,6 +770,8 @@
 			reg = <0xffc02700 0x100>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
+			resets = <&rst SPTIMER0_RESET>;
+			reset-names = "timer";
 		};
 
 		timer1: timer1 at ffc02800 {
@@ -778,6 +780,8 @@
 			reg = <0xffc02800 0x100>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
+			resets = <&rst SPTIMER1_RESET>;
+			reset-names = "timer";
 		};
 
 		timer2: timer2 at ffd00000 {
@@ -786,6 +790,8 @@
 			reg = <0xffd00000 0x100>;
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
+			resets = <&rst L4SYSTIMER0_RESET>;
+			reset-names = "timer";
 		};
 
 		timer3: timer3 at ffd00100 {
@@ -794,6 +800,8 @@
 			reg = <0xffd01000 0x100>;
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
+			resets = <&rst L4SYSTIMER1_RESET>;
+			reset-names = "timer";
 		};
 
 		uart0: serial0 at ffc02000 {
-- 
2.7.4
