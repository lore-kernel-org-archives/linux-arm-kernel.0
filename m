From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 15:55:08 -0600
Subject: [PATCH] ARM: tegra: move tegra-ahb.h out of arch/arm/mach-tegra/
Message-ID: <1348091708-6622-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

We wish to empty arch/arm/mach-tegra/include/mach/ as much as possible
to enable single zImage. Move tegra-ahb.h to a more central location
(suggested by Arnd, OK'd by Greg KH), and actually make tegra-ahb.c
include the header to ensure client and provider agree on the prototype.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/amba/tegra-ahb.c                           |    1 +
 drivers/iommu/tegra-smmu.c                         |    2 +-
 .../include/mach => include/linux}/tegra-ahb.h     |    6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)
 rename {arch/arm/mach-tegra/include/mach => include/linux}/tegra-ahb.h (86%)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 0b6f0b2..bd5de08 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/tegra-ahb.h>
 
 #define DRV_NAME "tegra-ahb"
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0b4d62e..ac57b2f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -34,12 +34,12 @@
 #include <linux/of_iommu.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/tegra-ahb.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 
 #include <mach/iomap.h>
-#include <mach/tegra-ahb.h>
 
 enum smmu_hwgrp {
 	HWGRP_AFI,
diff --git a/arch/arm/mach-tegra/include/mach/tegra-ahb.h b/include/linux/tegra-ahb.h
similarity index 86%
rename from arch/arm/mach-tegra/include/mach/tegra-ahb.h
rename to include/linux/tegra-ahb.h
index e0f8c84..f1cd075 100644
--- a/arch/arm/mach-tegra/include/mach/tegra-ahb.h
+++ b/include/linux/tegra-ahb.h
@@ -11,9 +11,9 @@
  * more details.
  */
 
-#ifndef __MACH_TEGRA_AHB_H__
-#define __MACH_TEGRA_AHB_H__
+#ifndef __LINUX_AHB_H__
+#define __LINUX_AHB_H__
 
 extern int tegra_ahb_enable_smmu(struct device_node *ahb);
 
-#endif	/* __MACH_TEGRA_AHB_H__ */
+#endif	/* __LINUX_AHB_H__ */
-- 
1.7.0.4
