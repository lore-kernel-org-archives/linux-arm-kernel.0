From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 11:39:39 +0200
Subject: [PATCH 1/5] sdhci-s3c: depend on plat-samsung
In-Reply-To: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1276076383-24825-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most Samsung SoC have support for SDHCI block, so make the driver
dependent on the Samsung platform instead on listing all SoCs in the
Kconfig (and updating it again when support for the new SoC variant is
added).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e171e77..acf5bf6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
+	depends on MMC_SDHCI && PLAT_SAMSUNG
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-- 
1.7.1.240.g225c
