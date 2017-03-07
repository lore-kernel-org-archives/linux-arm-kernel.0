From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  7 Mar 2017 16:53:20 +0100
Subject: [PATCHv3 net-next 22/22] net: mvpp2: finally add the PPv2.2
 compatible string
In-Reply-To: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1488902000-2658-23-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvpp2 driver has been modified to accommodate the support
for PPv2.2, we can finally advertise this support by adding the
appropriate compatible string.

At the same time, we update the Kconfig description of the MVPP2 driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/Kconfig | 4 ++--
 drivers/net/ethernet/marvell/mvpp2.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index d2555e8b..da6fb82 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -82,13 +82,13 @@ config MVNETA_BM
 	  that all dependencies are met.
 
 config MVPP2
-	tristate "Marvell Armada 375 network interface support"
+	tristate "Marvell Armada 375/7K/8K network interface support"
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on HAS_DMA
 	select MVMDIO
 	---help---
 	  This driver supports the network interface units in the
-	  Marvell ARMADA 375 SoC.
+	  Marvell ARMADA 375, 7K and 8K SoCs.
 
 config PXA168_ETH
 	tristate "Marvell pxa168 ethernet support"
diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 92c47f3..af5bfa1 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7037,6 +7037,10 @@ static const struct of_device_id mvpp2_match[] = {
 		.compatible = "marvell,armada-375-pp2",
 		.data = (void *)MVPP21,
 	},
+	{
+		.compatible = "marvell,armada-7k-pp22",
+		.data = (void *)MVPP22,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvpp2_match);
-- 
2.7.4
