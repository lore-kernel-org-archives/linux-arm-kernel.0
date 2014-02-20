From: elder@linaro.org (Alex Elder)
Date: Wed, 19 Feb 2014 18:12:54 -0600
Subject: [PATCH 04/12] mach-bcm: bcm281xx: more symbol cleanup
In-Reply-To: <1392855182-21155-1-git-send-email-elder@linaro.org>
References: <1392855182-21155-1-git-send-email-elder@linaro.org>
Message-ID: <1392855182-21155-5-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As with the previous commit, this renames a few symbols that
needlessly used "11351" rather than "281xx" in their names.

Support for the bcm11351 board is being removed from the kernel, and
the family of boards is more properly referred to as "bcm281xx".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-bcm/board_bcm281xx.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index cb3dc36..d8f0b6c 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -65,10 +65,13 @@ static void __init board_init(void)
 	kona_l2_cache_init();
 }
 
-static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
+static const char * const bcm281xx_dt_compat[] = {
+	"brcm,bcm11351",	/* Have to use the first number upstreamed */
+	NULL,
+};
 
-DT_MACHINE_START(BCM11351_DT, "BCM281xx Broadcom Application Processor")
+DT_MACHINE_START(BCM281XX_DT, "BCM281xx Broadcom Application Processor")
 	.init_machine = board_init,
 	.restart = bcm_kona_restart,
-	.dt_compat = bcm11351_dt_compat,
+	.dt_compat = bcm281xx_dt_compat,
 MACHINE_END
-- 
1.7.9.5
