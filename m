From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Mar 2013 16:09:57 +0800
Subject: [PATCH V2 1/3] ARM: dts: tegra: add clock source for PMC
In-Reply-To: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
References: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363594199-10974-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock source of PMC is PCLK. Adding it into DTS for Tegra20 and Tegra30.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* new in this change
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 arch/arm/boot/dts/tegra30.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 3183581..4ba9c7b 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,6 +419,7 @@
 	pmc {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 110>;
 	};
 
 	memory-controller at 7000f000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 11d04fe..7299014 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -428,6 +428,7 @@
 	pmc {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 218>;
 	};
 
 	memory-controller {
-- 
1.8.1.5
