From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Jan 2011 16:34:46 +0530
Subject: [PATCH 4/6] omap4: dpll: Enable all DPLL autoidle at boot
In-Reply-To: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1296212688-21951-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Enable all DPLL autoidle at boot on OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e8cb32f..e5c59a0 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3300,6 +3300,8 @@ int __init omap4xxx_clk_init(void)
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
 			omap2_init_clk_clkdm(c->lk.clk);
+			if (c->lk.clk->dpll_data)
+				omap3_dpll_allow_idle(c->lk.clk);
 		}
 
 	recalculate_root_clocks();
-- 
1.6.0.4
