From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  1 Mar 2013 11:32:24 -0700
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
Message-ID: <1362162745-21392-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prashant Gaikwad <pgaikwad@nvidia.com>

As DT support for clocks and smp_twd is enabled, add clock entry
for smp_twd clock to DT.

This fixes the following error while booting the kernel:
smp_twd: clock not found -2

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
[swarren: include kernel log spew that this fixes]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, these are fixes intended for 3.9.

 arch/arm/boot/dts/tegra20.dtsi |    1 +
 arch/arm/boot/dts/tegra30.dtsi |    1 +
 2 files changed, 2 insertions(+)

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
1.7.10.4
