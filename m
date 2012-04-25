From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:30 +0530
Subject: [PATCH 20/33] ARM: S3C24XX: mach-tct_hammer: Use common macro to
 define resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-21-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-tct_hammer.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 1114666..fe99028 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -56,11 +56,8 @@
 
 #include "common.h"
 
-static struct resource tct_hammer_nor_resource = {
-		.start = 0x00000000,
-		.end   = 0x01000000 - 1,
-		.flags = IORESOURCE_MEM,
-};
+static struct resource tct_hammer_nor_resource =
+			DEFINE_RES_MEM(0x00000000, SZ_16M);
 
 static struct mtd_partition tct_hammer_mtd_partitions[] = {
 	{
-- 
1.7.4.1
