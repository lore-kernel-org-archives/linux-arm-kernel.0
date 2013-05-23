From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 00:59:16 +0200
Subject: [PATCH 1/1] ARM: at91: at91sam9n12: move external irq declatation to
 DT
Message-ID: <1369349956-22985-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |    1 +
 arch/arm/mach-at91/at91sam9n12.c   |    6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 566af32..d864f7a9 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -60,6 +60,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <31>;
 			};
 
 			ramc0: ramc at ffffe800 {
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index 13cdbcd..c7d670d1 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -223,13 +223,7 @@ static void __init at91sam9n12_map_io(void)
 	at91_init_sram(0, AT91SAM9N12_SRAM_BASE, AT91SAM9N12_SRAM_SIZE);
 }
 
-void __init at91sam9n12_initialize(void)
-{
-	at91_extern_irq = (1 << AT91SAM9N12_ID_IRQ0);
-}
-
 AT91_SOC_START(at91sam9n12)
 	.map_io = at91sam9n12_map_io,
 	.register_clocks = at91sam9n12_register_clocks,
-	.init = at91sam9n12_initialize,
 AT91_SOC_END
-- 
1.7.10.4
