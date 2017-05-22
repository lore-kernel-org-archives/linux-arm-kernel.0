From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 May 2017 22:29:40 +0200
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun8i-a83t
Message-ID: <20170522202951.2896280-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a link error when CCU_MULT is not set with the
newly added driver:

drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_mult_ops'
drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.3+0x4): undefined reference to `ccu_mult_ops'

Fixes: 46b492116666 ("clk: sunxi-ng: Add driver for A83T CCU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/sunxi-ng/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index a384c695b388..67acef3d2494 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -121,6 +121,7 @@ config SUN8I_A83T_CCU
 	select SUNXI_CCU_DIV
 	select SUNXI_CCU_GATE
 	select SUNXI_CCU_MP
+	select SUNXI_CCU_MULT
 	select SUNXI_CCU_MUX
 	select SUNXI_CCU_NKMP
 	select SUNXI_CCU_NM
-- 
2.9.0
