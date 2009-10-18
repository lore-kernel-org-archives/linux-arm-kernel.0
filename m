From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sun, 18 Oct 2009 06:09:32 -0400
Subject: [PATCH] [ARM] pxa: rename macro from pxa9xx to pxa93x
Message-ID: <mailman.107.1257389905.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because original macro can only judge whether current CPU is pxa93x, rename
the macro to correct name.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/hardware.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index aa3d9f7..50f1297 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -105,6 +105,7 @@
  *
  *  PXA935	A0	0x56056931	0x1E653013
  *  PXA935	B0	0x56056936	0x6E653013
+ *  PXA935	B1	0x56056938	0x8E653013
  */
 #ifdef CONFIG_PXA25x
 #define __cpu_is_pxa210(id)				\
@@ -283,7 +284,7 @@
 		_id == 0x3;				\
 	 })

-#define __cpu_is_pxa9xx(id)				\
+#define __cpu_is_pxa93x(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x683 || _id == 0x693;		\
@@ -299,9 +300,9 @@
 		__cpu_is_pxa3xx(read_cpuid_id());	\
 	 })

-#define cpu_is_pxa9xx()					\
+#define cpu_is_pxa93x()					\
 	({						\
-		__cpu_is_pxa9xx(read_cpuid_id());	\
+		__cpu_is_pxa93x(read_cpuid_id());	\
 	 })
 /*
  * return current memory and LCD clock frequency in units of 10kHz
-- 
1.5.6.5
