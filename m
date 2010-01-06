From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 6 Jan 2010 16:48:24 -0500
Subject: [PATCH] [ARM] mmp: fix the clock rate of mmp2
Message-ID: <mailman.124.1262786777.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/timex.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/timex.h
b/arch/arm/mach-mmp/include/mach/timex.h
index 6cebbd0..70c9f1d 100644
--- a/arch/arm/mach-mmp/include/mach/timex.h
+++ b/arch/arm/mach-mmp/include/mach/timex.h
@@ -6,4 +6,8 @@
  * published by the Free Software Foundation.
  */

+#ifdef CONFIG_CPU_MMP2
+#define CLOCK_TICK_RATE		6500000
+#else
 #define CLOCK_TICK_RATE		3250000
+#endif
-- 
1.5.6.5
