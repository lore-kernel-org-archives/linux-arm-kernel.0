From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Jan 2015 20:48:54 +0000
Subject: [RFC PATCH 2/5] arm64: implement generic IOMMU configuration
In-Reply-To: <cover.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Message-ID: <e3083e709ad118f2ddca93eabb6ab8f0693a10b8.1421086706.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary call to of_iommu_init.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b809911..8304141 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
+#include <linux/of_iommu.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/efi.h>
@@ -424,6 +425,7 @@ void __init setup_arch(char **cmdline_p)
 
 static int __init arm64_device_init(void)
 {
+	of_iommu_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	return 0;
 }
-- 
1.9.1
