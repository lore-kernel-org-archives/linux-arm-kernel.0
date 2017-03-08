From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  7 Mar 2017 17:08:45 -0800
Subject: [PATCH v4 net-next 6/6] MAINTAINERS: Add entry for APM X-Gene SoC
 Ethernet (v2) driver
In-Reply-To: <1488935325-13603-1-git-send-email-isubramanian@apm.com>
References: <1488935325-13603-1-git-send-email-isubramanian@apm.com>
Message-ID: <1488935325-13603-7-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for the ethernet driver for
the on-chip ethernet interface which uses a linked list of DMA
descriptor architecture (v2) for APM X-Gene SoCs.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 MAINTAINERS                              | 6 ++++++
 drivers/net/ethernet/apm/xgene-v2/mac.c  | 2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5f..e04d3a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -902,6 +902,12 @@ F:	drivers/net/phy/mdio-xgene.c
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 
+APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
+M:	Iyappan Subramanian <isubramanian@apm.com>
+M:	Keyur Chudgar <kchudgar@apm.com>
+S:	Supported
+F:	drivers/net/ethernet/apm/xgene-v2/
+
 APPLIED MICRO (APM) X-GENE SOC PMU
 M:	Tai Nguyen <ttnguyen@apm.com>
 S:	Supported
diff --git a/drivers/net/ethernet/apm/xgene-v2/mac.c b/drivers/net/ethernet/apm/xgene-v2/mac.c
index 9c3d32d..c3189de 100644
--- a/drivers/net/ethernet/apm/xgene-v2/mac.c
+++ b/drivers/net/ethernet/apm/xgene-v2/mac.c
@@ -77,8 +77,8 @@ static void xge_mac_set_speed(struct xge_pdata *pdata)
 
 void xge_mac_set_station_addr(struct xge_pdata *pdata)
 {
-	u32 addr0, addr1;
 	u8 *dev_addr = pdata->ndev->dev_addr;
+	u32 addr0, addr1;
 
 	addr0 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
 		(dev_addr[1] << 8) | dev_addr[0];
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index b16ef43..ae76977 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -27,9 +27,9 @@ static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
 	struct net_device *ndev;
-	struct device *dev;
-	struct resource *res;
 	int phy_mode, ret = 0;
+	struct resource *res;
+	struct device *dev;
 
 	pdev = pdata->pdev;
 	dev = &pdev->dev;
@@ -190,9 +190,9 @@ static netdev_tx_t xge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xge_pdata *pdata = netdev_priv(ndev);
 	struct device *dev = &pdata->pdev->dev;
-	static dma_addr_t dma_addr;
 	struct xge_desc_ring *tx_ring;
 	struct xge_raw_desc *raw_desc;
+	static dma_addr_t dma_addr;
 	u64 addr_lo, addr_hi;
 	void *pkt_buf;
 	u8 tail;
@@ -526,7 +526,7 @@ static int xge_close(struct net_device *ndev)
 static int xge_napi(struct napi_struct *napi, const int budget)
 {
 	struct net_device *ndev = napi->dev;
-	struct xge_pdata *pdata = netdev_priv(ndev);
+	struct xge_pdata *pdata;
 	int processed;
 
 	pdata = netdev_priv(ndev);
-- 
1.9.1
