From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 15 Jan 2014 11:13:26 +0530
Subject: [PATCH 2/2] clk: ux500: Staticize ux500_twocell_get
In-Reply-To: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
References: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1389764606-14102-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ux500_twocell_get is a local symbol.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_of_clk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index cdeff299de26..7b55ef89baa5 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -29,7 +29,8 @@ static struct clk *prcc_kclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_C
 #define PRCC_KCLK_STORE(clk, base, bit)        \
 	prcc_kclk[(base * PRCC_PERIPHS_PER_CLUSTER) + bit] = clk
 
-struct clk *ux500_twocell_get(struct of_phandle_args *clkspec, void *data)
+static struct clk *ux500_twocell_get(struct of_phandle_args *clkspec,
+				     void *data)
 {
 	struct clk **clk_data = data;
 	unsigned int base, bit;
-- 
1.7.9.5
