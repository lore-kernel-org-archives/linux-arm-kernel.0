From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:26 +0800
Subject: [PATCH net-next 06/19] net: hns: fix the error info when
 dma_set_mask_and_coherent fail
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-7-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qianqian Xie <xieqianqian@huawei.com>

The error info should be printed as "set mask to 64bit fail!" instead of
"set mask to 32bit fail!" in dma_set_mask_and_coherent().

Signed-off-by: Qianqian Xie <xieqianqian@huawei.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index b978db4..00e529f 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1972,7 +1972,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 	if (!dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		dev_dbg(dev, "set mask to 64bit\n");
 	else
-		dev_err(dev, "set mask to 32bit fail!\n");
+		dev_err(dev, "set mask to 64bit fail!\n");
 
 	/* carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(ndev);
-- 
1.9.1
