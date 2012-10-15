From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Oct 2012 17:05:41 -0600
Subject: [PATCH 1/5] ARM: OMAP2+: PRM: remove PRM weak functions
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Message-ID: <20121015230538.18306.93245.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the now-unused PRM weak functions from prm_common.c.  These
were formerly used to ensure that some OMAP2/3 PRM code would build on
OMAP4, but none of those functions ever would have worked on OMAP4 due
to an incompatible PRM register layout.  Now all that has been cleaned
up and these can be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm_common.c |   62 --------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6b4d332..0a100d9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -318,65 +318,3 @@ err:
 	omap_prcm_irq_cleanup();
 	return -ENOMEM;
 }
-
-/*
- * Stubbed functions so that common files continue to build when
- * custom builds are used
- * XXX These are temporary and should be removed at the earliest possible
- * opportunity
- */
-u32 __weak omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-void __weak omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-}
-
-u32 __weak omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
-		s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
-						u8 st_shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
