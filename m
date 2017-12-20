From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 20 Dec 2017 15:44:11 -0600
Subject: [PATCH] arm64: dts: stratix10: fix SPI settings
Message-ID: <1513806251-20273-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Correct the SPI Master node settings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 7c9bdc7ab50b..367bc00be802 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -248,7 +248,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xffda4000 0x1000>;
-			interrupts = <0 101 4>;
+			interrupts = <0 99 4>;
+			resets = <&rst SPIM0_RESET>;
+			reg-io-width = <4>;
 			num-chipselect = <4>;
 			bus-num = <0>;
 			status = "disabled";
@@ -259,7 +261,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xffda5000 0x1000>;
-			interrupts = <0 102 4>;
+			interrupts = <0 100 4>;
+			resets = <&rst SPIM1_RESET>;
+			reg-io-width = <4>;
 			num-chipselect = <4>;
 			bus-num = <0>;
 			status = "disabled";
-- 
2.7.4
