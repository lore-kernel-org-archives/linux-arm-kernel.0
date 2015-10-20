From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Oct 2015 23:54:56 +0800
Subject: [RFC PATCH] net:hns: hns_aev2_toggle_ring_irq() can be static
In-Reply-To: <1445353278-130498-2-git-send-email-salil.mehta@huawei.com>
References: <201510202306.WYUMdngA%fengguang.wu@intel.com>
Message-ID: <20151020155456.GA96665@xian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hns_ae_adapt.c |    2 +-
 hns_enet.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index c3d64ce..bf277c7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -337,7 +337,7 @@ void hns_ae_toggle_ring_irq(struct hnae_ring *ring, u32 mask)
 	hns_rcb_int_ctrl_hw(ring->q, flag, mask);
 }
 
-void hns_aev2_toggle_ring_irq(struct hnae_ring *ring, u32 mask)
+static void hns_aev2_toggle_ring_irq(struct hnae_ring *ring, u32 mask)
 {
 	u32 flag;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 7d996a4..33061f1 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -995,7 +995,7 @@ static void hns_nic_ring_close(struct net_device *netdev, int idx)
 	napi_disable(&priv->ring_data[idx].napi);
 }
 
-void hns_set_irq_affinity(struct hns_nic_priv *priv)
+static void hns_set_irq_affinity(struct hns_nic_priv *priv)
 {
 	struct hnae_handle *h = priv->ae_handle;
 	struct hns_nic_ring_data *rd;
