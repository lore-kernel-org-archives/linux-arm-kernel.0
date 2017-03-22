From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:06 -0500
Subject: [PATCH 08/15] ARM: dts: tegra: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-8-robh@kernel.org>
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

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts  | 2 +-
 arch/arm/boot/dts/tegra124.dtsi            | 4 +++-
 arch/arm/boot/dts/tegra20-harmony.dts      | 2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    | 2 +-
 arch/arm/boot/dts/tegra20-tec.dts          | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    | 2 +-
 arch/arm/boot/dts/tegra20.dtsi             | 4 +++-
 arch/arm/boot/dts/tegra30-apalis-eval.dts  | 2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 2 +-
 arch/arm/boot/dts/tegra30-beaver.dts       | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      | 2 +-
 arch/arm/boot/dts/tegra30.dtsi             | 5 ++++-
 14 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 5b860ad5cbee..ecffcd115fa7 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -63,7 +63,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		pci at 1,0 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index f9e623bdd5c3..5d9b18ef5af6 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -54,7 +54,7 @@
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		status = "okay";
 
 		avddio-pex-supply = <&vdd_1v05>;
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 53994f9fbbcc..7bacb2954f58 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -27,7 +27,7 @@
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		status = "okay";
 
 		avddio-pex-supply = <&vdd_1v05_run>;
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 187a36c6d0fc..1b10b14a6abd 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -14,7 +14,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	pcie-controller at 01003000 {
+	pcie at 1003000 {
 		compatible = "nvidia,tegra124-pcie";
 		device_type = "pci";
 		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
@@ -54,6 +54,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
 			reg = <0x000800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -67,6 +68,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
 			reg = <0x001000 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index d4fb4d39ede7..41749693ec3c 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -566,7 +566,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller at 80003000 {
+	pcie at 80003000 {
 		status = "okay";
 
 		avdd-pex-supply = <&pci_vdd_reg>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 27d2bbbf1eae..7361f4a82e80 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -478,7 +478,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller at 80003000 {
+	pcie at 80003000 {
 		avdd-pex-supply = <&pci_vdd_reg>;
 		vdd-pex-supply = <&pci_vdd_reg>;
 		avdd-pex-pll-supply = <&pci_vdd_reg>;
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index c12d8bead2ee..9cb534f4441e 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -32,7 +32,7 @@
 		};
 	};
 
-	pcie-controller at 80003000 {
+	pcie at 80003000 {
 		status = "okay";
 
 		pci at 1,0 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 87b07fbadbbe..b902ab594afa 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -321,7 +321,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller at 80003000 {
+	pcie at 80003000 {
 		status = "okay";
 
 		avdd-pex-supply = <&pci_vdd_reg>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index e8807503f87c..7c85f97f72ea 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -586,7 +586,7 @@
 		reset-names = "fuse";
 	};
 
-	pcie-controller at 80003000 {
+	pcie at 80003000 {
 		compatible = "nvidia,tegra20-pcie";
 		device_type = "pci";
 		reg = <0x80003000 0x00000800   /* PADS registers */
@@ -625,6 +625,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
 			reg = <0x000800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -638,6 +639,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
 			reg = <0x001000 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 99a69457dbf5..fc530e4a96c4 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -21,7 +21,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	pcie-controller at 00003000 {
+	pcie at 3000 {
 		status = "okay";
 
 		pci at 1,0 {
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index f6c7c3e958ac..7a6a1a014603 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -9,7 +9,7 @@
 	model = "Toradex Apalis T30";
 	compatible = "toradex,apalis_t30", "nvidia,tegra30";
 
-	pcie-controller at 00003000 {
+	pcie at 3000 {
 		avdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexa-supply = <&vdd2_reg>;
 		avdd-pexb-supply = <&vdd2_reg>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 0350002849d5..4f41b18d9547 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -20,7 +20,7 @@
 		reg = <0x80000000 0x7ff00000>;
 	};
 
-	pcie-controller at 00003000 {
+	pcie at 3000 {
 		status = "okay";
 
 		avdd-pexa-supply = <&ldo1_reg>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index f11012bb58cc..83dc14a9b353 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -43,7 +43,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	pcie-controller at 00003000 {
+	pcie at 3000 {
 		status = "okay";
 
 		/* AVDD_PEXA and VDD_PEXA inputs are grounded on Cardhu. */
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index bbb1c002e7f1..13960fda7471 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -10,7 +10,7 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
 
-	pcie-controller at 00003000 {
+	pcie at 3000 {
 		compatible = "nvidia,tegra30-pcie";
 		device_type = "pci";
 		reg = <0x00003000 0x00000800   /* PADS registers */
@@ -51,6 +51,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82000800 0 0x00000000 0 0x1000>;
 			reg = <0x000800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -64,6 +65,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001000 0 0x00001000 0 0x1000>;
 			reg = <0x001000 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
@@ -77,6 +79,7 @@
 			device_type = "pci";
 			assigned-addresses = <0x82001800 0 0x00004000 0 0x1000>;
 			reg = <0x001800 0 0 0 0>;
+			bus-range = <0x00 0xff>;
 			status = "disabled";
 
 			#address-cells = <3>;
-- 
2.10.1
