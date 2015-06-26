From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:32:59 +0800
Subject: [PATCH 3/8] iommu/arm-smmu: fix the values of ARM64_TCR_IRGN0_SHIFT
 and ARM64_TCR_ORGN0_SHIFT
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1435307584-9812-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In context descriptor, the offset of IR0 is 8, the offset of OR0 is 10.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2a5f810..43120ad 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -269,10 +269,10 @@
 #define ARM64_TCR_TG0_SHIFT		14
 #define ARM64_TCR_TG0_MASK		0x3UL
 #define CTXDESC_CD_0_TCR_IRGN0_SHIFT	8
-#define ARM64_TCR_IRGN0_SHIFT		24
+#define ARM64_TCR_IRGN0_SHIFT		8
 #define ARM64_TCR_IRGN0_MASK		0x3UL
 #define CTXDESC_CD_0_TCR_ORGN0_SHIFT	10
-#define ARM64_TCR_ORGN0_SHIFT		26
+#define ARM64_TCR_ORGN0_SHIFT		10
 #define ARM64_TCR_ORGN0_MASK		0x3UL
 #define CTXDESC_CD_0_TCR_SH0_SHIFT	12
 #define ARM64_TCR_SH0_SHIFT		12
--
1.8.0
