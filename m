From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu, 30 Apr 2015 16:09:17 -0700
Subject: [PATCH net-next 1/1] drivers: net: xgene: fix kbuild warnings
Message-ID: <1430435357-20679-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed the following kbuild warnings:
1. unused variable 'of_id'
2. buffer overflow 'ring_cfg' 5 <= 5

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 ++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 735d7c6..1bb3175 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1173,7 +1173,9 @@ static int xgene_enet_probe(struct platform_device *pdev)
 	struct xgene_enet_pdata *pdata;
 	struct device *dev = &pdev->dev;
 	struct xgene_mac_ops *mac_ops;
+#ifdef CONFIG_OF
 	const struct of_device_id *of_id;
+#endif
 	int ret;
 
 	ndev = alloc_etherdev(sizeof(struct xgene_enet_pdata));
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.h b/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
index 19a0427..1c85fc8 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
@@ -83,7 +83,7 @@ struct xgene_enet_desc_ring {
 	u16 irq;
 	char irq_name[IRQ_ID_SIZE];
 	u32 size;
-	u32 state[NUM_RING_CONFIG];
+	u32 state[X2_NUM_RING_CONFIG];
 	void __iomem *cmd_base;
 	void __iomem *cmd;
 	dma_addr_t dma;
-- 
1.9.1
