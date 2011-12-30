From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Dec 2011 02:28:16 +0000
Subject: [PATCH 2/2] ARM: S3C64XX: Enable power management for WiFi on
 Cragganmore
In-Reply-To: <1325212096-13420-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325212096-13420-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1325212096-13420-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the SDHCI stack to runtime power manage the WiFi card on Cragganmore
for better power optimisation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 139d16e..30730fb 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -693,6 +693,7 @@ static void __init crag6410_map_io(void)
 static struct s3c_sdhci_platdata crag6410_hsmmc2_pdata = {
 	.max_width		= 4,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
+	.host_caps		= MMC_CAP_POWER_OFF_CARD,
 };
 
 static void crag6410_cfg_sdhci0(struct platform_device *dev, int width)
-- 
1.7.7.3
