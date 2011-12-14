From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:13 +0200
Subject: [PATCH v7 01/14] arm/tegra: initial device tree for tegra30
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1323875032-18221-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the initial device tree for tegra30

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 Documentation/devicetree/bindings/arm/tegra.txt |   14 +++
 arch/arm/boot/dts/tegra30.dtsi                  |  127 +++++++++++++++++++++++
 2 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 arch/arm/boot/dts/tegra30.dtsi

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
new file mode 100644
index 0000000..6e69d2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -0,0 +1,14 @@
+NVIDIA Tegra device tree bindings
+-------------------------------------------
+
+Boards with the tegra20 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "nvidia,tegra20";
+
+Boards with the tegra30 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "nvidia,tegra30";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
new file mode 100644
index 0000000..ee7db98
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -0,0 +1,127 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "nvidia,tegra30";
+	interrupt-parent = <&intc>;
+
+	intc: interrupt-controller at 50041000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = < 0x50041000 0x1000 >,
+		      < 0x50040100 0x0100 >;
+	};
+
+	i2c at 7000c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C000 0x100>;
+		interrupts = < 0 38 0x04 >;
+	};
+
+	i2c at 7000c400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C400 0x100>;
+		interrupts = < 0 84 0x04 >;
+	};
+
+	i2c at 7000c500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000C500 0x100>;
+		interrupts = < 0 92 0x04 >;
+	};
+
+	i2c at 7000c700 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000c700 0x100>;
+		interrupts = < 0 120 0x04 >;
+	};
+
+	i2c at 7000d000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		reg = <0x7000D000 0x100>;
+		interrupts = < 0 53 0x04 >;
+	};
+
+	gpio: gpio at 6000d000 {
+		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
+		reg = < 0x6000d000 0x1000 >;
+		interrupts = < 0 32 0x04 0 33 0x04 0 34 0x04 0 35 0x04 0 55 0x04 0 87 0x04 0 89 0x04 >;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	serial at 70006000 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006000 0x40>;
+		reg-shift = <2>;
+		interrupts = < 0 36 0x04 >;
+	};
+
+	serial at 70006040 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006040 0x40>;
+		reg-shift = <2>;
+		interrupts = < 0 37 0x04 >;
+	};
+
+	serial at 70006200 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006200 0x100>;
+		reg-shift = <2>;
+		interrupts = < 0 46 0x04 >;
+	};
+
+	serial at 70006300 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006300 0x100>;
+		reg-shift = <2>;
+		interrupts = < 0 90 0x04 >;
+	};
+
+	serial at 70006400 {
+		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
+		reg = <0x70006400 0x100>;
+		reg-shift = <2>;
+		interrupts = < 0 91 0x04 >;
+	};
+
+	sdhci at 78000000 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000000 0x200>;
+		interrupts = < 0 14 0x04 >;
+	};
+
+	sdhci at 78000200 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000200 0x200>;
+		interrupts = < 0 15 0x04 >;
+	};
+
+	sdhci at 78000400 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000400 0x200>;
+		interrupts = < 0 19 0x04 >;
+	};
+
+	sdhci at 78000600 {
+		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
+		reg = <0x78000600 0x200>;
+		interrupts = < 0 31 0x04 >;
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
