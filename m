From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 19 Jul 2010 08:25:15 +0900
Subject: [PATCH] ARM: S3C24XX: Fix nand partition table for s3c24XX
Message-ID: <1279495515-17265-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch fixes the partition table as existing partition table have last
partition size fixed and can't utilize available memory proprly if size is
more than 64M.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/plat-s3c24xx/common-smdk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/common-smdk.c b/arch/arm/plat-s3c24xx/common-smdk.c
index 7b44d0c..bcc43f3 100644
--- a/arch/arm/plat-s3c24xx/common-smdk.c
+++ b/arch/arm/plat-s3c24xx/common-smdk.c
@@ -147,7 +147,7 @@ static struct mtd_partition smdk_default_nand_part[] = {
 	[7] = {
 		.name	= "S3C2410 flash partition 7",
 		.offset = SZ_1M * 48,
-		.size	= SZ_16M,
+		.size	= MTDPART_SIZ_FULL,
 	}
 };
 
-- 
1.6.2.5
