From: marcel@ziswiler.com (marcel at ziswiler.com)
Date: Thu, 24 Nov 2016 02:04:55 +0100
Subject: [RESEND PATCH 5/6] apalis-tk1: working sd card detect on v1.1 hw
In-Reply-To: <20161124010456.24604-1-marcel@ziswiler.com>
References: <20161124010456.24604-1-marcel@ziswiler.com>
Message-ID: <20161124010456.24604-6-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add sd card detect SD1_CD# applicable for V1.1 modules using GPIO_PV2.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 2b5a0f3..2715692 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -187,14 +187,8 @@
 	/* Apalis SD1 */
 	sdhci at 700b0400 {
 		status = "okay";
-		/*
-		 * Don't use SD1_CD# aka SDMMC3_CLK_LB_OUT for now as it
-		 * features some magic properties even though the external
-		 * loopback is disabled and the internal loopback used as per
-		 * SDMMC_VENDOR_MISC_CNTRL_0 register's SDMMC_SPARE1 bits being
-		 * set to 0xfffd according to the TRM!
-		 * cd-gpios = <&gpio TEGRA_GPIO(EE, 4) GPIO_ACTIVE_LOW>;
-		 */
+		/* SD1_CD# */
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
-- 
2.9.3
