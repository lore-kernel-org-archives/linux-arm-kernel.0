From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  3 Apr 2013 16:45:12 +0200
Subject: [PATCH v3 06/12] ARM: tegra: Move pmc.h to include/linux/tegra-pmc.h
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1365000318-28256-7-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for moving the PCIe driver into the drivers/pci/host
directory, this header, which contains prototypes that are required by
the PCIe driver, needs to be moved to a globally visible location.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- keep tegra_pmc_init() prototype in arch/arm/mach-tegra/pmc.h
- move pmc.h to includex/linux/tegra-pmc.h

Changes in v3:
- update subject to match new location

 arch/arm/mach-tegra/pmc.h |  1 -
 include/linux/tegra-pmc.h | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/tegra-pmc.h

diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index c778451..7d44710 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -23,6 +23,5 @@ int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
 
 void tegra_pmc_init(void);
-void tegra_pmc_pcie_xclk_clamp(bool clamp);
 
 #endif
diff --git a/include/linux/tegra-pmc.h b/include/linux/tegra-pmc.h
new file mode 100644
index 0000000..b6296bf
--- /dev/null
+++ b/include/linux/tegra-pmc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
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
+ *
+ */
+
+#ifndef __LINUX_TEGRA_PMC_H
+#define __LINUX_TEGRA_PMC_H
+
+void tegra_pmc_pcie_xclk_clamp(bool clamp);
+
+#endif
-- 
1.8.2
