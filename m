From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 19 Jun 2013 14:45:40 +0530
Subject: [PATCH v3 3/5] ARM: davinci: da850: do not specify clock_frequency
 for UART DT node
In-Reply-To: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1371633342-1210-4-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT kernel on da850-evm comes up with garbled UART logs. This is because
of mismatch in actual module clock rate and rate specified(clock-frequency)
in DT blob. kernel should not assume or depend on bootloaders clock
configuration, instead let it find the clock rate at runtime.

Issue discussed here before arriving on this implementation:
"ARM: davinci: da850 evm: update clock rate for UART 1/2 DT nodes"
https://patchwork.kernel.org/patch/2162271/

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 2c88313..4d43046 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -129,7 +129,6 @@
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			status = "disabled";
@@ -137,7 +136,6 @@
 		serial1: serial at 1d0c000 {
 			compatible = "ns16550a";
 			reg = <0x10c000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <53>;
 			status = "disabled";
@@ -145,7 +143,6 @@
 		serial2: serial at 1d0d000 {
 			compatible = "ns16550a";
 			reg = <0x10d000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <61>;
 			status = "disabled";
-- 
1.7.4.1
