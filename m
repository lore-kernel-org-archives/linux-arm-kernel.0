From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:33:04 +0000
Subject: [PATCH 02/11] Revert "ARM: pxa: add dummy clock for sa1100-rtc"
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rntz6-0002pN-UE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 7557c175f60d8d40baf16b22caf79beadef8f081.

This revert is necessary to revert the broken "RTC: sa1100:
support sa1100, pxa and mmp soc families" change.
---
 arch/arm/mach-pxa/pxa25x.c |    2 --
 arch/arm/mach-pxa/pxa27x.c |    2 --
 arch/arm/mach-pxa/pxa300.c |    1 -
 arch/arm/mach-pxa/pxa320.c |    1 -
 arch/arm/mach-pxa/pxa3xx.c |    1 -
 arch/arm/mach-pxa/pxa95x.c |    1 -
 6 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index adf058f..91e4f6c 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -209,8 +209,6 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 180bd86..aed6cbc 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -230,8 +230,6 @@ static struct clk_lookup pxa27x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 0388eda..40bb165 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -89,7 +89,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
 static struct clk_lookup common_clkregs[] = {
 	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index d487e1f..8d614ec 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -83,7 +83,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
 static struct clk_lookup pxa320_clkregs[] = {
 	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static int __init pxa320_init(void)
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f107c71..4f402af 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -67,7 +67,6 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
 	/* Power I2C clock is always on */
 	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
 	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
 	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index fccc644..d082a58 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -217,7 +217,6 @@ static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
 	/* Power I2C clock is always on */
 	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 	INIT_CLKREG(&clk_pxa95x_lcd, "pxa2xx-fb", NULL),
 	INIT_CLKREG(&clk_pxa95x_ffuart, "pxa2xx-uart.0", NULL),
 	INIT_CLKREG(&clk_pxa95x_btuart, "pxa2xx-uart.1", NULL),
-- 
1.7.4.4
