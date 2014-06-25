From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 25 Jun 2014 22:10:01 +0200
Subject: [PATCH] ARM: tegra: Migrate Apalis T30 PCIe power supply scheme
Message-ID: <67868f9464baee36eba48582d56f586ad69d3e86.1403725976.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This migration is required for continued PCIe operation after commit:

d3c7e24b84fcb62f96fa9a585a41f1829f326878

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d04efcf..8adaa78 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -9,9 +9,14 @@
 	compatible = "toradex,apalis_t30", "nvidia,tegra30";
 
 	pcie-controller at 00003000 {
-		pex-clk-supply = <&sys_3v3_reg>;
-		vdd-supply = <&vdd2_reg>;
-		avdd-supply = <&ldo6_reg>;
+		avdd-pexa-supply = <&vdd2_reg>;
+		vdd-pexa-supply = <&vdd2_reg>;
+		avdd-pexb-supply = <&vdd2_reg>;
+		vdd-pexb-supply = <&vdd2_reg>;
+		avdd-pex-pll-supply = <&vdd2_reg>;
+		avdd-plle-supply = <&ldo6_reg>;
+		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		hvdd-pex-supply = <&sys_3v3_reg>;
 
 		pci at 1,0 {
 			nvidia,num-lanes = <4>;
-- 
1.7.9.5
