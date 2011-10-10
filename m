From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 10 Oct 2011 23:55:51 +0200
Subject: [PATCH] iommu/core: fix build issue
Message-ID: <mailman.178.1318284091.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix this:

drivers/iommu/iommu.c: In function 'iommu_commit':
drivers/iommu/iommu.c:291: error: 'iommu_ops' undeclared (first use in
this function)

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 909b0d2..a5131f1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -288,7 +288,7 @@ EXPORT_SYMBOL_GPL(iommu_unmap);

 void iommu_commit(struct iommu_domain *domain)
 {
-	if (iommu_ops->commit)
-		iommu_ops->commit(domain);
+	if (domain->ops->commit)
+		domain->ops->commit(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_commit);
-- 
1.7.4.1
