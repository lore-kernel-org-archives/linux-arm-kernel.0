From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 31 Jan 2010 11:34:02 +0200
Subject: [PATCH] [ARM] pxa: match camera clock by struct device
Message-ID: <1264930442-28819-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/pxa3xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index fcb0721..9d338a7 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -257,7 +257,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	/* Power I2C clock is always on */
 	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
+	INIT_CLKREG(&clk_pxa3xx_camera, "pxa27x-camera.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
 	INIT_CLKREG(&clk_pxa3xx_ffuart, "pxa2xx-uart.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_btuart, "pxa2xx-uart.1", NULL),
-- 
1.6.4.4
