From: vbhadram@nvidia.com (Bhadram Varka)
Date: Sat, 2 Jun 2018 14:50:49 +0530
Subject: [PATCH V2 1/3] arm64: tegra: Remove unused interrupt properties
Message-ID: <1527931251-4809-1-git-send-email-vbhadram@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DWC EQOS on Tegra handles all interrupts through
common interrupt line. So lets remove unused power
and per-channel interrupt properties.

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..252133b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -41,16 +41,7 @@
 		compatible = "nvidia,tegra186-eqos",
 			     "snps,dwc-qos-ethernet-4.10";
 		reg = <0x0 0x02490000 0x0 0x10000>;
-		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* common */
-			     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>, /* power */
-			     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>, /* rx0 */
-			     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>, /* tx0 */
-			     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* rx1 */
-			     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>, /* tx1 */
-			     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* rx2 */
-			     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* tx2 */
-			     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* rx3 */
-			     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>; /* tx3 */
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>; /* common */
 		clocks = <&bpmp TEGRA186_CLK_AXI_CBB>,
 			 <&bpmp TEGRA186_CLK_EQOS_AXI>,
 			 <&bpmp TEGRA186_CLK_EQOS_RX>,
-- 
2.7.4
