From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 14 Mar 2013 01:19:51 +0530
Subject: [PATCH V3 2/5] ARM: tegra: add i2c nodes to Tegra114 DT
In-Reply-To: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363204194-19487-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 has 5 i2c controllers. These controllers have
following changes which makes incompatible with previous hardware:
- Single clock source to i2c controller.
- Interrupt support for per packet transfer.

Add DT entry for i2c controllers and make it compatible with
"nvidia,tegra114-i2c".

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- None

Changes from V2:
- Rebase to for-3.10/dt of Stephen's tegra tree.
- Better describe why Tegra114 is not compatible with previous hardware.

 arch/arm/boot/dts/tegra114.dtsi |   55 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 634d70c..ce44938 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -138,6 +138,61 @@
 		status = "disabled";
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
 	rtc {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
-- 
1.7.1.1
