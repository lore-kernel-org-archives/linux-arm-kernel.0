From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Apr 2016 15:21:31 +0200
Subject: [PATCH 1/4] ARM: tegra: hotplug: Include missing common.h
Message-ID: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Some of the functions implemented are flagged as not having a prototype
defined when building with W=1. Include the header to avoid these build
warnings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/common.h  | 22 ++++++++++++++++++++++
 arch/arm/mach-tegra/hotplug.c |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index 1f6fb808e236..4cc00e993b00 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -1,4 +1,26 @@
+/*
+ * Copyright (c) 2011, ARM Ltd.
+ * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_TEGRA_COMMON_H
+#define __MACH_TEGRA_COMMON_H
+
 extern const struct smp_operations tegra_smp_ops;
 
 extern int tegra_cpu_kill(unsigned int cpu);
 extern void tegra_cpu_die(unsigned int cpu);
+
+#endif
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 1b129899a277..8ec707826072 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -17,6 +17,7 @@
 
 #include <asm/smp_plat.h>
 
+#include "common.h"
 #include "sleep.h"
 
 static void (*tegra_hotplug_shutdown)(void);
-- 
2.8.0
