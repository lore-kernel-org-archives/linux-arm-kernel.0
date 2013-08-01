From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  1 Aug 2013 12:28:43 -0600
Subject: [PATCH] ARM: tegra: use TEGRA_GPIO() in a couple more places
Message-ID: <1375381723-11214-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A couple of references to Tegra GPIO numbers were missed when cleaning
up the Tegra DT files. Convert them now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I intend to apply this immediately since it's so trivial.

 arch/arm/boot/dts/tegra20-seaboard.dts  | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 365760b..85116de 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -829,7 +829,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 24 0>; /* PD0 */
+			gpio = <&gpio TEGRA_GPIO(D, 0) 0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index ed4b901..7412b14 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -411,7 +411,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 170 0>; /* PV2 */
+			gpio = <&gpio TEGRA_GPIO(V, 2) 0>;
 		};
 	};
 
-- 
1.8.1.5
