From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:38 +0800
Subject: [PATCH 09/34] ARM: imx: include iim.h rather than mach/iim.h
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename mach-imx/include/mach/iim.h to mach-imx/iim.h, and update users
to include iim.h rather than mach/iim.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/cpu-imx25.c              |    3 ++-
 arch/arm/mach-imx/cpu-imx31.c              |    2 +-
 arch/arm/mach-imx/cpu-imx35.c              |    3 ++-
 arch/arm/mach-imx/{include/mach => }/iim.h |    0
 4 files changed, 5 insertions(+), 3 deletions(-)
 rename arch/arm/mach-imx/{include/mach => }/iim.h (100%)

diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
index 6914bcb..79d4d1c 100644
--- a/arch/arm/mach-imx/cpu-imx25.c
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -12,7 +12,8 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <mach/iim.h>
+
+#include "iim.h"
 
 static int mx25_cpu_rev = -1;
 
diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index 9d3a91c..51c938f 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -12,9 +12,9 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <mach/iim.h>
 
 #include "common.h"
+#include "iim.h"
 
 static int mx31_cpu_rev = -1;
 
diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index 846e46e..8b36d3a 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -11,7 +11,8 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <mach/iim.h>
+
+#include "iim.h"
 
 static int mx35_cpu_rev = -1;
 
diff --git a/arch/arm/mach-imx/include/mach/iim.h b/arch/arm/mach-imx/iim.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/iim.h
rename to arch/arm/mach-imx/iim.h
-- 
1.7.9.5
