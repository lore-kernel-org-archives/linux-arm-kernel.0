From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 12:23:05 -0700
Subject: [PATCH 1/2] ARM: tegra: add missing unit addresses to DT
Message-ID: <1386876186-2247-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

DT node names should include a unit address iff the node has a reg
property. For Tegra DTs at least, we were previously applying a different
rule, namely that node names only needed to include a unit address if it
was required to make the node name unique. Consequently, many unit
addresses are missing. Add them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I thought I'd sent these out already, but evidently not. I'll be
immediately applying them to Tegra's for-3.14/dt branch.

 arch/arm/boot/dts/tegra114-dalmore.dts     | 18 +++++-----
 arch/arm/boot/dts/tegra114.dtsi            | 24 ++++++-------
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 12 +++----
 arch/arm/boot/dts/tegra20-harmony.dts      | 14 ++++----
 arch/arm/boot/dts/tegra20-iris-512.dts     |  6 ++--
 arch/arm/boot/dts/tegra20-medcom-wide.dts  |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts        | 12 +++----
 arch/arm/boot/dts/tegra20-plutux.dts       |  4 +--
 arch/arm/boot/dts/tegra20-seaboard.dts     | 12 +++----
 arch/arm/boot/dts/tegra20-tamonten.dtsi    | 12 +++----
 arch/arm/boot/dts/tegra20-tec.dts          |  6 ++--
 arch/arm/boot/dts/tegra20-trimslice.dts    | 12 +++----
 arch/arm/boot/dts/tegra20-ventana.dts      | 10 +++---
 arch/arm/boot/dts/tegra20-whistler.dts     | 14 ++++----
 arch/arm/boot/dts/tegra20.dtsi             | 54 +++++++++++++++---------------
 arch/arm/boot/dts/tegra30-beaver.dts       | 18 +++++-----
 arch/arm/boot/dts/tegra30-cardhu.dtsi      | 12 +++----
 arch/arm/boot/dts/tegra30.dtsi             | 50 +++++++++++++--------------
 18 files changed, 146 insertions(+), 146 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index cb5ec23b03a7..5d2d6f6387e8 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -11,7 +11,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	pinmux {
+	pinmux at 70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -722,7 +722,7 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
-		battery: smart-battery {
+		battery: smart-battery at b {
 			compatible = "ti,bq20z45", "sbs,sbs-battery";
 			reg = <0xb>;
 			battery-name = "battery";
@@ -731,7 +731,7 @@
 			power-supplies = <&charger>;
 		};
 
-		rt5640: rt5640 {
+		rt5640: rt5640 at 1c {
 			compatible = "realtek,rt5640";
 			reg = <0x1c>;
 			interrupt-parent = <&gpio>;
@@ -753,7 +753,7 @@
 		status = "okay";
 		clock-frequency = <400000>;
 
-		tps51632 {
+		tps51632 at 43 {
 			compatible = "ti,tps51632";
 			reg = <0x43>;
 			regulator-name = "vdd-cpu";
@@ -763,7 +763,7 @@
 			regulator-always-on;
 		};
 
-		tps65090 {
+		tps65090 at 48 {
 			compatible = "ti,tps65090";
 			reg = <0x48>;
 			interrupt-parent = <&gpio>;
@@ -846,7 +846,7 @@
 			};
 		};
 
-		palmas: tps65913 {
+		palmas: tps65913 at 58 {
 			compatible = "ti,palmas";
 			reg = <0x58>;
 			interrupts = <0 86 IRQ_TYPE_LEVEL_LOW>;
@@ -1046,7 +1046,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <500>;
@@ -1057,7 +1057,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	ahub {
+	ahub at 70080000 {
 		i2s at 70080400 {
 			status = "okay";
 		};
@@ -1089,7 +1089,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 731249fbe206..8fdf8d5cff09 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -15,7 +15,7 @@
 		serial3 = &uartd;
 	};
 
-	gic: interrupt-controller {
+	gic: interrupt-controller at 50041000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
@@ -39,14 +39,14 @@
 		clocks = <&tegra_car TEGRA114_CLK_TIMER>;
 	};
 
-	tegra_car: clock {
+	tegra_car: clock at 60006000 {
 		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
 
-	apbdma: dma {
+	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra114-apbdma";
 		reg = <0x6000a000 0x1400>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -87,12 +87,12 @@
 		#dma-cells = <1>;
 	};
 
-	ahb: ahb {
+	ahb: ahb at 6000c004 {
 		compatible = "nvidia,tegra114-ahb", "nvidia,tegra30-ahb";
 		reg = <0x6000c004 0x14c>;
 	};
 
-	gpio: gpio {
+	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
@@ -109,7 +109,7 @@
 		interrupt-controller;
 	};
 
-	pinmux: pinmux {
+	pinmux: pinmux at 70000868 {
 		compatible = "nvidia,tegra114-pinmux";
 		reg = <0x70000868 0x148		/* Pad control registers */
 		       0x70003000 0x40c>;	/* Mux registers */
@@ -175,7 +175,7 @@
 		status = "disabled";
 	};
 
-	pwm: pwm {
+	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra114-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
@@ -350,14 +350,14 @@
 		status = "disabled";
 	};
 
-	rtc {
+	rtc at 7000e000 {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_RTC>;
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		compatible = "nvidia,tegra114-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -367,14 +367,14 @@
 		status = "disabled";
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	iommu {
+	iommu at 70019010 {
 		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
 		reg = <0x70019010 0x02c
 		       0x700191f0 0x010
@@ -385,7 +385,7 @@
 		nvidia,ahb = <&ahb>;
 	};
 
-	ahub {
+	ahub at 70080000 {
 		compatible = "nvidia,tegra114-ahub";
 		reg = <0x70080000 0x200>,
 		      <0x70080200 0x100>,
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index d5c9bca01232..f20fc9794e89 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -8,8 +8,8 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			vdd-supply = <&hdmi_vdd_reg>;
 			pll-supply = <&hdmi_pll_reg>;
 
@@ -19,7 +19,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -362,7 +362,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
@@ -442,7 +442,7 @@
 		};
 	};
 
-	ac97: ac97 {
+	ac97: ac97 at 70002000 {
 		status = "okay";
 		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
 			GPIO_ACTIVE_HIGH>;
@@ -471,7 +471,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index e156ab30e763..b9c6f67e87ef 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -415,7 +415,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
@@ -425,7 +425,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller {
+	pcie-controller at 80003000 {
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
 		status = "okay";
@@ -488,7 +488,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
@@ -507,7 +507,7 @@
 		};
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		status = "okay";
 		nvidia,debounce-delay-ms = <2>;
 		nvidia,repeat-delay-ms = <160>;
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index f2222bd74eab..770fc66e5fce 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -6,13 +6,13 @@
 	model = "Toradex Colibri T20 512MB on Iris";
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		state_default: pinmux {
 			hdint {
 				nvidia,tristate = <0>;
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index 7580578903cf..6d3a4cbc36cc 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -6,7 +6,7 @@
 	model = "Avionic Design Medcom-Wide board";
 	compatible = "ad,medcom-wide", "ad,tamonten", "nvidia,tegra20";
 
-	pwm {
+	pwm at 7000a000 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index e57fb3aefc2a..4b961b1b4252 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -268,7 +268,7 @@
 		clock-frequency = <100000>;
 	};
 
-	nvec {
+	nvec at 7000c500 {
 		compatible = "nvidia,nvec";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -417,7 +417,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
@@ -474,7 +474,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index d7a358a6a647..29051a2ae0ae 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -6,8 +6,8 @@
 	model = "Avionic Design Plutux board";
 	compatible = "ad,plutux", "ad,tamonten", "nvidia,tegra20";
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 315aae26c3cd..01442fc257de 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -516,7 +516,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
@@ -621,7 +621,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
@@ -649,7 +649,7 @@
 		};
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		status = "okay";
 		nvidia,debounce-delay-ms = <32>;
 		nvidia,repeat-delay-ms = <160>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 7726dab3d08d..02dbc6965fdc 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -8,8 +8,8 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			vdd-supply = <&hdmi_vdd_reg>;
 			pll-supply = <&hdmi_pll_reg>;
 
@@ -19,7 +19,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -457,7 +457,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
@@ -467,7 +467,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller {
+	pcie-controller at 80003000 {
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
 	};
@@ -492,7 +492,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 3ada3cb67f07..890562c667fb 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -6,8 +6,8 @@
 	model = "Avionic Design Tamonten Evaluation Carrier";
 	compatible = "ad,tec", "ad,tamonten", "nvidia,tegra20";
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 		};
 	};
@@ -32,7 +32,7 @@
 		};
 	};
 
-	pcie-controller {
+	pcie-controller at 80003000 {
 		status = "okay";
 
 		pci at 1,0 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 78deea5c0d21..eab7cd25dd55 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -301,7 +301,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
@@ -310,7 +310,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	pcie-controller {
+	pcie-controller at 80003000 {
 		status = "okay";
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
@@ -366,7 +366,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index aab872cd0530..bce764099853 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -492,7 +492,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
@@ -556,7 +556,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index d33a73cf167c..b047621b95d2 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -10,8 +10,8 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
@@ -23,7 +23,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -495,7 +495,7 @@
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
@@ -543,7 +543,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
@@ -551,7 +551,7 @@
 		};
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		status = "okay";
 		nvidia,debounce-delay-ms = <20>;
 		nvidia,repeat-delay-ms = <160>;
@@ -569,7 +569,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		usb0_vbus_reg: regulator {
+		usb0_vbus_reg: regulator at 0 {
 			compatible = "regulator-fixed";
 			reg = <0>;
 			regulator-name = "usb0_vbus";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index c90d0aac3afe..648c494e927f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -16,7 +16,7 @@
 		serial4 = &uarte;
 	};
 
-	host1x {
+	host1x at 50000000 {
 		compatible = "nvidia,tegra20-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
@@ -30,7 +30,7 @@
 
 		ranges = <0x54000000 0x54000000 0x04000000>;
 
-		mpe {
+		mpe at 54040000 {
 			compatible = "nvidia,tegra20-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
@@ -39,7 +39,7 @@
 			reset-names = "mpe";
 		};
 
-		vi {
+		vi at 54080000 {
 			compatible = "nvidia,tegra20-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
@@ -48,7 +48,7 @@
 			reset-names = "vi";
 		};
 
-		epp {
+		epp at 540c0000 {
 			compatible = "nvidia,tegra20-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
@@ -57,7 +57,7 @@
 			reset-names = "epp";
 		};
 
-		isp {
+		isp at 54100000 {
 			compatible = "nvidia,tegra20-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
@@ -66,7 +66,7 @@
 			reset-names = "isp";
 		};
 
-		gr2d {
+		gr2d at 54140000 {
 			compatible = "nvidia,tegra20-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -75,9 +75,9 @@
 			reset-names = "2d";
 		};
 
-		gr3d {
+		gr3d at 54140000 {
 			compatible = "nvidia,tegra20-gr3d";
-			reg = <0x54180000 0x00040000>;
+			reg = <0x54140000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
@@ -113,7 +113,7 @@
 			};
 		};
 
-		hdmi {
+		hdmi at 54280000 {
 			compatible = "nvidia,tegra20-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -125,7 +125,7 @@
 			status = "disabled";
 		};
 
-		tvo {
+		tvo at 542c0000 {
 			compatible = "nvidia,tegra20-tvo";
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -133,9 +133,9 @@
 			status = "disabled";
 		};
 
-		dsi {
+		dsi at 542c0000 {
 			compatible = "nvidia,tegra20-dsi";
-			reg = <0x54300000 0x00040000>;
+			reg = <0x542c0000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_DSI>;
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
@@ -151,7 +151,7 @@
 		clocks = <&tegra_car TEGRA20_CLK_TWD>;
 	};
 
-	intc: interrupt-controller {
+	intc: interrupt-controller at 50041000 {
 		compatible = "arm,cortex-a9-gic";
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
@@ -159,7 +159,7 @@
 		#interrupt-cells = <3>;
 	};
 
-	cache-controller {
+	cache-controller at 50043000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x50043000 0x1000>;
 		arm,data-latency = <5 5 2>;
@@ -178,14 +178,14 @@
 		clocks = <&tegra_car TEGRA20_CLK_TIMER>;
 	};
 
-	tegra_car: clock {
+	tegra_car: clock at 60006000 {
 		compatible = "nvidia,tegra20-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
 
-	apbdma: dma {
+	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -210,12 +210,12 @@
 		#dma-cells = <1>;
 	};
 
-	ahb {
+	ahb at 6000c004 {
 		compatible = "nvidia,tegra20-ahb";
 		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
 	};
 
-	gpio: gpio {
+	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra20-gpio";
 		reg = <0x6000d000 0x1000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
@@ -231,7 +231,7 @@
 		interrupt-controller;
 	};
 
-	pinmux: pinmux {
+	pinmux: pinmux at 70000014 {
 		compatible = "nvidia,tegra20-pinmux";
 		reg = <0x70000014 0x10   /* Tri-state registers */
 		       0x70000080 0x20   /* Mux registers */
@@ -239,12 +239,12 @@
 		       0x70000868 0xa8>; /* Pad control registers */
 	};
 
-	das {
+	das at 70000c00 {
 		compatible = "nvidia,tegra20-das";
 		reg = <0x70000c00 0x80>;
 	};
 
-	tegra_ac97: ac97 {
+	tegra_ac97: ac97 at 70002000 {
 		compatible = "nvidia,tegra20-ac97";
 		reg = <0x70002000 0x200>;
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
@@ -352,7 +352,7 @@
 		status = "disabled";
 	};
 
-	pwm: pwm {
+	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
@@ -362,7 +362,7 @@
 		status = "disabled";
 	};
 
-	rtc {
+	rtc at 7000e000 {
 		compatible = "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -503,7 +503,7 @@
 		status = "disabled";
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		compatible = "nvidia,tegra20-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -513,7 +513,7 @@
 		status = "disabled";
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA20_CLK_PCLK>, <&clk32k_in>;
@@ -527,7 +527,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
+	iommu at 7000f024 {
 		compatible = "nvidia,tegra20-gart";
 		reg = <0x7000f024 0x00000018	/* controller registers */
 		       0x58000000 0x02000000>;	/* GART aperture */
@@ -540,7 +540,7 @@
 		#size-cells = <0>;
 	};
 
-	pcie-controller {
+	pcie-controller at 80003000 {
 		compatible = "nvidia,tegra20-pcie";
 		device_type = "pci";
 		reg = <0x80003000 0x00000800   /* PADS registers */
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 08cad696e89f..bc28e27e4fe7 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -10,7 +10,7 @@
 		reg = <0x80000000 0x7ff00000>;
 	};
 
-	pcie-controller {
+	pcie-controller at 00003000 {
 		status = "okay";
 		pex-clk-supply = <&sys_3v3_pexs_reg>;
 		vdd-supply = <&ldo1_reg>;
@@ -31,8 +31,8 @@
 		};
 	};
 
-	host1x {
-		hdmi {
+	host1x at 50000000 {
+		hdmi at 54280000 {
 			status = "okay";
 
 			vdd-supply = <&sys_3v3_reg>;
@@ -44,7 +44,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -159,7 +159,7 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
-		rt5640: rt5640 {
+		rt5640: rt5640 at 1c {
 			compatible = "realtek,rt5640";
 			reg = <0x1c>;
 			interrupt-parent = <&gpio>;
@@ -168,7 +168,7 @@
 				<&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_HIGH>;
 		};
 
-		tps62361 {
+		tps62361 at 60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
@@ -296,13 +296,13 @@
 		};
 	};
 
-	ahub {
+	ahub at 70080000 {
 		i2s at 70080400 {
 			status = "okay";
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		status = "okay";
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
@@ -342,7 +342,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 5ea7dfa4d9fa..b159a41c7338 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -31,7 +31,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	pcie-controller {
+	pcie-controller at 00003000 {
 		status = "okay";
 		pex-clk-supply = <&pex_hvdd_3v3_reg>;
 		vdd-supply = <&ldo1_reg>;
@@ -51,7 +51,7 @@
 		};
 	};
 
-	pinmux {
+	pinmux at 70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
@@ -302,7 +302,7 @@
 			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_LEVEL_LOW>;
 		};
 
-		tps62361 {
+		tps62361 at 60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
@@ -326,13 +326,13 @@
 		};
 	};
 
-	ahub {
+	ahub at 70080000 {
 		i2s at 70080400 {
 			status = "okay";
 		};
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		status = "okay";
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
@@ -372,7 +372,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clock {
+		clk32k_in: clock at 0 {
 			compatible = "fixed-clock";
 			reg=<0>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 31259b09e7cc..829eb4b5091d 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -16,7 +16,7 @@
 		serial4 = &uarte;
 	};
 
-	pcie-controller {
+	pcie-controller at 00003000 {
 		compatible = "nvidia,tegra30-pcie";
 		device_type = "pci";
 		reg = <0x00003000 0x00000800   /* PADS registers */
@@ -89,7 +89,7 @@
 		};
 	};
 
-	host1x {
+	host1x@50000000 {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
@@ -103,7 +103,7 @@
 
 		ranges = <0x54000000 0x54000000 0x04000000>;
 
-		mpe {
+		mpe at 54040000 {
 			compatible = "nvidia,tegra30-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
@@ -112,7 +112,7 @@
 			reset-names = "mpe";
 		};
 
-		vi {
+		vi at 54080000 {
 			compatible = "nvidia,tegra30-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
@@ -121,7 +121,7 @@
 			reset-names = "vi";
 		};
 
-		epp {
+		epp at 540c0000 {
 			compatible = "nvidia,tegra30-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
@@ -130,7 +130,7 @@
 			reset-names = "epp";
 		};
 
-		isp {
+		isp at 54100000 {
 			compatible = "nvidia,tegra30-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
@@ -139,7 +139,7 @@
 			reset-names = "isp";
 		};
 
-		gr2d {
+		gr2d at 54140000 {
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -148,7 +148,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 		};
 
-		gr3d {
+		gr3d at 54180000 {
 			compatible = "nvidia,tegra30-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA30_CLK_GR3D
@@ -189,7 +189,7 @@
 			};
 		};
 
-		hdmi {
+		hdmi@54280000 {
 			compatible = "nvidia,tegra30-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -201,7 +201,7 @@
 			status = "disabled";
 		};
 
-		tvo {
+		tvo at 542c0000 {
 			compatible = "nvidia,tegra30-tvo";
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -209,7 +209,7 @@
 			status = "disabled";
 		};
 
-		dsi {
+		dsi at 54300000 {
 			compatible = "nvidia,tegra30-dsi";
 			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA30_CLK_DSIA>;
@@ -227,7 +227,7 @@
 		clocks = <&tegra_car TEGRA30_CLK_TWD>;
 	};
 
-	intc: interrupt-controller {
+	intc: interrupt-controller at 50041000 {
 		compatible = "arm,cortex-a9-gic";
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
@@ -235,7 +235,7 @@
 		#interrupt-cells = <3>;
 	};
 
-	cache-controller {
+	cache-controller at 50043000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x50043000 0x1000>;
 		arm,data-latency = <6 6 2>;
@@ -256,14 +256,14 @@
 		clocks = <&tegra_car TEGRA30_CLK_TIMER>;
 	};
 
-	tegra_car: clock {
+	tegra_car: clock at 60006000 {
 		compatible = "nvidia,tegra30-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
 
-	apbdma: dma {
+	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -304,12 +304,12 @@
 		#dma-cells = <1>;
 	};
 
-	ahb: ahb {
+	ahb: ahb at 6000c004 {
 		compatible = "nvidia,tegra30-ahb";
 		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
 	};
 
-	gpio: gpio {
+	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
@@ -326,7 +326,7 @@
 		interrupt-controller;
 	};
 
-	pinmux: pinmux {
+	pinmux: pinmux at 70000868 {
 		compatible = "nvidia,tegra30-pinmux";
 		reg = <0x70000868 0xd4    /* Pad control registers */
 		       0x70003000 0x3e4>; /* Mux registers */
@@ -405,7 +405,7 @@
 		status = "disabled";
 	};
 
-	pwm: pwm {
+	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
@@ -415,7 +415,7 @@
 		status = "disabled";
 	};
 
-	rtc {
+	rtc at 7000e000 {
 		compatible = "nvidia,tegra30-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -586,7 +586,7 @@
 		status = "disabled";
 	};
 
-	kbc {
+	kbc at 7000e200 {
 		compatible = "nvidia,tegra30-kbc", "nvidia,tegra20-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -596,14 +596,14 @@
 		status = "disabled";
 	};
 
-	pmc {
+	pmc at 7000e400 {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	memory-controller {
+	memory-controller at 7000f000 {
 		compatible = "nvidia,tegra30-mc";
 		reg = <0x7000f000 0x010
 		       0x7000f03c 0x1b4
@@ -612,7 +612,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
+	iommu at 7000f010 {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
@@ -622,7 +622,7 @@
 		nvidia,ahb = <&ahb>;
 	};
 
-	ahub {
+	ahub at 70080000 {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200
 		       0x70080200 0x100>;
-- 
1.8.1.5
