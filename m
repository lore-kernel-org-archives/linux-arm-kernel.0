From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 13 Nov 2014 13:59:03 +0900
Subject: [PATCH 2/2] ARM: tegra: roth: Fix SD card VDD_IO regulator
In-Reply-To: <1415854743-11670-1-git-send-email-acourbot@nvidia.com>
References: <1415854743-11670-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1415854743-11670-2-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vddio_sdmmc3 is a vdd_io, and thus should be under the vqmmc-supply
property, not vmmc-supply.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra114-roth.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 1f6eaba92f67..10f42553831f 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -916,8 +916,6 @@
 						regulator-name = "vddio-sdmmc3";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					ldousb {
@@ -962,7 +960,7 @@
 	sdhci at 78000400 {
 		status = "okay";
 		bus-width = <4>;
-		vmmc-supply = <&vddio_sdmmc3>;
+		vqmmc-supply = <&vddio_sdmmc3>;
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
 	};
-- 
2.1.3
