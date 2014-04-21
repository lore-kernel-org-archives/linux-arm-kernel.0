From: elder@linaro.org (Alex Elder)
Date: Mon, 21 Apr 2014 16:53:11 -0500
Subject: [PATCH v2 10/10] ARM: bcm: rename "kona.h" and "kona.c"
In-Reply-To: <1398117191-2433-1-git-send-email-elder@linaro.org>
References: <1398117191-2433-1-git-send-email-elder@linaro.org>
Message-ID: <1398117191-2433-11-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These source files contain only level-2 cache initialization code,
so rename them to make that fact more obvious.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/mach-bcm/Makefile                    | 2 +-
 arch/arm/mach-bcm/board_bcm21664.c            | 2 +-
 arch/arm/mach-bcm/board_bcm281xx.c            | 2 +-
 arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} | 0
 arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} | 0
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} (100%)
 rename arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} (100%)

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index d5b60fe..7312921 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
 obj-$(CONFIG_ARCH_BCM_21664)	+= board_bcm21664.o
 
 # BCM281XX and BCM21664 L2 cache control
-obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) += kona.o
+obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) += kona_l2_cache.o
 
 # Support for secure monitor traps
 obj-$(CONFIG_ARCH_BCM_MOBILE_SMC) += bcm_kona_smc.o
diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
index 1091637..f0521cc 100644
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@ -17,7 +17,7 @@
 
 #include <asm/mach/arch.h>
 
-#include "kona.h"
+#include "kona_l2_cache.h"
 
 #define RSTMGR_DT_STRING		"brcm,bcm21664-resetmgr"
 
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 6be54c1..1ac59fc 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -17,7 +17,7 @@
 
 #include <asm/mach/arch.h>
 
-#include "kona.h"
+#include "kona_l2_cache.h"
 
 #define SECWDOG_OFFSET			0x00000000
 #define SECWDOG_RESERVED_MASK		0xe2000000
diff --git a/arch/arm/mach-bcm/kona.c b/arch/arm/mach-bcm/kona_l2_cache.c
similarity index 100%
rename from arch/arm/mach-bcm/kona.c
rename to arch/arm/mach-bcm/kona_l2_cache.c
diff --git a/arch/arm/mach-bcm/kona.h b/arch/arm/mach-bcm/kona_l2_cache.h
similarity index 100%
rename from arch/arm/mach-bcm/kona.h
rename to arch/arm/mach-bcm/kona_l2_cache.h
-- 
1.9.1
