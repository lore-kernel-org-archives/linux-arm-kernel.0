From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Feb 2015 19:37:44 -0800
Subject: [PATCH] clk: qcom: Fix ipq806x LCC frequency tables
Message-ID: <1425008264-18875-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These frequency tables list the wrong rates. Either they don't
have the correct frequency at all, or they're specified in kHz
instead of Hz. Fix it.

Fixes: c99e515a92e9 "clk: qcom: Add IPQ806X LPASS clock controller (LCC) driver"
Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/lcc-ipq806x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index fb276522173a..b23f8069fac1 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -294,14 +294,14 @@ static struct clk_regmap_mux pcm_clk = {
 };
 
 static struct freq_tbl clk_tbl_aif_osr[] = {
-	{  22050, P_PLL4, 1, 147, 20480 },
-	{  32000, P_PLL4, 1,   1,    96 },
-	{  44100, P_PLL4, 1, 147, 10240 },
-	{  48000, P_PLL4, 1,   1,    64 },
-	{  88200, P_PLL4, 1, 147,  5120 },
-	{  96000, P_PLL4, 1,   1,    32 },
-	{ 176400, P_PLL4, 1, 147,  2560 },
-	{ 192000, P_PLL4, 1,   1,    16 },
+	{  2822400, P_PLL4, 1, 147, 20480 },
+	{  4096000, P_PLL4, 1,   1,    96 },
+	{  5644800, P_PLL4, 1, 147, 10240 },
+	{  6144000, P_PLL4, 1,   1,    64 },
+	{ 11289600, P_PLL4, 1, 147,  5120 },
+	{ 12288000, P_PLL4, 1,   1,    32 },
+	{ 22579200, P_PLL4, 1, 147,  2560 },
+	{ 24576000, P_PLL4, 1,   1,    16 },
 	{ },
 };
 
@@ -360,7 +360,7 @@ static struct clk_branch spdif_clk = {
 };
 
 static struct freq_tbl clk_tbl_ahbix[] = {
-	{ 131072, P_PLL4, 1, 1, 3 },
+	{ 131072000, P_PLL4, 1, 1, 3 },
 	{ },
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
