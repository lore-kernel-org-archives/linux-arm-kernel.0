From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Fri, 2 Nov 2012 18:02:39 +0530
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space for
 CPGMAC0
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
instead of ADDR_TYPE_RT to ensure the omap hwmod code
maps the memory space at init and writes to the SYSCONFIG
registers.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 7772c29..881b570 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2500,7 +2500,7 @@ static struct omap_hwmod_addr_space am33xx_cpgmac0_addr_space[] = {
 	{
 		.pa_start	= 0x4a100000,
 		.pa_end		= 0x4a100000 + SZ_2K - 1,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_MAP_ON_INIT,
 	},
 	/* cpsw wr */
 	{
-- 
1.7.0.4
