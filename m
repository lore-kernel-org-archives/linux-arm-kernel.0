From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:12 -0600
Subject: [PATCH v1 4/6] ARM: davinci: make davinci_clk_reset() static
In-Reply-To: <1512182054-17410-1-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
Message-ID: <1512182054-17410-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes davinci_clk_reset() static. It is not used anywhere else.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/clock.c | 3 +--
 arch/arm/mach-davinci/clock.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 5f0a31d..c149b24 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -59,7 +59,7 @@ void davinci_clk_disable(struct clk *clk)
 		davinci_clk_disable(clk->parent);
 }
 
-int davinci_clk_reset(struct clk *clk, bool reset)
+static int davinci_clk_reset(struct clk *clk, bool reset)
 {
 	unsigned long flags;
 
@@ -73,7 +73,6 @@ int davinci_clk_reset(struct clk *clk, bool reset)
 
 	return 0;
 }
-EXPORT_SYMBOL(davinci_clk_reset);
 
 int davinci_clk_reset_assert(struct clk *clk)
 {
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index e4afaa9..bf60cdf 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -124,7 +124,6 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
 int davinci_set_refclk_rate(unsigned long rate);
 int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
-int davinci_clk_reset(struct clk *clk, bool reset);
 void davinci_clk_enable(struct clk *clk);
 void davinci_clk_disable(struct clk *clk);
 
-- 
2.7.4
