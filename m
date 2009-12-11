From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Dec 2009 15:53:53 -0800
Subject: [PATCH 08/14] omap3: zoom2/3: make MMC slot work again
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Message-ID: <20091211235353.3189.99578.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anand Gadiyar <gadiyar@ti.com>

omap3: zoom2/3: make MMC slot work again

Commit 12f8dfb56 accidentally broke MMC on zoom2/3.
The .vmmc1 field of zoom_twldata was deleted. Restoring it
allows the MMC slot to work again

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f14baa3..221a8e3 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -236,6 +236,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
 	.codec		= &zoom_codec_data,
+	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
 	.vsim           = &zoom_vsim,
 
