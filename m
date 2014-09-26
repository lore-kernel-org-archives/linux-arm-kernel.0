From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 26 Sep 2014 16:33:53 +0200
Subject: [PATCH v5 07/10] net: pxa168_eth: allow Berlin SoCs to use the
 pxa168_eth driver
In-Reply-To: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1411742036-23520-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin SoCs have an Ethernet controller compatible with the pxa168.
Allow these SoCs to use the pxa168_eth driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/marvell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index 1b4fc7c639e6..48b9466d1781 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -64,7 +64,7 @@ config MVPP2
 
 config PXA168_ETH
 	tristate "Marvell pxa168 ethernet support"
-	depends on CPU_PXA168
+	depends on CPU_PXA168 || ARCH_BERLIN
 	select PHYLIB
 	---help---
 	  This driver supports the pxa168 Ethernet ports.
-- 
1.9.1
