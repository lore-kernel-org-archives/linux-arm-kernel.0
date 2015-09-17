From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:35 +0900
Subject: [PATCH 19/21] ARM: shmobile: Kconfig: remove unused SHMOBILE_TIMER_HZ
 section
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <7463c876331d01aafb420f3637c2f69409eb0447.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Obsoleted by removal of legacy platforms.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 7f2e05304d3d..88734a5e10ca 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -98,23 +98,3 @@ config ARCH_SH73A0
 
 comment "Renesas ARM SoCs System Configuration"
 endif
-
-if ARCH_SHMOBILE
-
-menu "Timer and clock configuration"
-
-config SHMOBILE_TIMER_HZ
-	int "Kernel HZ (jiffies per second)"
-	range 32 1024
-	default "128"
-	help
-	  Allows the configuration of the timer frequency. It is customary
-	  to have the timer interrupt run at 1000 Hz or 100 Hz, but in the
-	  case of low timer frequencies other values may be more suitable.
-	  Renesas ARM SoC systems using a 32768 Hz RCLK for clock events may
-	  want to select a HZ value such as 128 that can evenly divide RCLK.
-	  A HZ value that does not divide evenly may cause timer drift.
-
-endmenu
-
-endif
-- 
2.1.4
