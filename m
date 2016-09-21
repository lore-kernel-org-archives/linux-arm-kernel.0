From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 17:02:11 -0700
Subject: [PATCH v3 1/5] clk: at91: move slow clock controller clocks to
 sckc.c
In-Reply-To: <20160920205833.19638-2-alexandre.belloni@free-electrons.com>
References: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
 <20160920205833.19638-2-alexandre.belloni@free-electrons.com>
Message-ID: <20160921000211.GH8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Alexandre Belloni wrote:
> Move all clocks related to the slow clock controller to sckc.c. This avoids
> extern definitions and allows to remove sckc.h
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied to clk-next

drivers/clk/at91/sckc.c:146:13:
warning: symbol 'of_at91sam9x5_clk_slow_osc_setup' was not
declared. Should it be static?
drivers/clk/at91/sckc.c:260:13:
warning: symbol 'of_at91sam9x5_clk_slow_rc_osc_setup' was not
declared. Should it be static?
drivers/clk/at91/sckc.c:359:13:
warning: symbol 'of_at91sam9x5_clk_slow_setup' was not declared.
Should it be static?

----8<----
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index f6ed711af738..311956abf4aa 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -143,8 +143,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 	return hw;
 }
 
-void __init of_at91sam9x5_clk_slow_osc_setup(struct device_node *np,
-					     void __iomem *sckcr)
+static void __init
+of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
 {
 	struct clk_hw *hw;
 	const char *parent_name;
@@ -257,8 +257,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 	return hw;
 }
 
-void __init of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np,
-						void __iomem *sckcr)
+static void __init
+of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
 {
 	struct clk_hw *hw;
 	u32 frequency = 0;
@@ -356,8 +356,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	return hw;
 }
 
-void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
-					 void __iomem *sckcr)
+static void __init
+of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
 {
 	struct clk_hw *hw;
 	const char *parent_names[2];

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
