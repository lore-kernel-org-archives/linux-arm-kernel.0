From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 10:58:52 +0530
Subject: [PATCH 1/2] clk: imx: constify clk_div_table
In-Reply-To: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503898133-10862-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_div_table are not supposed to change at runtime. All functions
working with clk_div_table provided by <linux/clk-provider.h> work
with const clk_div_table. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/imx/clk-imx6sl.c | 6 +++---
 drivers/clk/imx/clk-imx6sx.c | 6 +++---
 drivers/clk/imx/clk-imx6ul.c | 6 +++---
 drivers/clk/imx/clk-imx7d.c  | 4 ++--
 drivers/clk/imx/clk-vf610.c  | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 5fd4dda..9642cdf 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -71,7 +71,7 @@
 static const char *pll6_bypass_sels[]	= { "pll6", "pll6_bypass_src", };
 static const char *pll7_bypass_sels[]	= { "pll7", "pll7_bypass_src", };
 
-static struct clk_div_table clk_enet_ref_table[] = {
+static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
 	{ .val = 2, .div = 5, },
@@ -79,14 +79,14 @@
 	{ }
 };
 
-static struct clk_div_table post_div_table[] = {
+static const struct clk_div_table post_div_table[] = {
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 0, .div = 4, },
 	{ }
 };
 
-static struct clk_div_table video_div_table[] = {
+static const struct clk_div_table video_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 1, },
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index b5c96de..e6d389e 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -105,7 +105,7 @@
 	IMX6SX_CLK_EPIT2,
 };
 
-static struct clk_div_table clk_enet_ref_table[] = {
+static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
 	{ .val = 2, .div = 5, },
@@ -113,14 +113,14 @@
 	{ }
 };
 
-static struct clk_div_table post_div_table[] = {
+static const struct clk_div_table post_div_table[] = {
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 0, .div = 4, },
 	{ }
 };
 
-static struct clk_div_table video_div_table[] = {
+static const struct clk_div_table video_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 1, },
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index b4e0dff..5e8c18a 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -78,7 +78,7 @@
 	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
 };
 
-static struct clk_div_table clk_enet_ref_table[] = {
+static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
 	{ .val = 2, .div = 5, },
@@ -86,14 +86,14 @@
 	{ }
 };
 
-static struct clk_div_table post_div_table[] = {
+static const struct clk_div_table post_div_table[] = {
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 0, .div = 4, },
 	{ }
 };
 
-static struct clk_div_table video_div_table[] = {
+static const struct clk_div_table video_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 1, },
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 3da1218..2305699 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -27,7 +27,7 @@
 static u32 share_count_sai3;
 static u32 share_count_nand;
 
-static struct clk_div_table test_div_table[] = {
+static const struct clk_div_table test_div_table[] = {
 	{ .val = 3, .div = 1, },
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
@@ -35,7 +35,7 @@
 	{ }
 };
 
-static struct clk_div_table post_div_table[] = {
+static const struct clk_div_table post_div_table[] = {
 	{ .val = 3, .div = 4, },
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 59b1863..6dae543 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -102,7 +102,7 @@
 static const char *ftm_fix_sels[]	= { "sxosc", "ipg_bus", };
 
 
-static struct clk_div_table pll4_audio_div_table[] = {
+static const struct clk_div_table pll4_audio_div_table[] = {
 	{ .val = 0, .div = 1 },
 	{ .val = 1, .div = 2 },
 	{ .val = 2, .div = 6 },
-- 
1.9.1
