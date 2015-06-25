From: b18965@freescale.com (Alison Wang)
Date: Thu, 25 Jun 2015 11:34:38 +0800
Subject: [PATCH] net/fsl: remove dependency FSL_SOC for Gianfar
Message-ID: <1435203278-40383-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_GIANFAR is not depended on FSL_SOC, it
can be built on non-PPC platforms.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
 drivers/net/ethernet/freescale/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index b8de87b..ff76d4e 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -83,12 +83,12 @@ config UGETH_TX_ON_DEMAND
 
 config GIANFAR
 	tristate "Gianfar Ethernet"
-	depends on FSL_SOC
 	select FSL_PQ_MDIO
 	select PHYLIB
 	select CRC32
 	---help---
 	  This driver supports the Gigabit TSEC on the MPC83xx, MPC85xx,
-	  and MPC86xx family of chips, and the FEC on the 8540.
+	  and MPC86xx family of chips, the eTSEC on LS1021A and the FEC
+	  on the 8540.
 
 endif # NET_VENDOR_FREESCALE
-- 
2.1.0.27.g96db324
