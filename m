From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 27 Jan 2017 15:14:25 +0900
Subject: [PATCH/RFC v2 2/4] iommu/ipmmu-vmsa: Get rid of disabled device check
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Message-ID: <148549766541.22203.15197831330522408915.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Since of_iommu_configure() now skips over disabled devices
we can simply drop this check in the IPMMU driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |    7 -------
 1 file changed, 7 deletions(-)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-01-27 13:09:36.840607110 +0900
@@ -1051,13 +1051,6 @@ static struct iommu_group *ipmmu_device_
 static int ipmmu_of_xlate_dma(struct device *dev,
 			      struct of_phandle_args *spec)
 {
-	/* If the IPMMU device is disabled in DT then return error
-	 * to make sure the of_iommu code does not install ops
-	 * even though the iommu device is disabled
-	 */
-	if (!of_device_is_available(spec->np))
-		return -ENODEV;
-
 	return 0;
 }
 
