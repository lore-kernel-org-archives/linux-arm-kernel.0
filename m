From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 May 2015 17:09:35 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: Make force_stage module param read-only
 in sysfs
In-Reply-To: <1432742975-24801-1-git-send-email-will.deacon@arm.com>
References: <1432742975-24801-1-git-send-email-will.deacon@arm.com>
Message-ID: <1432742975-24801-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing force_stage dynamically isn't supported by the driver and it
also doesn't make a whole lot of sense to change it once the SMMU is up
and running.

This patch makes the sysfs entry for the parameter read-only.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e2a788eea5ed..dce041b1c139 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -246,7 +246,7 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
-module_param_named(force_stage, force_stage, int, S_IRUGO | S_IWUSR);
+module_param_named(force_stage, force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed@a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
 
-- 
2.1.4
