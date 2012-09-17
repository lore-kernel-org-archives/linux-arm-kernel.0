From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:26:59 +0200
Subject: [PATCH 02/16] arm: at91: use macro to declare soc boot data
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of check the pointer of the init function, check the new builtin bool
to known if the soc is enabled.

This is needed as with the switch to the pinctrl the init will be NULL on pure
DT SoC.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91rm9200.c  |    4 ++--
 arch/arm/mach-at91/at91sam9260.c |    4 ++--
 arch/arm/mach-at91/at91sam9261.c |    4 ++--
 arch/arm/mach-at91/at91sam9263.c |    4 ++--
 arch/arm/mach-at91/at91sam9g45.c |    4 ++--
 arch/arm/mach-at91/at91sam9n12.c |    4 ++--
 arch/arm/mach-at91/at91sam9rl.c  |    4 ++--
 arch/arm/mach-at91/at91sam9x5.c  |    4 ++--
 arch/arm/mach-at91/soc.h         |   12 +++++++++++-
 9 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 6f50c67..ea71fdd 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -360,10 +360,10 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0	/* Advanced Interrupt Controller (IRQ6) */
 };
 
-struct at91_init_soc __initdata at91rm9200_soc = {
+AT91_SOC_START(rm9200)
 	.map_io = at91rm9200_map_io,
 	.default_irq_priority = at91rm9200_default_irq_priority,
 	.ioremap_registers = at91rm9200_ioremap_registers,
 	.register_clocks = at91rm9200_register_clocks,
 	.init = at91rm9200_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 30c7f26..4462c8d 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -387,10 +387,10 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_init_soc __initdata at91sam9260_soc = {
+AT91_SOC_START(sam9260)
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
 	.ioremap_registers = at91sam9260_ioremap_registers,
 	.register_clocks = at91sam9260_register_clocks,
 	.init = at91sam9260_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index f40762c..488f639 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -332,10 +332,10 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_init_soc __initdata at91sam9261_soc = {
+AT91_SOC_START(sam9261)
 	.map_io = at91sam9261_map_io,
 	.default_irq_priority = at91sam9261_default_irq_priority,
 	.ioremap_registers = at91sam9261_ioremap_registers,
 	.register_clocks = at91sam9261_register_clocks,
 	.init = at91sam9261_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 84b3810..e642846 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -363,10 +363,10 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-struct at91_init_soc __initdata at91sam9263_soc = {
+AT91_SOC_START(sam9263)
 	.map_io = at91sam9263_map_io,
 	.default_irq_priority = at91sam9263_default_irq_priority,
 	.ioremap_registers = at91sam9263_ioremap_registers,
 	.register_clocks = at91sam9263_register_clocks,
 	.init = at91sam9263_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index ef6cedd..fb1fba1 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -405,10 +405,10 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
-struct at91_init_soc __initdata at91sam9g45_soc = {
+AT91_SOC_START(sam9g45)
 	.map_io = at91sam9g45_map_io,
 	.default_irq_priority = at91sam9g45_default_irq_priority,
 	.ioremap_registers = at91sam9g45_ioremap_registers,
 	.register_clocks = at91sam9g45_register_clocks,
 	.init = at91sam9g45_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index 0849466..80b2b7d 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -226,8 +226,8 @@ void __init at91sam9n12_initialize(void)
 	at91_gpio_init(NULL, 0);
 }
 
-struct at91_init_soc __initdata at91sam9n12_soc = {
+AT91_SOC_START(sam9n12)
 	.map_io = at91sam9n12_map_io,
 	.register_clocks = at91sam9n12_register_clocks,
 	.init = at91sam9n12_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 72ce50a..e5fab22 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -336,10 +336,10 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-struct at91_init_soc __initdata at91sam9rl_soc = {
+AT91_SOC_START(sam9rl)
 	.map_io = at91sam9rl_map_io,
 	.default_irq_priority = at91sam9rl_default_irq_priority,
 	.ioremap_registers = at91sam9rl_ioremap_registers,
 	.register_clocks = at91sam9rl_register_clocks,
 	.init = at91sam9rl_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 477cf9d..56b6988 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -320,8 +320,8 @@ void __init at91sam9x5_initialize(void)
  *  Interrupt initialization
  * -------------------------------------------------------------------- */
 
-struct at91_init_soc __initdata at91sam9x5_soc = {
+AT91_SOC_START(sam9x5)
 	.map_io = at91sam9x5_map_io,
 	.register_clocks = at91sam9x5_register_clocks,
 	.init = at91sam9x5_initialize,
-};
+AT91_SOC_END
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index a9cfeb1..9c6d3d4 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -5,6 +5,7 @@
  */
 
 struct at91_init_soc {
+	int builtin;
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
 	void (*ioremap_registers)(void);
@@ -22,9 +23,18 @@ extern struct at91_init_soc at91sam9rl_soc;
 extern struct at91_init_soc at91sam9x5_soc;
 extern struct at91_init_soc at91sam9n12_soc;
 
+#define AT91_SOC_START(_name)				\
+struct at91_init_soc __initdata at91##_name##_soc	\
+ __used							\
+						= {	\
+	.builtin	= 1,				\
+
+#define AT91_SOC_END					\
+};
+
 static inline int at91_soc_is_enabled(void)
 {
-	return at91_boot_soc.init != NULL;
+	return at91_boot_soc.builtin;
 }
 
 #if !defined(CONFIG_SOC_AT91RM9200)
-- 
1.7.10.4
