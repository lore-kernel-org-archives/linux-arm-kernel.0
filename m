From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 19:05:21 -0800
Subject: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Message-ID: <20101218030521.10251.89993.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raghuveer Murthy <raghuveer.murthy@ti.com>

This patch adds omap_reserve functionality to board-omap4panda.c.
Helps in the reserving boot time memory in SDRAM, used here for
framebuffer allocation.

This patch is in similar lines to commit id 71ee7dad9b6991, from
Russell king

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 38f942b..9f49e23 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -407,6 +407,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.map_io		= omap4_panda_map_io,
+	.reserve	= omap_reserve,
 	.init_irq	= omap4_panda_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap_timer,
