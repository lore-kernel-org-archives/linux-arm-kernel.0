From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:56:39 +0100
Subject: [PATCH] ARM: tegra: fix missing include of cpuidle.h
Message-ID: <1465404999-16788-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several files are missing declarations from cpuidle.h so fix
the following warnings by including it:

arch/arm/mach-tegra/cpuidle-tegra20.c:216:6: warning: symbol 'tegra20_cpuidle_pcie_irqs_in_use' was not declared. Should it be static?
arch/arm/mach-tegra/cpuidle-tegra20.c:223:12: warning: symbol 'tegra20_cpuidle_init' was not declared. Should it be static?
arch/arm/mach-tegra/cpuidle-tegra30.c:144:12: warning: symbol 'tegra30_cpuidle_init' was not declared. Should it be static?
arch/arm/mach-tegra/cpuidle-tegra114.c:91:12: warning: symbol 'tegra114_cpuidle_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 9157546..800bcba 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -28,6 +28,7 @@
 
 #include "pm.h"
 #include "sleep.h"
+#include "cpuidle.h"
 
 #ifdef CONFIG_PM_SLEEP
 #define TEGRA114_MAX_STATES 2
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 7469347..8ee8108 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -36,6 +36,7 @@
 #include "pm.h"
 #include "reset.h"
 #include "sleep.h"
+#include "cpuidle.h"
 
 #ifdef CONFIG_PM_SLEEP
 static bool abort_flag;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 4dbe1da..7df3ab0 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -32,6 +32,7 @@
 
 #include "pm.h"
 #include "sleep.h"
+#include "cpuidle.h"
 
 #ifdef CONFIG_PM_SLEEP
 static int tegra30_idle_lp2(struct cpuidle_device *dev,
-- 
2.8.1
