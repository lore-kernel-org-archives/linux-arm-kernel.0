From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  3 Dec 2014 15:17:07 +0100
Subject: [PATCH 4/4] ARM: shmobile: kzm9g-reference: Remove restart callback
In-Reply-To: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1417616227-6715-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the restart handling hack from the kzm9g-reference case.

Restart on DT-based sh73a0 platforms is now handled through the restart
handler registered by the R-Mobile System Controller (SYSC) driver.

This reverts commit 534547c036afad3f ("ARM: shmobile: kzm9g-reference:
Add restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 2e82e44ab85258b7..f2ef759b6e969cc8 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -39,13 +39,6 @@ static void __init kzm_init(void)
 #endif
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -57,6 +50,5 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
-	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.9.1
