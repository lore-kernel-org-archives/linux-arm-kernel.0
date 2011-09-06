From: weber@corscience.de (Thomas Weber)
Date: Tue,  6 Sep 2011 17:11:49 +0200
Subject: [PATCH] OMAP2: Devkit8000: Remove double omap_mux_init_gpio
Message-ID: <1315321909-5593-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the init of card detect pin because
omap_mux_init_gpio() is called during hsmmc initialization
for the write protect and card detect pin.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index f15f2a2..029c08a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -226,7 +226,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 {
 	int ret;
 
-	omap_mux_init_gpio(29, OMAP_PIN_INPUT);
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
-- 
1.7.6.1
