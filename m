From: huangdaode@hisilicon.com (huangdaode)
Date: Thu, 24 Sep 2015 17:54:09 +0800
Subject: [PATCH net-next] net: Fix Hisilicon Network Subsystem Support
 Compilation
Message-ID: <1443088449-147241-1-git-send-email-huangdaode@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compilation error with arm allmodconfig, this error
generated due to unavailability of readq on 32-bit platform which was
found during net-next daily compilation

Signed-off-by: huangdaode <huangdaode@hisilicon.com>
Singed-off-by: yankejian <yankejian@huawei.com>
---
 drivers/net/ethernet/hisilicon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 165b5a8..04d5f8f 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -41,6 +41,7 @@ config HNS_MDIO
 
 config HNS
 	tristate "Hisilicon Network Subsystem Support (Framework)"
+	depends on ARM64
 	---help---
 	  This selects the framework support for Hisilicon Network Subsystem. It
 	  is needed by any driver which provides HNS acceleration engine or make
@@ -50,6 +51,7 @@ config HNS_DSAF
 	tristate "Hisilicon HNS DSAF device Support"
 	select HNS
 	select HNS_MDIO
+	depends on ARM64
 	---help---
 	  This selects the DSAF (Distributed System Area Frabric) network
 	  acceleration engine support. The engine is used in Hisilicon hip05,
@@ -59,6 +61,7 @@ config HNS_ENET
 	tristate "Hisilicon HNS Ethernet Device Support"
 	select PHYLIB
 	select HNS
+	depends on ARM64
 	---help---
 	  This selects the general ethernet driver for HNS.  This module make
 	  use of any HNS AE driver, such as HNS_DSAF
-- 
1.9.1
