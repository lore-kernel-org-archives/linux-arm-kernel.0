From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 17 Dec 2013 17:26:37 +0800
Subject: [PATCH 1/4] ARM: tegra: moving tegra_bct_strapping to tegra-soc.h for
 global visibility
In-Reply-To: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
Message-ID: <1387272400-4689-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the tegra_btc_strapping variable to the tegra-soc.h for
the global visibility that the other Tegra device driver can access it.
It also a preparation that we can move out the Tegra20 EMC driver from
mach-tegra to the drivers folder.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/fuse.h           | 2 --
 arch/arm/mach-tegra/tegra20_speedo.c | 1 +
 arch/arm/mach-tegra/tegra2_emc.c     | 2 +-
 include/linux/tegra-soc.h            | 2 ++
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index c01d04785d67..44945c8b5d17 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -50,8 +50,6 @@ extern int tegra_cpu_speedo_id;		/* only exist in Tegra30 and later */
 extern int tegra_soc_speedo_id;
 extern enum tegra_revision tegra_revision;
 
-extern int tegra_bct_strapping;
-
 unsigned long long tegra_chip_uid(void);
 void tegra_init_fuse(void);
 bool tegra_spare_fuse(int bit);
diff --git a/arch/arm/mach-tegra/tegra20_speedo.c b/arch/arm/mach-tegra/tegra20_speedo.c
index fa6eb570623f..3b1bb5360a92 100644
--- a/arch/arm/mach-tegra/tegra20_speedo.c
+++ b/arch/arm/mach-tegra/tegra20_speedo.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/tegra-soc.h>
 
 #include "fuse.h"
 
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 3ae4a7f1a2fb..26e4edbd8a6a 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -24,9 +24,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/tegra_emc.h>
+#include <linux/tegra-soc.h>
 
 #include "tegra2_emc.h"
-#include "fuse.h"
 
 #ifdef CONFIG_TEGRA_EMC_SCALING_ENABLE
 static bool emc_enable = true;
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 95f611d78f3a..2e02a9a033c5 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -17,6 +17,8 @@
 #ifndef __LINUX_TEGRA_SOC_H_
 #define __LINUX_TEGRA_SOC_H_
 
+extern int tegra_bct_strapping;
+
 u32 tegra_read_chipid(void);
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
-- 
1.8.5
