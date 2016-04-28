From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Apr 2016 15:21:32 +0200
Subject: [PATCH 2/4] ARM: tegra: cpuidle: Add missing cpuidle.h include
In-Reply-To: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
References: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461849694-13068-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Some of the functions implemented are flagged as not having a prototype
defined when building with W=1. Include the header to avoid these build
warnings and add a prototype as well as a dummy implementation for the
tegra_cpuidle_pcie_irqs_in_use() function.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 1 +
 arch/arm/mach-tegra/cpuidle.h          | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 9157546fe68c..d3aa9be16621 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -26,6 +26,7 @@
 #include <asm/suspend.h>
 #include <asm/psci.h>
 
+#include "cpuidle.h"
 #include "pm.h"
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 7469347b1749..afcee04f2616 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -30,6 +30,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "cpuidle.h"
 #include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 4dbe1dae937c..c1417361e10e 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -30,6 +30,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "cpuidle.h"
 #include "pm.h"
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index c017dab60ffa..dd1624d4b294 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -23,8 +23,10 @@ void tegra20_cpuidle_pcie_irqs_in_use(void);
 int tegra30_cpuidle_init(void);
 int tegra114_cpuidle_init(void);
 void tegra_cpuidle_init(void);
+void tegra_cpuidle_pcie_irqs_in_use(void);
 #else
 static inline void tegra_cpuidle_init(void) {}
+static inline void tegra_cpuidle_pcie_irqs_in_use(void) {}
 #endif
 
 #endif
-- 
2.8.0
