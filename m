From: treding@nvidia.com (Thierry Reding)
Date: Fri, 4 Apr 2014 16:49:29 +0200
Subject: [RFC 5/5] ARM: tegra: Remove legacy PCIe power supply properties
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
Message-ID: <1396622969-17837-6-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These properties are deprecated and no longer of any use.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 4 ----
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 4 ----
 arch/arm/boot/dts/tegra20-trimslice.dts | 4 ----
 arch/arm/boot/dts/tegra30-beaver.dts    | 5 -----
 arch/arm/boot/dts/tegra30-cardhu.dtsi   | 5 -----
 5 files changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 7d5d0aa1778a..e9f8710c45ce 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -569,10 +569,6 @@
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
-
 		pci at 1,0 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 0e33577750ae..a4914bba1a39 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -478,10 +478,6 @@
 		avdd-pex-pll-supply = <&pci_vdd_reg>;
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
-
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
 	};
 
 	usb at c5008000 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 401b32e44369..5ad87979ab13 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -325,10 +325,6 @@
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
-
 		pci at 1,0 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index b434ec1f278a..101139d75d1d 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -27,11 +27,6 @@
 		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		hvdd-pex-supply = <&sys_3v3_pexs_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&sys_3v3_pexs_reg>;
-		vdd-supply = <&ldo1_reg>;
-		avdd-supply = <&ldo2_reg>;
-
 		pci at 1,0 {
 			status = "okay";
 			nvidia,num-lanes = <2>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 55051a808ced..2f0b1d37be39 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -47,11 +47,6 @@
 		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		avdd-plle-supply = <&ldo2_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pex_hvdd_3v3_reg>;
-		vdd-supply = <&ldo1_reg>;
-		avdd-supply = <&ldo2_reg>;
-
 		pci at 1,0 {
 			nvidia,num-lanes = <4>;
 		};
-- 
1.9.1
