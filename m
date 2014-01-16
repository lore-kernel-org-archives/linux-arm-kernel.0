From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 16 Jan 2014 13:44:19 +0100
Subject: [PATCH 07/11] iommu/arm-smmu: Set MAX_MASTER_STREAMIDS to
 MAX_PHANDLE_ARGS
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1389876263-25759-8-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT parsing code that determines stream IDs uses
of_parse_phandle_with_args and thus MAX_MASTER_STREAMIDS
is always bound by MAX_PHANDLE_ARGS.

Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a4e0c93..68bbe45 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -54,7 +54,7 @@
 #define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 1)
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		8
+#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
 
 /* Maximum stream ID */
 #define ARM_SMMU_MAX_STREAMID		(SZ_64K - 1)
-- 
1.7.9.5
