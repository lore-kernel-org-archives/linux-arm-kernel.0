From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 22:56:39 +0100
Subject: [PATCH 2/3] mfd: Make AB8500_CORE select POWER_SUPPLY to fix build
 error
In-Reply-To: <1363298204-8014-1-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
Message-ID: <1363298204-8014-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

This patch fixes below build error when CONFIG_POWER_SUPPLY is not set.

drivers/built-in.o: In function `ab8500_power_off':
drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please apply to MFD tree for 3.9

 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 671f5b1..c346941 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -858,6 +858,7 @@ config EZX_PCAP
 config AB8500_CORE
 	bool "ST-Ericsson AB8500 Mixed Signal Power Management chip"
 	depends on GENERIC_HARDIRQS && ABX500_CORE && MFD_DB8500_PRCMU
+	select POWER_SUPPLY
 	select MFD_CORE
 	select IRQ_DOMAIN
 	help
-- 
1.8.1.2
