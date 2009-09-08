From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 15:47:38 +0900
Subject: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci platform
	data structure.
Message-ID: <1252392458-23921-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds additional information about the parent clock
name, sdhci clock name and desired sdhci operating frequency
in the sdhci platform data structure.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/dev-hsmmc.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
index 4c05b39..357ec60 100644
--- a/arch/arm/plat-s3c/dev-hsmmc.c
+++ b/arch/arm/plat-s3c/dev-hsmmc.c
@@ -38,9 +38,12 @@ static struct resource s3c_hsmmc_resource[] = {
 static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
 
 struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.max_width		= 4,
+	.host_caps		= (MMC_CAP_4_BIT_DATA |
+				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_parent_name	= "dout_mpll",
+	.clk_source_name 	= "mmc_bus",
+	.clk_speed		= 50*MHZ,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
-- 
1.5.3.4
