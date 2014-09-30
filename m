From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 30 Sep 2014 16:28:14 +0200
Subject: [PATCH v6 08/10] net: pxa168_eth: allow to compile the pxa168_eth
 driver for tests
In-Reply-To: <1412087296-18475-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1412087296-18475-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1412087296-18475-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dependency to COMPILE_TEST so that the driver can be compiled for
test purposes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/marvell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index 48b9466d1781..bed8fbb3edc5 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -64,7 +64,7 @@ config MVPP2
 
 config PXA168_ETH
 	tristate "Marvell pxa168 ethernet support"
-	depends on CPU_PXA168 || ARCH_BERLIN
+	depends on CPU_PXA168 || ARCH_BERLIN || COMPILE_TEST
 	select PHYLIB
 	---help---
 	  This driver supports the pxa168 Ethernet ports.
-- 
1.9.1
