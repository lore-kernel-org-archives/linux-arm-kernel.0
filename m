From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:45:51 +0900
Subject: [PATCH] clk: shmobile: fix sparse NULL pointer warning
In-Reply-To: <cover.1421376276.git.horms+renesas@verge.net.au>
References: <cover.1421376276.git.horms+renesas@verge.net.au>
Message-ID: <16bd794f9432b556ec797cbf16c5e575a18f7030.1421376276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/clk/shmobile/clk-sh73a0.c:57:17: warning:
 Using plain integer as NULL pointer

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clk/shmobile/clk-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-sh73a0.c b/drivers/clk/shmobile/clk-sh73a0.c
index 8574a6d..cd529cf 100644
--- a/drivers/clk/shmobile/clk-sh73a0.c
+++ b/drivers/clk/shmobile/clk-sh73a0.c
@@ -54,7 +54,7 @@ static struct div4_clk div4_clks[] = {
 	{ "m2", "pll1", CPG_FRQCRA,  0 },
 	{ "zx", "pll1", CPG_FRQCRB, 12 },
 	{ "hp", "pll1", CPG_FRQCRB,  4 },
-	{ NULL, 0, 0, 0 },
+	{ NULL, NULL, 0, 0 },
 };
 
 static const struct clk_div_table div4_div_table[] = {
-- 
2.1.4
