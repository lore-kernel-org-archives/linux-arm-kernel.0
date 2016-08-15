From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 15 Aug 2016 22:51:29 +0000
Subject: [PATCH -next] net: thunderx: Remove unnecessary pci_set_drvdata()
Message-ID: <1471301489-24888-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_xcv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
index 9210d04..67befed 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
@@ -194,7 +194,6 @@ err_release_regions:
 err_disable_device:
 	pci_disable_device(pdev);
 err_kfree:
-	pci_set_drvdata(pdev, NULL);
 	devm_kfree(dev, xcv);
 	xcv = NULL;
 	return err;
@@ -211,7 +210,6 @@ static void xcv_remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
 static struct pci_driver xcv_driver = {
