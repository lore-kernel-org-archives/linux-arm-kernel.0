From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 14 Nov 2014 16:53:58 +0100
Subject: [PATCH 2/2] ARM: nspire: Remove unneeded nspire_map_io()
In-Reply-To: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
References: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1415980438-12939-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nspire_map_io() just calls debug_ll_io_init().

If machine_desc.map_io is not set, devicemaps_init() in the
common ARM code will call debug_ll_io_init(), so nspire_map_io() and the
initialization of .map_io can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested

 arch/arm/mach-nspire/nspire.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 3d24ebf120953d93..1b7bd7bc62390fc1 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -35,11 +35,6 @@ static const char *nspire_dt_match[] __initconst = {
 	NULL,
 };
 
-static void __init nspire_map_io(void)
-{
-	debug_ll_io_init();
-}
-
 static struct clcd_board nspire_clcd_data = {
 	.name		= "LCD",
 	.caps		= CLCD_CAP_5551 | CLCD_CAP_565,
@@ -74,7 +69,6 @@ static void nspire_restart(enum reboot_mode mode, const char *cmd)
 
 DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
 	.dt_compat	= nspire_dt_match,
-	.map_io		= nspire_map_io,
 	.init_machine	= nspire_init,
 	.restart	= nspire_restart,
 MACHINE_END
-- 
1.9.1
