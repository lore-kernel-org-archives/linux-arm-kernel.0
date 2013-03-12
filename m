From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:53 +0100
Subject: [PATCH v2 10/13] ARM: spear: rename duplicate pl080_plat_data
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both spear3xx and spear6xx have a global symbol named
pl080_plat_data. Eventually, both should be removed, but
for now, we can rename one to pl080_plat_data and declare
it static, since that one does not actually need to be
visible outside of spear6xx.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/spear6xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 9b5ea25..ec8eefb 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -322,7 +322,7 @@ static struct pl08x_channel_data spear600_dma_info[] = {
 	},
 };
 
-struct pl08x_platform_data pl080_plat_data = {
+static struct pl08x_platform_data spear6xx_pl080_plat_data = {
 	.memcpy_channel = {
 		.bus_id = "memcpy",
 		.cctl_memcpy =
@@ -406,7 +406,7 @@ void __init spear6xx_timer_init(void)
 /* Add auxdata to pass platform data */
 struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl080", SPEAR_ICM3_DMA_BASE, NULL,
-			&pl080_plat_data),
+			&spear6xx_pl080_plat_data),
 	{}
 };
 
-- 
1.8.1.2
