From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Feb 2017 15:33:57 +0100
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun5i
Message-ID: <20170202143417.3514875-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a link error when CCU_MULT is not set with the
newly added driver:

drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.17+0x4): undefined reference to `ccu_mult_ops'
drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.5+0x4): undefined reference to `ccu_mult_ops'

Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/sunxi-ng/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 67659091860d..695bbf9ef428 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -67,6 +67,7 @@ config SUN50I_A64_CCU
 config SUN5I_CCU
 	bool "Support for the Allwinner sun5i family CCM"
 	select SUNXI_CCU_DIV
+	select SUNXI_CCU_MULT
 	select SUNXI_CCU_NK
 	select SUNXI_CCU_NKM
 	select SUNXI_CCU_NM
-- 
2.9.0
