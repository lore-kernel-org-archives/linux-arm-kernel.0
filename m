From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 08:14:08 -0000
Subject: [v3 6/9] ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358237598-32413-7-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial support for Tegra 114 SoC. This is expected to be included in
the board DTS files, Tegra 114 SoC based evaluation board family.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |  116 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra114.dtsi

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
new file mode 100644
index 0000000..175cbc3
--- /dev/null
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -0,0 +1,116 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "nvidia,tegra114";
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x50041000 0x1000>,
+		      <0x50042000 0x1000>,
+		      <0x50044000 0x2000>,
+		      <0x50046000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+
+	timer at 60005000 {
+		compatible = "nvidia,tegra114-timer", "nvidia,tegra20-timer";
+		reg = <0x60005000 0x400>;
+		interrupts = <0 0 0x04
+			      0 1 0x04
+			      0 41 0x04
+			      0 42 0x04
+			      0 121 0x04
+			      0 122 0x04>;
+	};
+
+	serial at 70006000 {
+		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
+		reg = <0x70006000 0x40>;
+		reg-shift = <2>;
+		interrupts = <0 36 0x04>;
+		status = "disabled";
+	};
+
+	serial at 70006040 {
+		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
+		reg = <0x70006040 0x40>;
+		reg-shift = <2>;
+		interrupts = <0 37 0x04>;
+		status = "disabled";
+	};
+
+	serial at 70006200 {
+		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
+		reg = <0x70006200 0x100>;
+		reg-shift = <2>;
+		interrupts = <0 46 0x04>;
+		status = "disabled";
+	};
+
+	serial at 70006300 {
+		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
+		reg = <0x70006300 0x100>;
+		reg-shift = <2>;
+		interrupts = <0 90 0x04>;
+		status = "disabled";
+	};
+
+	serial at 70006400 {
+		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
+		reg = <0x70006400 0x100>;
+		reg-shift = <2>;
+		interrupts = <0 91 0x04>;
+		status = "disabled";
+	};
+
+	rtc {
+		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
+		reg = <0x7000e000 0x100>;
+		interrupts = <0 2 0x04>;
+	};
+
+	pmc {
+		compatible = "nvidia,tegra114-pmc", "nvidia,tegra20-pmc";
+		reg = <0x7000e400 0x400>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+	};
+};
-- 
1.7.9.5
