From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 30 Mar 2016 21:25:10 +0800
Subject: [PATCH] net: mvneta: explicitly disable BM on 64bit platform
Message-ID: <1459344310-626-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvneta BM can't work on 64bit platform, as the BM hardware expects
buf virtual address to be placed in the first four bytes of mapped
buffer, but obviously the virtual address on 64bit platform can't be
stored in 4 bytes. So we have to explicitly disable BM on 64bit
platform.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index b5c6d42..53d6572 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -42,7 +42,7 @@ config MVMDIO
 
 config MVNETA_BM_ENABLE
 	tristate "Marvell Armada 38x/XP network interface BM support"
-	depends on MVNETA
+	depends on MVNETA && !64BIT
 	---help---
 	  This driver supports auxiliary block of the network
 	  interface units in the Marvell ARMADA XP and ARMADA 38x SoC
-- 
2.8.0.rc3
