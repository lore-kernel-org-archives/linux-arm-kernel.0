From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Wed, 9 Jan 2013 16:03:11 +0100
Subject: [PATCH v2 5/5] OMAP4: hwmod data: Update AESS data with memory bank
 area
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1357743792-13917-6-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AESS memory bank data in hwmod in order to provide memory
address information to the driver.

Signed-off-by: sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6d22fd0..631611c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4246,6 +4246,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 
 static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
 	{
+		.name		= "dmem",
+		.pa_start	= 0x40180000,
+		.pa_end		= 0x4018ffff
+	},
+	{
+		.name		= "cmem",
+		.pa_start	= 0x401a0000,
+		.pa_end		= 0x401a1fff
+	},
+	{
+		.name		= "smem",
+		.pa_start	= 0x401c0000,
+		.pa_end		= 0x401c5fff
+	},
+	{
+		.name		= "pmem",
+		.pa_start	= 0x401e0000,
+		.pa_end		= 0x401e1fff
+	},
+	{
+		.name		= "mpu",
 		.pa_start	= 0x401f1000,
 		.pa_end		= 0x401f13ff,
 		.flags		= ADDR_TYPE_RT
@@ -4264,6 +4285,27 @@ static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 
 static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
 	{
+		.name		= "dmem_dma",
+		.pa_start	= 0x49080000,
+		.pa_end		= 0x4908ffff
+	},
+	{
+		.name		= "cmem_dma",
+		.pa_start	= 0x490a0000,
+		.pa_end		= 0x490a1fff
+	},
+	{
+		.name		= "smem_dma",
+		.pa_start	= 0x490c0000,
+		.pa_end		= 0x490c5fff
+	},
+	{
+		.name		= "pmem_dma",
+		.pa_start	= 0x490e0000,
+		.pa_end		= 0x490e1fff
+	},
+	{
+		.name		= "dma",
 		.pa_start	= 0x490f1000,
 		.pa_end		= 0x490f13ff,
 		.flags		= ADDR_TYPE_RT
-- 
1.7.10.4
