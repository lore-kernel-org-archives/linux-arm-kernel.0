From: mhu4@marvell.com (Mingliang Hu)
Date: Mon, 12 Apr 2010 17:55:21 +0800
Subject: [PATCH] [ARM] mmp: fix clock tick rate in mmp2
Message-ID: <mailman.328.1272457241.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MMP2, clock tick rate should be 6500000.

Signed-off-by: Mingliang Hu <mhu4@marvell.com>
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
