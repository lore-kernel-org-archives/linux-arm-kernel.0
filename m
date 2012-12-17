From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 17 Dec 2012 19:26:31 +0200
Subject: [PATCH 2/2] ARM: OMAP4: PRCM: Fix incorrect read of reset sources
In-Reply-To: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1355765191-21545-2-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of PRM_RSTST register and flag mask are incorrect,
so fix it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/mach-omap2/prcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index dc45156..02f27f2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -53,8 +53,8 @@ u32 omap_prcm_get_reset_sources(void)
 	if (cpu_is_omap34xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7ff;
 	if (cpu_is_omap44xx())
-		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
-
+		return omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+					       OMAP4_PRM_RSTST_OFFSET) & 0x7ff;
 	return 0;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
-- 
1.7.9.5
