From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Aug 2011 23:42:41 -0600
Subject: [PATCH 4/5] OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
In-Reply-To: <20110821053355.20198.23847.stgit@dusk>
References: <20110821053355.20198.23847.stgit@dusk>
Message-ID: <20110821054240.20198.21168.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

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
 
