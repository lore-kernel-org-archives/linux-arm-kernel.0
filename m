From: rabin@rab.in (Rabin Vincent)
Date: Fri, 19 Nov 2010 21:36:22 +0530
Subject: [PATCH] ARM: versatile: ensure sched_clock() is notrace
Message-ID: <1290182785-22352-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include sched.h to ensure sched_clock() has the notrace
annotation.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/plat-versatile/sched-clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 9768cf7..9696ddc 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -20,6 +20,7 @@
  */
 #include <linux/cnt32_to_63.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 #include <asm/div64.h>
 
 #include <mach/hardware.h>
-- 
1.7.2.3
