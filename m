From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 24 Jan 2013 16:25:15 +0530
Subject: [PATCH 1/6] ARM: davinci: da850: add OF_DEV_AUXDATA entry for I2C0
In-Reply-To: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
References: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359024920-32190-2-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF_DEV_AUXDATA for I2C0 controller driver in da850 board
dt file to use I2C0 clock.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 37c27af..100d644 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -37,11 +37,17 @@ static void __init da8xx_init_irq(void)
 	of_irq_init(da8xx_irq_match);
 }
 
+struct of_dev_auxdata da850_evm_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
+	{}
+};
+
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+				da850_evm_auxdata_lookup, NULL);
 
 	da8xx_uart_clk_enable();
 }
-- 
1.7.4.1
