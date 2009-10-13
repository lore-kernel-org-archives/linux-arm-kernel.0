From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:22 +0200
Subject: [PATCH 17/17] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform
In-Reply-To: <1255421482-26455-17-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-9-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-11-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-12-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-13-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-14-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-15-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-16-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-17-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1255421482-26455-18-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung S5PC100 SoC has SDHCI controller compatible to the one known from
S3C64xx SoCs. Enable support for sdhci-s3c driver also on S5PC1xx platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 432ae83..faddf82 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -96,7 +96,7 @@ config MMC_SDHCI_PLTFM
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
+	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX || PLAT_S5PC1XX)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-- 
1.6.4
