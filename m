From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:24 -0700
Subject: [PATCH 8/8] OMAP clock: remove incorrect EXPORT_SYMBOL()s
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042022.27280.12285.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only symbols that should be exported are symbols that are to be
called from loadable kernel modules, e.g., device drivers.  In the
context of plat-omap/clock.c, these should only be the Linux clock
interface symbols as defined by include/linux/clk.h.  Core code
doesn't need these symbols to be exported.  Also, clean up an old
comment while here.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 89cafc9..a64d84c 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -36,10 +36,6 @@ static struct clk_functions *arch_clock;
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
 
-/* This functions is moved to arch/arm/common/clkdev.c. For OMAP4 since
- * clock framework is not up , it is defined here to avoid rework in
- * every driver. Also dummy prcm reset function is added */
-
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
@@ -305,7 +301,6 @@ void clk_enable_init_clocks(void)
 			clk_enable(clkp);
 	}
 }
-EXPORT_SYMBOL(clk_enable_init_clocks);
 
 /*
  * Low level helpers
@@ -334,7 +329,6 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 		arch_clock->clk_init_cpufreq_table(table);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
-EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
 
 /*-------------------------------------------------------------------------*/
