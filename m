From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 23 Aug 2016 15:06:05 +0000
Subject: [PATCH -next] net: phy: xgmiitorgmii: Fix non static symbol warning
Message-ID: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/net/phy/xilinx_gmii2rgmii.c:61:5: warning:
 symbol 'xgmiitorgmii_probe' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index e7a20ec..2e408b8 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -58,7 +58,7 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-int xgmiitorgmii_probe(struct mdio_device *mdiodev)
+static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct device_node *np = dev->of_node, *phy_node;
