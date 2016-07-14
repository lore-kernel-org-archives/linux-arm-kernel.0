From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Thu, 14 Jul 2016 18:48:57 +0200
Subject: [PATCH] ARM: tegra: fix erroneous address in dts
Message-ID: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

c90bb7b enabled the high speed UARTs of the Jetson TK1. The address
specification inside the dts is wrong. Fix it and use the correct
address.

Fixes: c90bb7b9b9 ("ARM: tegra: Add high speed UARTs to Jetson TK1 device tree")
Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 941f362..f4d8125 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1386,7 +1386,7 @@
 	 *   Pin 41: BR_UART1_TXD
 	 *   Pin 44: BR_UART1_RXD
 	 */
-	serial at 70006000 {
+	serial at 0,70006000 {
 		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
@@ -1398,7 +1398,7 @@
 	 *   Pin 71: UART2_CTS_L
 	 *   Pin 74: UART2_RTS_L
 	 */
-	serial at 70006040 {
+	serial at 0,70006040 {
 		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
-- 
2.7.3
