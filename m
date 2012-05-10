From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 10 May 2012 13:21:03 +0300
Subject: [PATCH 2/3] ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
In-Reply-To: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1336645264-909-3-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmod class for rfbi is missing SYSS_HAS_RESET_STATUS, which this patch
adds.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index f08e442..bae4afd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -65,7 +65,7 @@ static struct omap_hwmod_class_sysconfig omap2_rfbi_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
-- 
1.7.9.5
