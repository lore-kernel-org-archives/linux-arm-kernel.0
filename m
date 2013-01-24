From: anilkumar.v@ti.com (Kumar, Anil)
Date: Thu, 24 Jan 2013 14:08:15 +0530
Subject: [PATCH 2/2] ARM: davinci: da850: add wdt OF_DEV_AUXDATA entry
In-Reply-To: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
References: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
Message-ID: <1359016695-10362-3-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF_DEV_AUXDATA for wdt driver in da850 board dt
file to use wdt clock.

Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
---
:100644 100644 37c27af... 1b295d2... M	arch/arm/mach-davinci/da8xx-dt.c
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 37c27af..1b295d2 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -37,11 +37,17 @@ static void __init da8xx_init_irq(void)
 	of_irq_init(da8xx_irq_match);
 }
 
+struct of_dev_auxdata da850_evm_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("ti,davinci-wdt", 0x1c21000, "watchdog", NULL),
+	{}
+};
+
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			da850_evm_auxdata_lookup, NULL);
 
 	da8xx_uart_clk_enable();
 }
-- 
1.7.4.1
