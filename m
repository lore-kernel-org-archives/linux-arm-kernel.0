From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Aug 2011 15:28:18 +0300
Subject: [PATCH 8/9] OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1314102499-30407-9-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP2/3 dss_core has a reset status flag in sysstatus register. Add
SYSS_HAS_RESET_STATUS flag to HWMOD data so it can be used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index c451729..d78c132 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -43,7 +43,8 @@ static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.4.1
