From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:31 +0200
Subject: [PATCH 16/21] soc: renesas: rcar-sysc: Add r8a7744 support
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <c3299eb2770b43471516666bd20f78ed5588f868.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for RZ/G1N (R8A7744) SoC power areas to the R-Car SYSC driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Kconfig     | 2 +-
 drivers/soc/renesas/rcar-sysc.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 05086ac2108b..407f02c80e8b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -7,7 +7,7 @@ config SOC_RENESAS
 			   ARCH_R8A774A1 || ARCH_R8A774C0 || ARCH_R8A7795 || \
 			   ARCH_R8A7796 || ARCH_R8A77965 || ARCH_R8A77970 || \
 			   ARCH_R8A77980 || ARCH_R8A77990 || ARCH_R8A77995
-	select SYSC_R8A7743 if ARCH_R8A7743
+	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
 	select SYSC_R8A774A1 if ARCH_R8A774A1
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 08c8b62896b7..af53363eda03 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -265,6 +265,8 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A7743
 	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
+	/* RZ/G1N is identical to RZ/G2M w.r.t. power domains. */
+	{ .compatible = "renesas,r8a7744-sysc", .data = &r8a7743_sysc_info },
 #endif
 #ifdef CONFIG_SYSC_R8A7745
 	{ .compatible = "renesas,r8a7745-sysc", .data = &r8a7745_sysc_info },
-- 
2.11.0
