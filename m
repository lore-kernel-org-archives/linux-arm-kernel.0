From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 11 Apr 2016 11:19:06 +0300
Subject: [PATCH 15/30] clk: ti: remove un-used definitions from public
 clk_hw_omap struct
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Message-ID: <1460362761-4842-16-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clksel support has been deprecated a while back, so remove these from
the struct also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 include/linux/clk/ti.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 210e946..1451291 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -127,8 +127,6 @@ struct clk_hw_omap_ops {
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
- * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
- * @clksel: for clksel clks, pointer to struct clksel for this clock
  * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
  * @clkdm_name: clockdomain name that this clock is contained in
  * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
@@ -143,8 +141,6 @@ struct clk_hw_omap {
 	u8			enable_bit;
 	u8			flags;
 	void __iomem		*clksel_reg;
-	u32			clksel_mask;
-	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
-- 
1.7.9.5
