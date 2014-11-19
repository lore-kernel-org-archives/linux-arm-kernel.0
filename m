From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:15:30 +0100
Subject: [PATCH v3 01/19] iommu: fix const qualifier in of_iommu_set_ops
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1416395748-10731-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make of_iommu_set_ops() parameter attribute consistent with
bus_set_iommu().

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/of_iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 7ded21c0ccdf..d03abbb11c34 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -32,9 +32,9 @@ static inline struct iommu_ops *of_iommu_configure(struct device *dev)
 #endif	/* CONFIG_OF_IOMMU */
 
 static inline void of_iommu_set_ops(struct device_node *np,
-				    struct iommu_ops *ops)
+				    const struct iommu_ops *ops)
 {
-	np->data = ops;
+	np->data = (struct iommu_ops *)ops;
 }
 
 static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
-- 
1.9.2
