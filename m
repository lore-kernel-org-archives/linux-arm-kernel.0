From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 13 Aug 2010 21:17:54 +0200
Subject: [PATCH 2/5] ARM: S3C64XX: Set wifi and iNAND as permanently connected
	SD devices on SmartQ boards
Message-ID: <4c659a64.097b0e0a.5759.ffffcf48@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the platform data definitions of the wifi and iNAND chip on
the SmartQ 5 and 7 to indicate that they don't have a CD line available and are
thus hard-wired to the SDHCI data lines.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 54309da..20ddce6 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -167,7 +167,7 @@ static struct s3c2410_ts_mach_info smartq_touchscreen_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smartq_internal_hsmmc_pdata = {
 	.max_width		= 4,
-	/*.broken_card_detection	= true,*/
+	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
 static struct s3c_hwmon_pdata smartq_hwmon_pdata __initdata = {
-- 
1.7.0.4
