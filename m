From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri, 26 Nov 2010 20:06:07 +0300
Subject: [PATCH] arm: plat-spear: time: use IS_ERR() instead of NULL check
Message-ID: <1290791168-21255-1-git-send-email-segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() returns ERR_PTR() on error, not NULL.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested at all.

 arch/arm/plat-spear/time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index ab21165..678df18 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -229,13 +229,13 @@ void __init spear_setup_timer(void)
 	}
 
 	gpt_clk = clk_get_sys("gpt0", NULL);
-	if (!gpt_clk) {
+	if (IS_ERR(gpt_clk)) {
 		pr_err("%s:couldn't get clk for gpt\n", __func__);
 		goto err_iomap;
 	}
 
 	pll3_clk = clk_get(NULL, "pll3_48m_clk");
-	if (!pll3_clk) {
+	if (IS_ERR(pll3_clk)) {
 		pr_err("%s:couldn't get PLL3 as parent for gpt\n", __func__);
 		goto err_iomap;
 	}
-- 
1.7.0.4
