From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:19:42 +0800
Subject: [PATCH V3 2/3] ARM: dts: tegra: add clock source for PMC
In-Reply-To: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
References: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901583-24867-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the clock sources of PMC into DTS for Tegra20 and Tegra30.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* add clk32k_in as one of the PMC clock source.
* add a fixed clock of clk32k_in for Tegra20 & Tegra30
V2:
* new in this change
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts      | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-paz00.dts        | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-seaboard.dts     | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-tamonten.dtsi    | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-trimslice.dts    | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts      | 13 +++++++++++++
 arch/arm/boot/dts/tegra20-whistler.dts     | 13 +++++++++++++
 arch/arm/boot/dts/tegra20.dtsi             |  2 ++
 arch/arm/boot/dts/tegra30-beaver.dts       | 13 +++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi      | 13 +++++++++++++
 arch/arm/boot/dts/tegra30.dtsi             |  2 ++
 12 files changed, 134 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index cb73e62..4c107e6 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -8,6 +8,19 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			vdd-supply = <&hdmi_vdd_reg>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 5fb0888..6e6899a 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 43fd28b..54b05b2 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 4f810a5..3b347b8 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 6e9d91f..0c7bc18 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -8,6 +8,19 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			vdd-supply = <&hdmi_vdd_reg>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 955bf49..b265ebd 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 3f8ae10..157a2cd 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 87e2d85..87632df 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -10,6 +10,19 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	host1x {
 		hdmi {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 26c1134..5fc661d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,6 +419,8 @@
 	pmc {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 110>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	memory-controller at 7000f000 {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 0a2cd24..c3e0f25 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -10,6 +10,19 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 11204e1..eeea511 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -31,6 +31,19 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 6042cc1..15ded60 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -428,6 +428,8 @@
 	pmc {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 218>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	memory-controller {
-- 
1.8.2
