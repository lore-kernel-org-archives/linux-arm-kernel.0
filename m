From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 25 Jan 2017 14:51:47 -0600
Subject: [PATCH] ARM: dts: watchdog0 cannot reliably trigger reset
Message-ID: <1485377507-12045-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Arria10, because of hardware bug, watchdog0 cannot reliably trigger
a reset to the CPU. The workaround would be to use watchdog1 instead.

Also for watchdog1, there is a dependency on the bootloader to enable the
boot_clk source to be from the cb_intosc_hs_clk/2, versus from EOSC1. This
corresponds to the (SWCTRLBTCLKEN & SWCTRLBTCLKSEL) bits enabled in the
control register in the clock manager module of Arria10.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 4c99c99..c57e6ce 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -160,6 +160,6 @@
 	status = "okay";
 };
 
-&watchdog0 {
+&watchdog1 {
 	status = "okay";
 };
-- 
2.7.4
