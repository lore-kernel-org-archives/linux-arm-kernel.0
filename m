From: pdeschrijver@nvidia.com (pdeschrijver at nvidia.com)
Date: Tue, 25 Oct 2011 19:53:55 +0300
Subject: [PATCH 1/6] arm/tegra: initial device tree for tegra30
In-Reply-To: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1319561644-6160-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

This patch adds the initial device tree for tegra30

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |  128 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra30.dtsi

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
new file mode 100644
index 0000000..3550b9a
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -0,0 +1,128 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "NVIDIA Tegra 30";
+	compatible = "nvidia,tegra30";
+	interrupt-parent = <&intc>;
+
+	intc: interrupt-controller at 50041000 {
+		compatible = "nvidia,tegra30-gic", "nvidia,tegra20-gic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = < 0x50041000 0x1000 >,
+		< 0x50040100 0x0100 >;
+	};
+
+	i2c at 7000c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C000 0x100>;
+		interrupts = < 70 >;
+	};
+
+	i2c at 7000c400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C400 0x100>;
+		interrupts = < 116 >;
+	};
+
+	i2c at 7000c500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C500 0x100>;
+		interrupts = < 124 >;
+	};
+
+	i2c at 7000c700 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c700 0x100>;
+		interrupts = < 152 >;
+	};
+
+	i2c at 7000d000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000D000 0x100>;
+		interrupts = < 85 >;
+	};
+
+	gpio: gpio at 6000d000 {
+		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
+		reg = < 0x6000d000 0x1000 >;
+		interrupts = < 64 65 66 67 87 119 121 >;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	serial at 70006000 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006000 0x40>;
+		reg-shift = <2>;
+		interrupts = < 68 >;
+	};
+
+	serial at 70006040 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006040 0x40>;
+		reg-shift = <2>;
+		interrupts = < 69 >;
+	};
+
+	serial at 70006200 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006200 0x100>;
+		reg-shift = <2>;
+		interrupts = < 78 >;
+	};
+
+	serial at 70006300 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006300 0x100>;
+		reg-shift = <2>;
+		interrupts = < 122 >;
+	};
+
+	serial at 70006400 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006400 0x100>;
+		reg-shift = <2>;
+		interrupts = < 123 >;
+	};
+
+	sdhci at 78000000 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000000 0x200>;
+		interrupts = < 46 >;
+	};
+
+	sdhci at 78000200 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000200 0x200>;
+		interrupts = < 47 >;
+	};
+
+	sdhci at 78000400 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000400 0x200>;
+		interrupts = < 51 >;
+	};
+
+	sdhci at 78000600 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000600 0x200>;
+		interrupts = < 63 >;
+	};
+
+	pinmux: pinmux at 70000000 {
+		compatible = "nvidia,tegra30-pinmux";
+		reg = < 0x70000868 0xd0     /* Pad control registers */
+			0x70003000 0x3e0 >; /* Mux registers */
+	};
+};
-- 
1.7.7.rc0.72.g4b5ea.dirty
