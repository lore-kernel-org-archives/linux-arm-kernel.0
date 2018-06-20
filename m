From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:54:05 +0300
Subject: [PATCH 4/5] arm64: tegra: Enable card detect for SD card on P2888
In-Reply-To: <20180620125406.11906-1-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
Message-ID: <20180620125406.11906-4-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a GPIO controller, enable the card detect GPIO for
the SD card slot.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 95e2433984f7..40d688f7de1c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -33,9 +33,7 @@
 
 		/* SDMMC1 (SD/MMC) */
 		sdhci at 3400000 {
-/*
 			cd-gpios = <&gpio TEGRA194_MAIN_GPIO(A, 0) GPIO_ACTIVE_LOW>;
-*/
 		};
 
 		/* SDMMC4 (eMMC) */
-- 
2.16.1
