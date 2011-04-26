From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 03:11:39 +0200
Subject: [PATCH 13/14] at91: move register clocks to soc generic init
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303780300-2205-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c |    4 +---
 arch/arm/mach-at91/at91cap9.c    |    4 +---
 arch/arm/mach-at91/at91rm9200.c  |    4 +---
 arch/arm/mach-at91/at91sam9260.c |    4 +---
 arch/arm/mach-at91/at91sam9261.c |    4 +---
 arch/arm/mach-at91/at91sam9263.c |    4 +---
 arch/arm/mach-at91/at91sam9g45.c |    4 +---
 arch/arm/mach-at91/at91sam9rl.c  |    4 +---
 arch/arm/mach-at91/soc.c         |    3 +++
 arch/arm/mach-at91/soc.h         |    1 +
 10 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 66405af..7d7a4f2 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -370,9 +370,6 @@ static void __init at572d940hf_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at572d940hf_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -425,6 +422,7 @@ struct at91_dev_resource at572d940hf_pit __initdata = {
 struct at91_soc __initdata at572d940hf_soc = {
 	.name = "at572d940hf",
 	.default_irq_priority = at572d940hf_default_irq_priority,
+	.register_clocks = at572d940hf_register_clocks,
 	.init = at572d940hf_initialize,
 	.gpio = {
 		.resource = at572d940hf_pios,
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index dd5e858..c304d9c 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -368,9 +368,6 @@ static void __init at91cap9_initialize(unsigned long main_clock)
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
 
-	/* Register the processor-specific clocks */
-	at91cap9_register_clocks();
-
 	/* Remember the silicon revision */
 	if (cpu_is_at91cap9_revB())
 		system_rev = 0xB;
@@ -428,6 +425,7 @@ struct at91_dev_resource at91cap9_pit __initdata = {
 struct at91_soc __initdata at91cap9_soc = {
 	.name = "at91cap9",
 	.default_irq_priority = at91cap9_default_irq_priority,
+	.register_clocks = at91cap9_register_clocks,
 	.init = at91cap9_initialize,
 	.gpio = {
 		.resource = at91cap9_pios,
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 7b9d3a4..f5f5711 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -330,9 +330,6 @@ static void __init at91rm9200_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91rm9200_register_clocks();
 }
 
 
@@ -386,6 +383,7 @@ struct at91_dev_resource at91rm9200_st __initdata = {
 struct at91_soc __initdata at91rm9200_soc = {
 	.name = "at91rm9200",
 	.default_irq_priority = at91rm9200_default_irq_priority,
+	.register_clocks = at91rm9200_register_clocks,
 	.init = at91rm9200_initialize,
 	.gpio = {
 		.resource = at91rm9200_pios,
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 0567556b..7a2d10b 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -362,9 +362,6 @@ static void __init at91sam9260_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91sam9260_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -417,6 +414,7 @@ struct at91_dev_resource at91sam9260_pit __initdata = {
 struct at91_soc __initdata at91sam9260_soc = {
 	.name = "at91sam9260",
 	.default_irq_priority = at91sam9260_default_irq_priority,
+	.register_clocks = at91sam9260_register_clocks,
 	.init = at91sam9260_initialize,
 	.gpio = {
 		.resource = at91sam9260_pios,
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 603c6fe..a2ee99d 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -328,9 +328,6 @@ static void __init at91sam9261_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91sam9261_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -383,6 +380,7 @@ struct at91_dev_resource at91sam9261_pit __initdata = {
 struct at91_soc __initdata at91sam9261_soc = {
 	.name = "at91sam9261",
 	.default_irq_priority = at91sam9261_default_irq_priority,
+	.register_clocks = at91sam9261_register_clocks,
 	.init = at91sam9261_initialize,
 	.gpio = {
 		.resource = at91sam9261_pios,
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index e7ff884..0b9a6b4 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -337,9 +337,6 @@ static void __init at91sam9263_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91sam9263_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -392,6 +389,7 @@ struct at91_dev_resource at91sam9263_pit __initdata = {
 struct at91_soc __initdata at91sam9263_soc = {
 	.name = "at91sam9263",
 	.default_irq_priority = at91sam9263_default_irq_priority,
+	.register_clocks = at91sam9263_register_clocks,
 	.init = at91sam9263_initialize,
 	.gpio = {
 		.resource = at91sam9263_pios,
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 077eecf..96cfc16 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -355,9 +355,6 @@ static void __init at91sam9g45_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91sam9g45_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -410,6 +407,7 @@ struct at91_dev_resource at91sam9g45_pit __initdata = {
 struct at91_soc __initdata at91sam9g45_soc = {
 	.name = "at91sam9g45",
 	.default_irq_priority = at91sam9g45_default_irq_priority,
+	.register_clocks = at91sam9g45_register_clocks,
 	.init = at91sam9g45_initialize,
 	.gpio = {
 		.resource = at91sam9g45_pios,
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 7623617..638e921 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -321,9 +321,6 @@ static void __init at91sam9rl_initialize(unsigned long main_clock)
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-
-	/* Register the processor-specific clocks */
-	at91sam9rl_register_clocks();
 }
 
 /* --------------------------------------------------------------------
@@ -376,6 +373,7 @@ struct at91_dev_resource at91sam9rl_pit __initdata = {
 struct at91_soc __initdata at91sam9rl_soc = {
 	.name = "at91sam9rl",
 	.default_irq_priority = at91sam9rl_default_irq_priority,
+	.register_clocks = at91sam9rl_register_clocks,
 	.init = at91sam9rl_initialize,
 	.gpio = {
 		.resource = at91sam9rl_pios,
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index 1b05997..c82d219 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -117,6 +117,9 @@ void __init at91_initialize(unsigned long main_clock)
 
 	current_soc.init(main_clock);
 
+	/* Register the processor-specific clocks */
+	current_soc.register_clocks();
+
 	/* Register GPIO subsystem */
 	at91_add_gpio();
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index a60ac0a..ca8b30e 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -16,6 +16,7 @@ struct at91_soc {
 	struct at91_dev_resource *pit;
 	struct at91_dev_resource *st;
 
+	void (*register_clocks)(void);
 	void (*init)(unsigned long main_clock);
 };
 
-- 
1.7.4.1
