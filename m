From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 21 Jan 2018 14:15:41 +0100
Subject: [PATCH] net: gemini: Depend on HAS_IOMEM
Message-ID: <20180121131541.4337-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zeroday builder notices that since Usermode Linux does not
have IO memory, the build fails for them when selecting everything
it can enable.

As the driver is clearly using memory-mapped registers to access
the network adapter, we add depends on HAS_IOMEM to solve this
problem.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cortina/Kconfig b/drivers/net/ethernet/cortina/Kconfig
index 0df743ea51f1..89bc4579724d 100644
--- a/drivers/net/ethernet/cortina/Kconfig
+++ b/drivers/net/ethernet/cortina/Kconfig
@@ -14,6 +14,7 @@ if NET_VENDOR_CORTINA
 config GEMINI_ETHERNET
 	tristate "Gemini Gigabit Ethernet support"
 	depends on OF
+	depends on HAS_IOMEM
 	select PHYLIB
 	select CRC32
 	---help---
-- 
2.14.3
