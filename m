From: sravanhome@gmail.com (Saravanan Sekar)
Date: Thu, 19 Jul 2018 11:06:45 +0200
Subject: [PATCH v7 1/5] clk: actions: Add missing REGMAP_MMIO dependency
In-Reply-To: <20180719090649.12460-1-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
Message-ID: <20180719090649.12460-2-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add REGMAP_MMIO as dependency to avoid undefined
reference to regmap symbols.

Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 8854adb37847..39491154abbf 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -1,6 +1,7 @@
 config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
+	select REGMAP_MMIO
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
-- 
2.14.4
