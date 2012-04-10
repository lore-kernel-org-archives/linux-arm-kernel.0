From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:53 +0200
Subject: [PATCH 40/40] ARM i.MX: Remove now unused struct clk argument from
 mxc_timer_init
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-41-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx1.c            |    3 +--
 arch/arm/mach-imx/clk-imx21.c           |    4 ++--
 arch/arm/mach-imx/clk-imx25.c           |    2 +-
 arch/arm/mach-imx/clk-imx27.c           |    3 +--
 arch/arm/mach-imx/clk-imx31.c           |    3 +--
 arch/arm/mach-imx/clk-imx35.c           |    3 +--
 arch/arm/mach-imx/clk-imx51-imx53.c     |    6 ++----
 arch/arm/mach-imx/clk-imx6q.c           |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +-
 arch/arm/plat-mxc/time.c                |    4 ++--
 10 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 60f1801..9d58776 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -102,8 +102,7 @@ int __init mx1_clocks_init(unsigned long fref)
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	mxc_timer_init(NULL, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
-			MX1_TIM1_INT);
+	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index c4779a0..e4a0ede 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -167,7 +167,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	mxc_timer_init(NULL, MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR),
-			MX21_INT_GPT1);
+	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1);
+
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 717b8a0..9cde523 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -227,6 +227,6 @@ int __init mx25_clocks_init(void)
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	mxc_timer_init(NULL, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
+	mxc_timer_init(MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 3a1e965..d81c3c6 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -246,8 +246,7 @@ int __init mx27_clocks_init(unsigned long fref)
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	mxc_timer_init(NULL, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
-			MX27_INT_GPT1);
+	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
 	clk_prepare_enable(emi_ahb);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index de3addb..b57a460 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -161,8 +161,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(iim);
 
-	mxc_timer_init(NULL, MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR),
-			MX31_INT_GPT);
+	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 7d26ae8..a77502a 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -251,8 +251,7 @@ int __init mx35_clocks_init()
 	epit_timer_init(&epit1_clk,
 			MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
 #else
-	mxc_timer_init(NULL, MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR),
-			MX35_INT_GPT);
+	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 5b5d7a0..4d8229e 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -309,8 +309,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(esdhc_b_podf, 166250000);
 
 	/* System timer */
-	mxc_timer_init(NULL, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
-		MX51_INT_GPT);
+	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR), MX51_INT_GPT);
 
 	clk_prepare_enable(iim);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -363,8 +362,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(esdhc_b_podf, 200000000);
 
 	/* System timer */
-	mxc_timer_init(NULL, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
-		MX53_INT_GPT);
+	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR), MX53_INT_GPT);
 
 	clk_prepare_enable(iim);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f379fa6..cd48fa5 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -401,7 +401,7 @@ int __init mx6q_clocks_init(void)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 	irq = irq_of_parse_and_map(np, 0);
-	mxc_timer_init(NULL, base, irq);
+	mxc_timer_init(base, irq);
 
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 0319c4a..5cae195 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -54,7 +54,7 @@ extern void imx50_soc_init(void);
 extern void imx51_soc_init(void);
 extern void imx53_soc_init(void);
 extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
-extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
+extern void mxc_timer_init(void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
 extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
 extern int mx25_clocks_init(void);
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 99f958c..f32a249 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -280,10 +280,10 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 	return 0;
 }
 
-void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
+void __init mxc_timer_init(void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
-	struct clk *timer_ipg_clk;
+	struct clk *timer_ipg_clk, *timer_clk;
 
 	if (!timer_clk) {
 		timer_clk = clk_get_sys("imx-gpt.0", "per");
-- 
1.7.9.5
