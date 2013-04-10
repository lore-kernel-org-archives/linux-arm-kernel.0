From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Apr 2013 14:57:13 +0530
Subject: [PATCH 2/4] ARM: davinci: da8xx dt: make file local symbols static
In-Reply-To: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
References: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365586035-26583-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make some file-local functions static. This fixes the sparse
warnings:

  CHECK   arch/arm/mach-davinci/da8xx-dt.c
arch/arm/mach-davinci/da8xx-dt.c:23:13: warning: symbol 'da8xx_uart_clk_enable' was not declared. Should it be static?
arch/arm/mach-davinci/da8xx-dt.c:40:23: warning: symbol 'da850_auxdata_lookup' was not declared. Should it be static?

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 6b7a0a2..57e14a8 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,7 +20,7 @@
 
 #define DA8XX_NUM_UARTS	3
 
-void __init da8xx_uart_clk_enable(void)
+static void __init da8xx_uart_clk_enable(void)
 {
 	int i;
 	for (i = 0; i < DA8XX_NUM_UARTS; i++)
@@ -37,7 +37,7 @@ static void __init da8xx_init_irq(void)
 	of_irq_init(da8xx_irq_match);
 }
 
-struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
+static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
 	{}
-- 
1.7.10.1
