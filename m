From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:09 -0500
Subject: [PATCH 11/15] arm64: dts: nvidia: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-11-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-tegra at vger.kernel.org
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 3f3a46a4bd01..b0720904c244 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -12,7 +12,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		compatible = "nvidia,tegra124-pcie";
 		device_type = "pci";
 		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
@@ -55,6 +55,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
 			reg = <0x000800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -68,6 +69,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
 			reg = <0x001000 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 4c1ea7a08d43..7cb95e042117 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -7,7 +7,7 @@
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		status = "okay";
 
 		avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2f832df29da8..ec1919425978 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -11,7 +11,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		compatible = "nvidia,tegra210-pcie";
 		device_type = "pci";
 		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
@@ -51,6 +51,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
 			reg = <0x000800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -64,6 +65,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
 			reg = <0x001000 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
-- 
2.10.1
