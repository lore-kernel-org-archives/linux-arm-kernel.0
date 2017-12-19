From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 19 Dec 2017 16:54:44 +0100
Subject: [PATCH] soc: renesas: rcar-sysc: Mark rcar_sysc_matches[] __initconst
Message-ID: <1513698884-26663-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rcar_sysc_matches[] is used only by rcar_sysc_pd_init(), which is
__init.  Hence mark rcar_sysc_matches[] __initconst.

This frees another 1764 bytes (arm32/shmobile_defconfig) or 1000 bytes
(arm64/renesas_defconfig) of memory after kernel init.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 52c25a5e2646c839..636872bc24167bb7 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -254,7 +254,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 	pm_genpd_init(genpd, gov, false);
 }
 
-static const struct of_device_id rcar_sysc_matches[] = {
+static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A7743
 	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
 #endif
-- 
2.7.4
