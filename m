From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  1 Oct 2014 08:00:23 +0200
Subject: [PATCH] net: xilinx: Remove unnecessary ether_setup after
 alloc_etherdev
Message-ID: <d43b465eca3e2a53c930f6e02dc4ac8b3c084693.1412143216.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subbaraya Sundeep Bhatta <subbaraya.sundeep.bhatta@xilinx.com>

Calling ether_setup is redundant since alloc_etherdev calls it.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/ethernet/xilinx/ll_temac_main.c       | 1 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index fda5891835d4..629077050fce 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1012,7 +1012,6 @@ static int temac_of_probe(struct platform_device *op)
 	if (!ndev)
 		return -ENOMEM;

-	ether_setup(ndev);
 	platform_set_drvdata(op, ndev);
 	SET_NETDEV_DEV(ndev, &op->dev);
 	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c8fd94133ecd..4ea2d4e6f1d1 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1485,7 +1485,6 @@ static int axienet_of_probe(struct platform_device *op)
 	if (!ndev)
 		return -ENOMEM;

-	ether_setup(ndev);
 	platform_set_drvdata(op, ndev);

 	SET_NETDEV_DEV(ndev, &op->dev);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/a19b1ab4/attachment-0001.sig>
