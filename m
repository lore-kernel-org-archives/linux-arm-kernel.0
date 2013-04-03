From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 3 Apr 2013 17:40:47 +0300
Subject: [PATCH v9 13/14] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1365000110-8916-14-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add references to tegra_car clocks for the basic device nodes. Also remove
the clock-frequency property of the serial node as the UART driver can now
use the clock framework to obtain the frequency.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    1 -
 arch/arm/boot/dts/tegra114-pluto.dts   |    1 -
 arch/arm/boot/dts/tegra114.dtsi        |    8 +++++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index a61974e..52f1b45 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -715,7 +715,6 @@
 
 	serial at 70006300 {
 		status = "okay";
-		clock-frequency = <408000000>;
 	};
 
 	pmc {
diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dts
index 9bea8f5..31955d7 100644
--- a/arch/arm/boot/dts/tegra114-pluto.dts
+++ b/arch/arm/boot/dts/tegra114-pluto.dts
@@ -12,7 +12,6 @@
 
 	serial at 70006300 {
 		status = "okay";
-		clock-frequency = <408000000>;
 	};
 
 	pmc {
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 5302044..33831a0 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -31,10 +31,11 @@
 			      0 42 0x04
 			      0 121 0x04
 			      0 122 0x04>;
+		clocks = <&tegra_car 5>;
 	};
 
 	tegra_car: clock {
-		compatible = "nvidia,tegra114-car, nvidia,tegra30-car";
+		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -120,6 +121,7 @@
 		interrupts = <0 36 0x04>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		status = "disabled";
+		clocks = <&tegra_car 6>;
 	};
 
 	uartb: serial at 70006040 {
@@ -129,6 +131,7 @@
 		interrupts = <0 37 0x04>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		status = "disabled";
+		clocks = <&tegra_car 192>;
 	};
 
 	uartc: serial at 70006200 {
@@ -138,6 +141,7 @@
 		interrupts = <0 46 0x04>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		status = "disabled";
+		clocks = <&tegra_car 55>;
 	};
 
 	uartd: serial at 70006300 {
@@ -147,6 +151,7 @@
 		interrupts = <0 90 0x04>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		status = "disabled";
+		clocks = <&tegra_car 65>;
 	};
 
 	pwm: pwm {
@@ -288,6 +293,7 @@
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <0 2 0x04>;
+		clocks = <&tegra_car 4>;
 	};
 
 	kbc {
-- 
1.7.7.rc0.72.g4b5ea.dirty
