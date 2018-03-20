From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 09:56:54 -0700
Subject: [PATCH v8 02/42] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <1521168778-27236-3-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-3-git-send-email-david@lechnology.com>
Message-ID: <152156501473.183971.10164660837276962553@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:18)
> +
> +static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +       struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
> +       struct debugfs_regset32 *regset;
> +       struct dentry *d;
> +
> +       regset = kzalloc(sizeof(regset), GFP_KERNEL);

Should be sizeof(*regset)?

I squashed this in:

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 588a48927436..89d30bf95102 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -882,7 +882,7 @@ static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
 	struct debugfs_regset32 *regset;
 	struct dentry *d;
 
-	regset = kzalloc(sizeof(regset), GFP_KERNEL);
+	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
 	if (!regset)
 		return -ENOMEM;
 
