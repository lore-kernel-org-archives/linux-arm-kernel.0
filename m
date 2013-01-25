From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:53 +0000
Subject: [PATCH 10/13] ARM: spear: rename duplicate pl080_plat_data
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both spear3xx and spear6xx have a global symbol named
pl080_plat_data. Eventually, both should be removed, but
for now, we can rename one to pl080_plat_data and declare
it static, since that one does not actually need to be
visible outside of spear6xx.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/spear6xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 79cbda0..f6d4473 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -323,7 +323,7 @@ static struct pl08x_channel_data spear600_dma_info[] = {
 	},
 };
 
-struct pl08x_platform_data pl080_plat_data = {
+static struct pl08x_platform_data spear6xx_pl080_plat_data = {
 	.memcpy_channel = {
 		.bus_id = "memcpy",
 		.cctl_memcpy =
@@ -411,7 +411,7 @@ struct sys_timer spear6xx_timer = {
 /* Add auxdata to pass platform data */
 struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
-			&pl080_plat_data),
+			&spear6xx_pl080_plat_data),
 	{}
 };
 
-- 
1.8.0
