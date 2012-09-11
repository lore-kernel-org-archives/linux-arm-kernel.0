From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 11:43:47 -0600
Subject: [PATCH 2/2] ARM: dt: tegra: configure power off for some boards
In-Reply-To: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
References: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347385427-9676-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

For Seaboard, Ventana, and Cardhu, add DT property to tell the regulator
that it should provide the pm_power_off() implementation. This allows
"shutdown" to work.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |    2 ++
 arch/arm/boot/dts/tegra20-ventana.dts  |    2 ++
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 92deb36..e60dc71 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -379,6 +379,8 @@
 			reg = <0x34>;
 			interrupts = <0 86 0x4>;
 
+			ti,system-power-controller;
+
 			#gpio-cells = <2>;
 			gpio-controller;
 
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 4ec6b4c..3e5952f 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -295,6 +295,8 @@
 			reg = <0x34>;
 			interrupts = <0 86 0x4>;
 
+			ti,system-power-controller;
+
 			#gpio-cells = <2>;
 			gpio-controller;
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 4794693..d10c9c5 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -156,6 +156,8 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
+			ti,system-power-controller;
+
 			#gpio-cells = <2>;
 			gpio-controller;
 
-- 
1.7.0.4
