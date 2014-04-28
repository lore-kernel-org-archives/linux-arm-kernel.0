From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 11:07:26 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Jetson TK1 DT
Message-ID: <1398704846-18262-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Jetson TK1 can detect write-protect on the SD card. Add the required
DT entries to allow this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index fbc34933cf69..e31fb61a81d3 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1624,6 +1624,7 @@
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
-- 
1.8.1.5
