From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 28 Feb 2013 13:13:00 +0530
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
Message-ID: <1362037381-4730-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As DT support for clocks and smp_twd is enabled, add clock entry
for smp_twd clock to DT.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    1 +
 arch/arm/boot/dts/tegra30.dtsi |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9a42893..48d00a0 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -118,6 +118,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
 		interrupts = <1 13 0x304>;
+		clocks = <&tegra_car 132>;
 	};
 
 	intc: interrupt-controller {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 767803e..9d87a3f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -119,6 +119,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
 		interrupts = <1 13 0xf04>;
+		clocks = <&tegra_car 214>;
 	};
 
 	intc: interrupt-controller {
-- 
1.7.4.1
