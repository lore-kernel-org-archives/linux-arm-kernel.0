From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 22:00:58 +0900
Subject: [PATCH 2/5] ARM: shmobile: kzm9g: Remove warning about SMP
In-Reply-To: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360933261-6359-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove warning about SMP not working with the
clock initialisation used for kzm9g reference.

This is resolved by not selecting CONFIG_PREEMPT.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index a677d61..bce2a49 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -98,13 +98,6 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-/* Please note that the clock initialisation shcheme used in
- * sh73a0_add_early_devices_dt() and sh73a0_add_standard_devices_dt()
- * does not work with SMP as there is a yet to be resolved lock-up in
- * workqueue initialisation.
- *
- * CONFIG_SMP should be disabled when using this code.
- */
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-- 
1.7.10.4
