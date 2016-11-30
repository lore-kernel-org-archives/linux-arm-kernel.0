From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Nov 2016 22:42:50 +0100
Subject: [PATCH v5 net-next 5/7] net: mvneta: Only disable mvneta_bm for
 64-bits
In-Reply-To: <cover.0270f6d2413a709521fe2c8c17fbebea6f2e78d1.1480542157.git-series.gregory.clement@free-electrons.com>
References: <cover.0270f6d2413a709521fe2c8c17fbebea6f2e78d1.1480542157.git-series.gregory.clement@free-electrons.com>
Message-ID: <fcb5593e1e31167639b9c23ed530cb33590e3de9.1480542157.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually only the mvneta_bm support is not 64-bits compatible.
The mvneta code itself can run on 64-bits architecture.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index 66fd9dbb2ca7..2ccea9dd9248 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -44,6 +44,7 @@ config MVMDIO
 config MVNETA_BM_ENABLE
 	tristate "Marvell Armada 38x/XP network interface BM support"
 	depends on MVNETA
+	depends on !64BIT
 	---help---
 	  This driver supports auxiliary block of the network
 	  interface units in the Marvell ARMADA XP and ARMADA 38x SoC
@@ -58,7 +59,6 @@ config MVNETA
 	tristate "Marvell Armada 370/38x/XP network interface support"
 	depends on PLAT_ORION || COMPILE_TEST
 	depends on HAS_DMA
-	depends on !64BIT
 	select MVMDIO
 	select FIXED_PHY
 	---help---
@@ -71,6 +71,7 @@ config MVNETA
 
 config MVNETA_BM
 	tristate
+	depends on !64BIT
 	default y if MVNETA=y && MVNETA_BM_ENABLE!=n
 	default MVNETA_BM_ENABLE
 	select HWBM
-- 
git-series 0.8.10
