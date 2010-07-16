From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 16 Jul 2010 11:03:27 +0800
Subject: [PATCH] ARM/nuc900: fix nuc900 touchscreen clk definition bug
Message-ID: <4C3FCBFF.50506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix nuc900 touchscreen clk definition bug,the .dev_id's
name should be 'nuc900-ts', it should be the same to pdev.name. or else,
the touchscreen driver will be not working well due to clock engine disabled.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 642207e..83c5632 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -93,7 +93,7 @@ static struct clk_lookup nuc900_clkregs[] = {
 	DEF_CLKLOOK(&clk_kpi, "nuc900-kpi", NULL),
 	DEF_CLKLOOK(&clk_wdt, "nuc900-wdt", NULL),
 	DEF_CLKLOOK(&clk_gdma, "nuc900-gdma", NULL),
-	DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
+	DEF_CLKLOOK(&clk_adc, "nuc900-ts", NULL),
 	DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
 	DEF_CLKLOOK(&clk_ext, NULL, "ext"),
 	DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
-- 
1.6.3.3
