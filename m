From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 19 Oct 2011 10:53:57 -0600
Subject: [PATCH] arm/dt: Fix ventana SDHCI power-gpios
Message-ID: <1319043237-1474-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ventana uses the same SDHCI GPIOs as Seaboard; PI6 (70) is the power GPIO
for the SD port, and there is no power GPIO for the MMC chip.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Note: This bug doesn't actually prevent anything from working; since the
GPIO for sdhci at c8000400 was specified for sdhci at c8000600, it ended up
getting enabled anyway, and hence a card in sdhci at c8000400 would work fine.
Enabling GPIO 155/PT3 doesn't cause any harm on Ventana; it's not connected
to anything.

 arch/arm/boot/dts/tegra-ventana.dts |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 9b29a62..3f9abd6 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -22,11 +22,10 @@
 	sdhci at c8000400 {
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-		power-gpios = <&gpio 155 0>; /* gpio PT3 */
+		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
 
 	sdhci at c8000600 {
-		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		support-8bit;
 	};
 };
-- 
1.7.0.4
