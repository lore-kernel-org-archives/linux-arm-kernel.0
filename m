From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 30 Apr 2015 09:53:41 +0800
Subject: [PATCH RESEND 2/3] clk: mmp: Fix the wrong factor table for uart PLL
In-Reply-To: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
References: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1430358822-4699-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The suggested value in the mmp2 manual is wrong.
There are only 13 bits for numerator, but some suggested
value has 14 bits.
Fix the factor tabled and remove the unused items.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-mmp2.c    | 4 +---
 drivers/clk/mmp/clk-of-mmp2.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index 5c90a42..09d2832 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -63,10 +63,8 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 };
 
 static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 14634, .den = 2165},	/*14.745MHZ */
+	{.num = 8125, .den = 1536},	/*14.745MHZ */
 	{.num = 3521, .den = 689},	/*19.23MHZ */
-	{.num = 9679, .den = 5728},	/*58.9824MHZ */
-	{.num = 15850, .den = 9451},	/*59.429MHZ */
 };
 
 static const char *uart_parent[] = {"uart_pll", "vctcxo"};
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 2cbc2b4..b7e0b89 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -98,10 +98,8 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 };
 
 static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 14634, .den = 2165},	/*14.745MHZ */
+	{.num = 8125, .den = 1536},	/*14.745MHZ */
 	{.num = 3521, .den = 689},	/*19.23MHZ */
-	{.num = 9679, .den = 5728},	/*58.9824MHZ */
-	{.num = 15850, .den = 9451},	/*59.429MHZ */
 };
 
 static void mmp2_pll_init(struct mmp2_clk_unit *pxa_unit)
-- 
1.8.3.2
