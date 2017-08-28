From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 10:58:53 +0530
Subject: [PATCH 2/2] clk: zte: constify clk_div_table
In-Reply-To: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503898133-10862-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_div_table are not supposed to change at runtime. All functions
working with clk_div_table provided by <linux/clk-provider.h> work
with const clk_div_table. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/zte/clk-zx296718.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index 27f853d..354dd50 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -451,7 +451,7 @@
 	FFACTOR(0, "emmc_mux_div2",	"emmc_mux", 1, 2, CLK_SET_RATE_PARENT),
 };
 
-static struct clk_div_table noc_div_table[] = {
+static const struct clk_div_table noc_div_table[] = {
 	{ .val = 1, .div = 2, },
 	{ .val = 3, .div = 4, },
 };
@@ -644,7 +644,7 @@ static int __init top_clocks_init(struct device_node *np)
 	return 0;
 }
 
-static struct clk_div_table common_even_div_table[] = {
+static const struct clk_div_table common_even_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 3, .div = 4, },
@@ -656,7 +656,7 @@ static int __init top_clocks_init(struct device_node *np)
 	{ .val = 15, .div = 16, },
 };
 
-static struct clk_div_table common_div_table[] = {
+static const struct clk_div_table common_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 3, },
-- 
1.9.1
