From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 23 Mar 2012 08:37:52 +0100
Subject: [PATCH 1/8] clk: add a fixed factor clock
In-Reply-To: <1332164166-6055-2-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
 <1332164166-6055-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332488272.2876.5.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Am Montag, den 19.03.2012, 14:35 +0100 schrieb Sascha Hauer:
> Having fixed factors/dividers in hardware is a common pattern, so
> add a clock doing this. Currently no rate propagation is supported.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

Only a few clk-gateisms remain in clk_register_fixed_factor:

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 7c5e1fc..d99b842 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -64,14 +64,14 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 	struct clk_fixed_factor *fix;
 	struct clk *clk;
 
-	fix = kmalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	fix = kmalloc(sizeof(struct clk_fixed_factor), GFP_KERNEL);
 
 	if (!fix) {
-		pr_err("%s: could not allocate gated clk\n", __func__);
+		pr_err("%s: could not allocate fixed factor clk\n", __func__);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* struct clk_gate assignments */
+	/* struct clk_fixed_factor assignments */
 	fix->mult = mult;
 	fix->div = div;
 
--
1.7.9.1

regards
Philipp
