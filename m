From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 19 Jan 2018 15:19:06 +0100
Subject: [PATCH] clk: sunxi-ng: remove select on obsolete SUNXI_CCU_X kconfig
 name
Message-ID: <20180119141906.7339-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following symbols:
SUNXI_CCU_DIV
SUNXI_CCU_MULT
SUNXI_CCU_NK
SUNXI_CCU_NKM
SUNXI_CCU_NM
SUNXI_CCU_MP
SUNXI_CCU_PHASE
were removed with the commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a library")
So selecting them is useless.

Fixes: c84f5683f6e9 ("clk: sunxi-ng: Add sun4i/sun7i CCU driver")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/clk/sunxi-ng/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 6427d0ebe2de..33168f94ee39 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -13,13 +13,6 @@ config SUN50I_A64_CCU
 
 config SUN4I_A10_CCU
 	bool "Support for the Allwinner A10/A20 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN4I
 	default MACH_SUN7I
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
-- 
2.13.6
