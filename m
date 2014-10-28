From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 12:01:40 +0100
Subject: [PATCHv2 2/6] net: fec: declare bufdesc_ex flag as bool
In-Reply-To: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1414494104-27943-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fep->bufdesc_ex is used as boolean flag; thus declare it as such.
Also remove an unnecessary initialization to 0.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec.h      |    2 +-
 drivers/net/ethernet/freescale/fec_main.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1e65917..2634de2 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -451,7 +451,7 @@ struct fec_enet_private {
 	int	speed;
 	struct	completion mdio_done;
 	int	irq[FEC_IRQ_NUM];
-	int	bufdesc_ex;
+	bool	bufdesc_ex;
 	int	pause_flag;
 
 	struct	napi_struct napi;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index decea57..f7d344f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3209,8 +3209,6 @@ fec_probe(struct platform_device *pdev)
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
 
-	fep->bufdesc_ex = 0;
-
 	platform_set_drvdata(pdev, ndev);
 
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
@@ -3268,7 +3266,7 @@ fec_probe(struct platform_device *pdev)
 		pdev->id_entry->driver_data & FEC_QUIRK_HAS_BUFDESC_EX;
 	if (IS_ERR(fep->clk_ptp)) {
 		fep->clk_ptp = NULL;
-		fep->bufdesc_ex = 0;
+		fep->bufdesc_ex = false;
 	}
 
 	ret = fec_enet_clk_enable(ndev, true);
-- 
1.7.10.4
