From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Sep 2012 16:38:00 +0300
Subject: [PATCH v2 10/15] ARM: OMAP4: hwmod_data: Add resource names to McPDM
 memory ranges
In-Reply-To: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347543485-339-11-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To help the driver to get the correct memory range to access McPDM
registers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..f65251e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5059,6 +5059,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcpdm_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40132000,
 		.pa_end		= 0x4013207f,
 		.flags		= ADDR_TYPE_RT
@@ -5077,6 +5078,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm = {
 
 static struct omap_hwmod_addr_space omap44xx_mcpdm_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49032000,
 		.pa_end		= 0x4903207f,
 		.flags		= ADDR_TYPE_RT
-- 
1.7.12
