From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 9 Mar 2013 23:41:15 +0530
Subject: [PATCH V2 2/5] ARM: DT: tegra114: Add i2c controller DT entry
In-Reply-To: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1362852678-13421-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 has 5 i2c controllers. These controllers have
additional feature/configurations to make it functional over
Tegra30's i2c controller driver.

Add DT entry for i2c controllers and make it compatible with
"nvidia,tegra114-i2c".

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- None

 arch/arm/boot/dts/tegra114.dtsi |   55 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index b73b8a6..14afbc8 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -135,6 +135,61 @@
 		clocks = <&tegra_car 65>;
 	};
 
+	i2c at 7000c000 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c000 0x100>;
+		interrupts = <0 38 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+		clocks = <&tegra_car 12>;
+		clock-names = "div-clk";
+	};
+
+	i2c at 7000c400 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c400 0x100>;
+		interrupts = <0 84 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+		clocks = <&tegra_car 54>;
+		clock-names = "div-clk";
+	};
+
+	i2c at 7000c500 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c500 0x100>;
+		interrupts = <0 92 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+		clocks = <&tegra_car 67>;
+		clock-names = "div-clk";
+	};
+
+	i2c at 7000c700 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c700 0x100>;
+		interrupts = <0 120 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+		clocks = <&tegra_car 103>;
+		clock-names = "div-clk";
+	};
+
+	i2c at 7000d000 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000d000 0x100>;
+		interrupts = <0 53 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+		clocks = <&tegra_car 47>;
+		clock-names = "div-clk";
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
-- 
1.7.1.1
