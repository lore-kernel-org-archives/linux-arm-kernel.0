From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:12:25 +0100
Subject: [PATCH 05/12] ARM: at91: add ioremap_registers entry point to soc
 setup
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321207952-13556-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to ioremap the register of the PIT, PMC and others
and make the code soc independent

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c    |    5 +++++
 arch/arm/mach-at91/at91rm9200.c  |    5 +++++
 arch/arm/mach-at91/at91sam9260.c |    5 +++++
 arch/arm/mach-at91/at91sam9261.c |    5 +++++
 arch/arm/mach-at91/at91sam9263.c |    5 +++++
 arch/arm/mach-at91/at91sam9g45.c |    5 +++++
 arch/arm/mach-at91/at91sam9rl.c  |    5 +++++
 arch/arm/mach-at91/setup.c       |    2 ++
 arch/arm/mach-at91/soc.h         |    1 +
 9 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index fe00dce..3687207 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -333,6 +333,10 @@ static void __init at91cap9_map_io(void)
 	at91_init_sram(0, AT91CAP9_SRAM_BASE, AT91CAP9_SRAM_SIZE);
 }
 
+static void __init at91cap9_ioremap_registers(void)
+{
+}
+
 static void __init at91cap9_initialize(void)
 {
 	at91_arch_reset = at91cap9_reset;
@@ -394,6 +398,7 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91cap9_soc = {
 	.map_io = at91cap9_map_io,
 	.default_irq_priority = at91cap9_default_irq_priority,
+	.ioremap_registers = at91cap9_ioremap_registers,
 	.register_clocks = at91cap9_register_clocks,
 	.init = at91cap9_initialize,
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 8ce8675..c67d50c 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -307,6 +307,10 @@ static void __init at91rm9200_map_io(void)
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 }
 
+static void __init at91rm9200_ioremap_registers(void)
+{
+}
+
 static void __init at91rm9200_initialize(void)
 {
 	at91_arch_reset = at91rm9200_reset;
@@ -366,6 +370,7 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91rm9200_soc = {
 	.map_io = at91rm9200_map_io,
 	.default_irq_priority = at91rm9200_default_irq_priority,
+	.ioremap_registers = at91rm9200_ioremap_registers,
 	.register_clocks = at91rm9200_register_clocks,
 	.init = at91rm9200_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 1e9c79f..0e54928 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -325,6 +325,10 @@ static void __init at91sam9260_map_io(void)
 	}
 }
 
+static void __init at91sam9260_ioremap_registers(void)
+{
+}
+
 static void __init at91sam9260_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
@@ -381,6 +385,7 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
+	.ioremap_registers = at91sam9260_ioremap_registers,
 	.register_clocks = at91sam9260_register_clocks,
 	.init = at91sam9260_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 574aa6b..dde8318 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -285,6 +285,10 @@ static void __init at91sam9261_map_io(void)
 		at91_init_sram(0, AT91SAM9261_SRAM_BASE, AT91SAM9261_SRAM_SIZE);
 }
 
+static void __init at91sam9261_ioremap_registers(void)
+{
+}
+
 static void __init at91sam9261_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
@@ -341,6 +345,7 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9261_soc = {
 	.map_io = at91sam9261_map_io,
 	.default_irq_priority = at91sam9261_default_irq_priority,
+	.ioremap_registers = at91sam9261_ioremap_registers,
 	.register_clocks = at91sam9261_register_clocks,
 	.init = at91sam9261_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index dee0ed7..fc442dd 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -303,6 +303,10 @@ static void __init at91sam9263_map_io(void)
 	at91_init_sram(1, AT91SAM9263_SRAM1_BASE, AT91SAM9263_SRAM1_SIZE);
 }
 
+static void __init at91sam9263_ioremap_registers(void)
+{
+}
+
 static void __init at91sam9263_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
@@ -358,6 +362,7 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9263_soc = {
 	.map_io = at91sam9263_map_io,
 	.default_irq_priority = at91sam9263_default_irq_priority,
+	.ioremap_registers = at91sam9263_ioremap_registers,
 	.register_clocks = at91sam9263_register_clocks,
 	.init = at91sam9263_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 404d70c..56282b2 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -338,6 +338,10 @@ static void __init at91sam9g45_map_io(void)
 	init_consistent_dma_size(SZ_4M);
 }
 
+static void __init at91sam9g45_ioremap_registers(void)
+{
+}
+
 static void __init at91sam9g45_initialize(void)
 {
 	at91_arch_reset = at91sam9g45_reset;
@@ -393,6 +397,7 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9g45_soc = {
 	.map_io = at91sam9g45_map_io,
 	.default_irq_priority = at91sam9g45_default_irq_priority,
+	.ioremap_registers = at91sam9g45_ioremap_registers,
 	.register_clocks = at91sam9g45_register_clocks,
 	.init = at91sam9g45_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index c4004e2..29dae9b 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -290,6 +290,10 @@ static void __init at91sam9rl_map_io(void)
 	at91_init_sram(0, AT91SAM9RL_SRAM_BASE, sram_size);
 }
 
+static void __init at91sam9rl_ioremap_registers(void)
+{
+}
+
 static void __init at91sam9rl_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
@@ -345,6 +349,7 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9rl_soc = {
 	.map_io = at91sam9rl_map_io,
 	.default_irq_priority = at91sam9rl_default_irq_priority,
+	.ioremap_registers = at91sam9rl_ioremap_registers,
 	.register_clocks = at91sam9rl_register_clocks,
 	.init = at91sam9rl_initialize,
 };
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index aa64294..63b3ac2 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -287,6 +287,8 @@ void __init at91_map_io(void)
 
 void __init at91_initialize(unsigned long main_clock)
 {
+	at91_boot_soc.ioremap_registers();
+
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
 
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index cdf6ccf..f860a2e 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -7,6 +7,7 @@
 struct at91_init_soc {
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
+	void (*ioremap_registers)(void);
 	void (*register_clocks)(void);
 	void (*init)(void);
 };
-- 
1.7.7
