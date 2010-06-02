From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  2 Jun 2010 16:05:37 +0900
Subject: [PATCH] ARM: SAMSUNG: Reduce virtual memory size for WDT device
Message-ID: <1275462337-21587-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch reduces the virtual memory allocated for WDT device from 1M
to 1K.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/dev-wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
index 5efca87..019b5b8 100644
--- a/arch/arm/plat-samsung/dev-wdt.c
+++ b/arch/arm/plat-samsung/dev-wdt.c
@@ -21,7 +21,7 @@
 static struct resource s3c_wdt_resource[] = {
 	[0] = {
 		.start	= S3C_PA_WDT,
-		.end	= S3C_PA_WDT + SZ_1M - 1,
+		.end	= S3C_PA_WDT + SZ_1K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.6.2.5
