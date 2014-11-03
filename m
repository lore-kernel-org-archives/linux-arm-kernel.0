From: dev@lynxeye.de (Lucas Stach)
Date: Mon,  3 Nov 2014 23:20:04 +0100
Subject: [PATCH] ARM: tegra: add serial aliases to Tegra124 DT
Message-ID: <1415053204-30114-1-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provides consistent numbering of consoles across boards.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
These aliases are already present in the base DTs for all
other Tegra SoCs.
---
 arch/arm/boot/dts/tegra124.dtsi | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 478c555..9b53649 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -12,6 +12,13 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		serial0 = &uarta;
+		serial1 = &uartb;
+		serial2 = &uartc;
+		serial3 = &uartd;
+	};
+
 	pcie-controller at 0,01003000 {
 		compatible = "nvidia,tegra124-pcie";
 		device_type = "pci";
@@ -286,7 +293,7 @@
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
 	 */
-	serial at 0,70006000 {
+	uarta: serial at 0,70006000 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x70006000 0x0 0x40>;
 		reg-shift = <2>;
@@ -299,7 +306,7 @@
 		status = "disabled";
 	};
 
-	serial at 0,70006040 {
+	uartb: serial at 0,70006040 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x70006040 0x0 0x40>;
 		reg-shift = <2>;
@@ -312,7 +319,7 @@
 		status = "disabled";
 	};
 
-	serial at 0,70006200 {
+	uartc: serial at 0,70006200 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x70006200 0x0 0x40>;
 		reg-shift = <2>;
@@ -325,7 +332,7 @@
 		status = "disabled";
 	};
 
-	serial at 0,70006300 {
+	uartd: serial at 0,70006300 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x70006300 0x0 0x40>;
 		reg-shift = <2>;
-- 
1.9.3
