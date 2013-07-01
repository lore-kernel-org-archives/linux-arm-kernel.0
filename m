From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  1 Jul 2013 15:07:05 -0600
Subject: [PATCH] ARM: tegra: fix VBUS regulator GPIO polarity in DT
Message-ID: <1372712825-13757-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 4c94c8b "ARM: tegra: update device trees for USB binding rework"
added regulator definitions for GPIO-controlled USB VBUS. However, none
of these contained the essential DT property enable-active-high. Add
this so that the regulator definitions are correct.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I'm sending this to arm-soc to be taken into v3.11-rc1. However, if it
won't get in until -rc2, let me know; I'd be tempted not to fix it in
3.11 in that case, so I don't have to wait until v3.11-rc2 before
applying patches that use these new regulators, since they rely on this
fix going in first.

 arch/arm/boot/dts/tegra20-seaboard.dts  | 1 +
 arch/arm/boot/dts/tegra20-trimslice.dts | 1 +
 arch/arm/boot/dts/tegra20-whistler.dts  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 9c5cb54..7f460bb 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -814,6 +814,7 @@
 			regulator-name = "vdd_vbus_wup1";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
+			enable-active-high;
 			gpio = <&gpio 24 0>; /* PD0 */
 		};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index a997eaf..77efb09 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -417,6 +417,7 @@
 			regulator-name = "usb1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
+			enable-active-high;
 			gpio = <&gpio 170 0>; /* PV2 */
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index e07f210..a6b1b5b 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -584,6 +584,7 @@
 			regulator-name = "vbus1";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
+			enable-active-high;
 			gpio = <&tca6416 0 0>; /* GPIO_PMU0 */
 		};
 
@@ -593,6 +594,7 @@
 			regulator-name = "vbus3";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
+			enable-active-high;
 			gpio = <&tca6416 1 0>; /* GPIO_PMU1 */
 		};
 	};
-- 
1.8.1.5
