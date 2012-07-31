From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:08 +0800
Subject: [PATCH 1/7] ARM: pxa: support CKENC in clk_enable
Message-ID: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Since more device clock is supported in PXA95x, add CKENC support.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-pxa/clock-pxa3xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
index 2a37a9a..d4e9499 100644
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
@@ -127,8 +127,10 @@ void clk_pxa3xx_cken_enable(struct clk *clk)
 
 	if (clk->cken < 32)
 		CKENA |= mask;
-	else
+	else if (clk->cken < 64)
 		CKENB |= mask;
+	else
+		CKENC |= mask;
 }
 
 void clk_pxa3xx_cken_disable(struct clk *clk)
@@ -137,8 +139,10 @@ void clk_pxa3xx_cken_disable(struct clk *clk)
 
 	if (clk->cken < 32)
 		CKENA &= ~mask;
-	else
+	else if (clk->cken < 64)
 		CKENB &= ~mask;
+	else
+		CKENC &= ~mask;
 }
 
 const struct clkops clk_pxa3xx_cken_ops = {
-- 
1.7.0.4
