From: rabin@rab.in (Rabin Vincent)
Date: Fri, 19 Nov 2010 21:36:25 +0530
Subject: [PATCH] ARM: iop: ensure sched_clock() is notrace
Message-ID: <1290182785-22352-4-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include sched.h to ensure sched_clock() has the notrace
annotation, and mark any functions it calls as notrace
too.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/plat-iop/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 85d3e55..558cdfa 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/timex.h>
+#include <linux/sched.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -36,7 +37,7 @@
 /*
  * IOP clocksource (free-running timer 1).
  */
-static cycle_t iop_clocksource_read(struct clocksource *unused)
+static cycle_t notrace iop_clocksource_read(struct clocksource *unused)
 {
 	return 0xffffffffu - read_tcr1();
 }
-- 
1.7.2.3
