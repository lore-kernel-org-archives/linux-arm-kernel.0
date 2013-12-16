From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 16 Dec 2013 22:51:55 +0800
Subject: [PATCH] ARM: Remove duplicate SCHED_HRTICK config option
Message-ID: <1387205515.6989.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two SCHED_HRTICK config entries in Kconfig.
This looks like a merge mistake. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e462c5d..03649aa0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1656,9 +1656,6 @@ config HZ
 config SCHED_HRTICK
 	def_bool HIGH_RES_TIMERS
 
-config SCHED_HRTICK
-	def_bool HIGH_RES_TIMERS
-
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
-- 
1.8.1.2
