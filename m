From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:00 +0100
Subject: [PATCH 4/9] pca100: use correct irq initialisation function
In-Reply-To: <1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/pca100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/pca100.c b/arch/arm/mach-mx2/pca100.c
index fe5b165..aea3d34 100644
--- a/arch/arm/mach-mx2/pca100.c
+++ b/arch/arm/mach-mx2/pca100.c
@@ -237,7 +237,7 @@ MACHINE_START(PCA100, "phyCARD-i.MX27")
 	.io_pg_offst    = ((AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
-	.init_irq       = mxc_init_irq,
+	.init_irq       = mx27_init_irq,
 	.init_machine   = pca100_init,
 	.timer          = &pca100_timer,
 MACHINE_END
-- 
1.6.5.2
