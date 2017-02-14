From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2017 22:29:45 +0100
Subject: [PATCH] clk: sunxi: ccu-sun5i needs nkmp
Message-ID: <20170214213005.2848151-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A randconfig build ran into this rare link error:

drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_nkmp_ops'
drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.7+0x4): undefined reference to `ccu_nkmp_ops'

This adds the missing 'select'.

Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/sunxi-ng/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 695bbf9ef428..b6e2aa5d0246 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -70,6 +70,7 @@ config SUN5I_CCU
 	select SUNXI_CCU_MULT
 	select SUNXI_CCU_NK
 	select SUNXI_CCU_NKM
+	select SUNXI_CCU_NKMP
 	select SUNXI_CCU_NM
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
-- 
2.9.0
