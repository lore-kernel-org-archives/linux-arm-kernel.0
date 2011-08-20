From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Sat, 20 Aug 2011 10:27:21 +0900
Subject: [PATCH] ARM: S5P: Remove duplicate kdiv calculation
Message-ID: <1313803641-32169-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/plat-s5p/include/plat/pll.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
index bf28fad..ebc142c 100644
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -72,7 +72,6 @@ static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
 	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
-	kdiv = pll_con1 & PLL46XX_KDIV_MASK;
 
 	if (pll_type == pll_4650c)
 		kdiv = pll_con1 & PLL4650C_KDIV_MASK;
-- 
1.7.0
