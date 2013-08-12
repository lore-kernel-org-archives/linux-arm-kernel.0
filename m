From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 12 Aug 2013 10:42:14 -0500
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
Message-ID: <1376322134-17408-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk".

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Mike Turquette <mturquette@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/socfpga/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 5bb848c..81dd31a 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -49,7 +49,7 @@
 #define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
 #define SOCFPGA_NAND_CLK		"nand_clk"
 #define SOCFPGA_NAND_X_CLK		"nand_x_clk"
-#define SOCFPGA_MMC_CLK			"mmc_clk"
+#define SOCFPGA_MMC_CLK			"sdmmc_clk"
 #define SOCFPGA_DB_CLK			"gpio_db_clk"
 
 #define div_mask(width)	((1 << (width)) - 1)
-- 
1.7.9.5
