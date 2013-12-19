From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 17:06:14 +0100
Subject: [PATCH 02/10] ARM: tegra: Hook up SDMMC3 power-supply on Venice2
In-Reply-To: <1387469182-14398-1-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
Message-ID: <1387469182-14398-3-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDMMC3 interface is supplied with 1.8V by the PMICs LDO6.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 5dc0c64b7682..7a4d5e23ddf4 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -531,7 +531,7 @@
 					regulator-max-microvolt = <1200000>;
 				};
 
-				ldo6 {
+				vddio_sdmmc3: ldo6 {
 					regulator-name = "vddio_sdmmc";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -580,6 +580,7 @@
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
 		status = "okay";
 		bus-width = <4>;
+		vmmc-supply = <&vddio_sdmmc3>;
 	};
 
 	sdhci at 700b0600 {
-- 
1.8.4.2
