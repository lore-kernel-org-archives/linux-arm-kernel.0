From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 24 Dec 2013 15:32:08 +0200
Subject: [PATCH v2 3/6] ARM: tegra: Add efuse bindings
In-Reply-To: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1387891931-9854-4-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add efuse bindings for Tegra20, Tegra30, Tegra114 and Tegra124.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    6 ++++++
 arch/arm/boot/dts/tegra124.dtsi |    6 ++++++
 arch/arm/boot/dts/tegra20.dtsi  |    6 ++++++
 arch/arm/boot/dts/tegra30.dtsi  |    6 ++++++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 389e987..68c616e 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -481,6 +481,12 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	efuse at 7000f800 {
+		compatible = "nvidia,tegra114-efuse";
+		reg = <0x7000f800 0x400>;
+		clocks = <&tegra_car TEGRA114_CLK_FUSE>;
+	};
+
 	iommu at 70019010 {
 		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
 		reg = <0x70019010 0x02c
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index ec0698a..97bd8e0 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -524,6 +524,12 @@
 		};
 	};
 
+	efuse@7000f800 {
+		compatible = "nvidia,tegra124-efuse";
+		reg = <0x7000f800 0x400>;
+		clocks = <&tegra_car TEGRA124_CLK_FUSE>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 480ecda..f647aaa 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -541,6 +541,12 @@
 		#size-cells = <0>;
 	};
 
+	efuse at 7000F800 {
+		compatible = "nvidia,tegra20-efuse";
+		reg = <0x7000F800 0x400>;
+		clocks = <&tegra_car TEGRA20_CLK_FUSE>;
+	};
+
 	pcie-controller at 80003000 {
 		compatible = "nvidia,tegra20-pcie";
 		device_type = "pci";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ed8e770..828465e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -623,6 +623,12 @@
 		nvidia,ahb = <&ahb>;
 	};
 
+	efuse at 7000f800 {
+		compatible = "nvidia,tegra30-efuse";
+		reg = <0x7000f800 0x400>;
+		clocks = <&tegra_car TEGRA30_CLK_FUSE>;
+	};
+
 	ahub at 70080000 {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200
-- 
1.7.7.rc0.72.g4b5ea.dirty
