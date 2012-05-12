From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:54 -0600
Subject: [PATCH 2/9] ARM: dt: tegra: remove unnecessary unit addresses
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

DT node names only need to include the unit address if it's required to
make the node name unique. Remove the unnecessary unit addresses.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts    |    4 ++--
 arch/arm/boot/dts/tegra-harmony.dts   |    6 +++---
 arch/arm/boot/dts/tegra-paz00.dts     |    6 +++---
 arch/arm/boot/dts/tegra-seaboard.dts  |    4 ++--
 arch/arm/boot/dts/tegra-trimslice.dts |    4 ++--
 arch/arm/boot/dts/tegra-ventana.dts   |    2 +-
 arch/arm/boot/dts/tegra20.dtsi        |   16 ++++++++--------
 arch/arm/boot/dts/tegra30.dtsi        |   12 ++++++------
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 378b65e..653d628 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -10,7 +10,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -156,7 +156,7 @@
 		support-8bit;
 	};
 
-	ahub at 70080000 {
+	ahub {
 		i2s at 70080300 {
 			status = "disable";
 		};
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 04647b3..759e289 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -6,11 +6,11 @@
 	model = "NVIDIA Tegra2 Harmony evaluation board";
 	compatible = "nvidia,harmony", "nvidia,tegra20";
 
-	memory at 0 {
+	memory {
 		reg = <0x00000000 0x40000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -234,7 +234,7 @@
 		};
 	};
 
-	pmc at 7000f400 {
+	pmc {
 		nvidia,invert-interrupt;
 	};
 
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 34a9177..4983ef1 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -6,11 +6,11 @@
 	model = "Toshiba AC100 / Dynabook AZ";
 	compatible = "compal,paz00", "nvidia,tegra20";
 
-	memory at 0 {
+	memory {
 		reg = <0x00000000 0x20000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -245,7 +245,7 @@
 		status = "disable";
 	};
 
-	nvec at 7000c500 {
+	nvec {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,nvec";
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index d4cbd80..ea93332 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -11,7 +11,7 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -411,7 +411,7 @@
 		};
 	};
 
-	emc at 7000f400 {
+	emc {
 		emc-table at 190000 {
 			reg = <190000>;
 			compatible = "nvidia,tegra20-emc-table";
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 7181a5e..4436b42 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -6,11 +6,11 @@
 	model = "Compulab TrimSlice board";
 	compatible = "compulab,trimslice", "nvidia,tegra20";
 
-	memory at 0 {
+	memory {
 		reg = <0x00000000 0x40000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 9d2bc27..0c8d30d 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -10,7 +10,7 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	pinmux at 70000000 {
+	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index f98be33..a6b1351 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,12 +4,12 @@
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&intc>;
 
-	pmc at 7000f400 {
+	pmc {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
 	};
 
-	intc: interrupt-controller at 50041000 {
+	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
@@ -23,7 +23,7 @@
 			      0 57 0x04>;
 	};
 
-	apbdma: dma at 6000a000 {
+	apbdma: dma {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
 		interrupts = <0 104 0x04
@@ -90,12 +90,12 @@
 		nvidia,dma-request-selector = <&apbdma 1>;
 	};
 
-	das at 70000c00 {
+	das {
 		compatible = "nvidia,tegra20-das";
 		reg = <0x70000c00 0x80>;
 	};
 
-	gpio: gpio at 6000d000 {
+	gpio: gpio {
 		compatible = "nvidia,tegra20-gpio";
 		reg = <0x6000d000 0x1000>;
 		interrupts = <0 32 0x04
@@ -111,7 +111,7 @@
 		interrupt-controller;
 	};
 
-	pinmux: pinmux@70000000 {
+	pinmux: pinmux {
 		compatible = "nvidia,tegra20-pinmux";
 		reg = <0x70000014 0x10   /* Tri-state registers */
 		       0x70000080 0x20   /* Mux registers */
@@ -154,7 +154,7 @@
 		interrupts = <0 91 0x04>;
 	};
 
-	emc at 7000f400 {
+	emc {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-emc";
@@ -207,7 +207,7 @@
 		phy_type = "utmi";
 	};
 
-	ahb: ahb at 6000c004 {
+	ahb {
 		compatible = "nvidia,tegra20-ahb";
 		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
 	};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 5dd6556..45547ad 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -4,12 +4,12 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&intc>;
 
-	pmc at 7000f400 {
+	pmc {
 		compatible = "nvidia,tegra20-pmc", "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
 	};
 
-	intc: interrupt-controller at 50041000 {
+	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
@@ -25,7 +25,7 @@
 			      0 147 0x04>;
 	};
 
-	apbdma: dma at 6000a000 {
+	apbdma: dma {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
 		interrupts = <0 104 0x04
@@ -102,7 +102,7 @@
 		interrupts = <0 53 0x04>;
 	};
 
-	gpio: gpio at 6000d000 {
+	gpio: gpio {
 		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
 		reg = <0x6000d000 0x1000>;
 		interrupts = <0 32 0x04
@@ -178,7 +178,7 @@
 		interrupts = <0 31 0x04>;
 	};
 
-	pinmux: pinmux at 70000000 {
+	pinmux: pinmux {
 		compatible = "nvidia,tegra30-pinmux";
 		reg = <0x70000868 0xd0    /* Pad control registers */
 		       0x70003000 0x3e0>; /* Mux registers */
@@ -225,7 +225,7 @@
 		};
 	};
 
-	ahb: ahb at 6000c004 {
+	ahb: ahb {
 		compatible = "nvidia,tegra30-ahb";
 		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
 	};
-- 
1.7.0.4
