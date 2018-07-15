From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 15 Jul 2018 14:31:41 +0200
Subject: [PATCH v4 1/5] clk: actions: Add REGMAP as dependency
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Message-ID: <20180715123145.16975-2-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add REGMAP as dependency to avoid undefined reference to regmap symbol

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
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
2.18.0
