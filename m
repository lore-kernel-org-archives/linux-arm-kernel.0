From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 6 Dec 2011 11:25:27 +0100
Subject: [PATCH] iommu/msm: Fix compile error in mach-msm/devices-iommu.c
Message-ID: <20111206102527.GI25178@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just added a patch to my iommu/fixes branch to fix a compile error
with IOMMU enabled. If there is another fix for this already somewhere
please let me know the commit-id so that I can add it to my out-of-tree
branch. If there is no other fix yet I will push this upstream soon with
the next round of iommu-fixes.

Thanks,

	Joerg

>From 96f176a310e447966e45112fe4511b9d9fa0caf4 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joerg.roedel@amd.com>
Date: Tue, 6 Dec 2011 11:17:34 +0100
Subject: [PATCH] iommu/msm: Fix compile error in mach-msm/devices-iommu.c

Fix compile error due to missing <linux/module.h> include.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm/mach-msm/devices-iommu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/devices-iommu.c b/arch/arm/mach-msm/devices-iommu.c
index 24030d0..0fb7a17 100644
--- a/arch/arm/mach-msm/devices-iommu.c
+++ b/arch/arm/mach-msm/devices-iommu.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 #include <mach/irqs.h>
 #include <mach/iommu.h>
 
-- 
1.7.5.4

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
