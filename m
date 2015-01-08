From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  8 Jan 2015 13:24:33 +0100
Subject: [PATCH] ARM: tegra: Fix unit address for Cortex-A9 TWD timer
Message-ID: <1420719873-9820-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The Cortex-A9 TWD timer has registers at address 0x50040600, but the
unit address was 50004600, most likely a typo.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 arch/arm/boot/dts/tegra30.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 06e0576df697..943c80a3ec32 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -149,7 +149,7 @@
 		};
 	};
 
-	timer at 50004600 {
+	timer at 50040600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c43f59262a7c..92ec0ba59e92 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -233,7 +233,7 @@
 		};
 	};
 
-	timer at 50004600 {
+	timer@50040600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
-- 
2.1.3
