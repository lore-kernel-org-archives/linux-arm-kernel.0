From: ulfalizer@gmail.com (Ulf Magnusson)
Date: Mon,  5 Feb 2018 02:21:21 +0100
Subject: [PATCH 09/20] clk: sunxi-ng: Remove SUNXI_CCU_* selects
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Message-ID: <20180205012146.23981-10-ulfalizer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The selected symbols were removed in commit 06e226c7fb23 ("clk:
sunxi-ng: Move all clock types to a library").

Remove the selects from SUN4I_A10_CCU.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
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
2.14.1
