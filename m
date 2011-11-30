From: jtzhou@marvell.com (Jett.Zhou)
Date: Wed, 30 Nov 2011 14:31:19 +0800
Subject: [V3 4/6] ARM: pxa: add dummy clock for sa1100-rtc
Message-ID: <1322634679-4508-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now sa1100-rtc can support sa1100/pxa/mmp soc series, then we need
add dummy clock for sa1100-rtc.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 arch/arm/mach-pxa/pxa27x.c |    1 +
 arch/arm/mach-pxa/pxa300.c |    1 +
 arch/arm/mach-pxa/pxa320.c |    1 +
 arch/arm/mach-pxa/pxa3xx.c |    1 +
 arch/arm/mach-pxa/pxa95x.c |    1 +
 6 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index f05f948..883b3b6 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -208,6 +208,7 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index bc5a98e..237f531 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -229,6 +229,7 @@ static struct clk_lookup pxa27x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 40bb165..0388eda 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -89,6 +89,7 @@ static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
 static struct clk_lookup common_clkregs[] = {
 	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index 8d614ec..d487e1f 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -83,6 +83,7 @@ static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
 static struct clk_lookup pxa320_clkregs[] = {
 	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static int __init pxa320_init(void)
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 0737c59..89675e3 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -67,6 +67,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
 	/* Power I2C clock is always on */
 	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
 	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
 	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 51371b3..210b722 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -217,6 +217,7 @@ static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
 	/* Power I2C clock is always on */
 	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 	INIT_CLKREG(&clk_pxa95x_lcd, "pxa2xx-fb", NULL),
 	INIT_CLKREG(&clk_pxa95x_ffuart, "pxa2xx-uart.0", NULL),
 	INIT_CLKREG(&clk_pxa95x_btuart, "pxa2xx-uart.1", NULL),
-- 
1.7.0.4
