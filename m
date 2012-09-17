From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:37 +0800
Subject: [PATCH 08/34] ARM: imx: ARM: imx: include cpuidle.h rather than
 mach/cpuidle.h
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename mach-imx/include/mach/cpuidle.h to mach-imx/cpuidle.h, and
update users to include cpuidle.h rather than mach/cpuidle.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/{include/mach => }/cpuidle.h |    0
 arch/arm/mach-imx/mach-imx6q.c                 |    2 +-
 arch/arm/mach-imx/pm-imx5.c                    |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-imx/{include/mach => }/cpuidle.h (100%)

diff --git a/arch/arm/mach-imx/include/mach/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/cpuidle.h
rename to arch/arm/mach-imx/cpuidle.h
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 96d817b..b74f02f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -32,10 +32,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/cpuidle.h>
 #include <mach/hardware.h>
 
 #include "common.h"
+#include "cpuidle.h"
 
 void imx6q_restart(char mode, const char *cmd)
 {
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 9fead8c..a614702 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -16,10 +16,10 @@
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 #include <asm/tlbflush.h>
-#include <mach/cpuidle.h>
 #include <mach/hardware.h>
 
 #include "common.h"
+#include "cpuidle.h"
 #include "crm-regs-imx5.h"
 
 /*
-- 
1.7.9.5
