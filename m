From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Nov 2016 16:30:16 +0100
Subject: [PATCH net-next 3/5] net: mvneta: Only disable mvneta_bm for 64-bits
In-Reply-To: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
References: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
Message-ID: <a456f3c95f9faca8e0ab42041742773ec72b304d.1480087510.git-series.gregory.clement@free-electrons.com>
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
