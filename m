From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 Sep 2014 15:31:54 +0100
Subject: [RFC PATCH v3 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <1410539695-29128-2-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-2-git-send-email-will.deacon@arm.com>
Message-ID: <541AECDA.1000805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

After some fun times wondering why on Earth of_iommu_init was trying to 
instantiate a GIC, I think we may need one of these as part of this 
patch, too ;)

Robin.

--->8---

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8656b63..1927691 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,9 @@
  #include <linux/of_iommu.h>
  #include <linux/slab.h>

+static const struct of_device_id __iommu_of_table_sentinel
+       __used __section(__iommu_of_table_end);
+
  /**
   * of_get_dma_window - Parse *dma-window property and returns 0 if found.
   *
