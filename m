From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 14 Mar 2018 08:37:29 -0500
Subject: [PATCH 2/5] dpaa_eth: fix error in dpaa_remove()
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Message-ID: <20180314133732.24068-3-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent changes that make the driver probing compatible with DSA
were not propagated in the dpa_remove() function, breaking the
module unload function. Using the proper device to address the issue.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 159dc2d..128e0a4 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2871,7 +2871,7 @@ static int dpaa_remove(struct platform_device *pdev)
 	struct device *dev;
 	int err;
 
-	dev = &pdev->dev;
+	dev = pdev->dev.parent;
 	net_dev = dev_get_drvdata(dev);
 
 	priv = netdev_priv(net_dev);
-- 
2.1.0
