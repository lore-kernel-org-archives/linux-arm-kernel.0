From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:17 +0900
Subject: [PATCH 06/10] ARM: shmobile: armadillo800eva: enable restart
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-7-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2912eab..fe27d7e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1229,6 +1229,13 @@ static void __init eva_add_early_devices(void)
 	shmobile_timer.init = eva_earlytimer_init;
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void eva_restart(char mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *eva_boards_compat_dt[] __initdata = {
 	"renesas,armadillo800eva",
 	NULL,
@@ -1243,4 +1250,5 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 	.dt_compat	= eva_boards_compat_dt,
+	.restart	= eva_restart,
 MACHINE_END
-- 
1.7.10.4
