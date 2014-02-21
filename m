From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 17:16:28 +0000
Subject: [PATCH 1/5] iommu/arm-smmu: set MAX_MASTER_STREAMIDS to
 MAX_PHANDLE_ARGS
In-Reply-To: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
Message-ID: <1393002992-24561-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas Herrmann <andreas.herrmann@calxeda.com>

The DT parsing code that determines stream IDs uses
of_parse_phandle_with_args and thus MAX_MASTER_STREAMIDS
is always bound by MAX_PHANDLE_ARGS.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d9ab39af29f..a3ce60887efa 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,7 +48,7 @@
 #include <asm/pgalloc.h>
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		8
+#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
-- 
1.8.2.2
