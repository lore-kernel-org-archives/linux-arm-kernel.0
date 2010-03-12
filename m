From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 08:53:47 -0500
Subject: [PATCH] [ARM] pxa: clean code in hardware.h
Message-ID: <mailman.341.1272529135.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid too much conditional compilation in hardware.h.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/hardware.h |   27 ++++++---------------------
 1 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index 3d8d8cb..6694643 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -148,63 +148,48 @@
 #define __cpu_is_pxa27x(id)	(0)
 #endif

-#ifdef CONFIG_CPU_PXA300
+#ifdef CONFIG_PXA3xx
 #define __cpu_is_pxa300(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x688;				\
 	 })
-#else
-#define __cpu_is_pxa300(id)	(0)
-#endif

-#ifdef CONFIG_CPU_PXA310
 #define __cpu_is_pxa310(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x689;				\
 	 })
-#else
-#define __cpu_is_pxa310(id)	(0)
-#endif

-#ifdef CONFIG_CPU_PXA320
 #define __cpu_is_pxa320(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x603 || _id == 0x682;		\
 	 })
-#else
-#define __cpu_is_pxa320(id)	(0)
-#endif

-#ifdef CONFIG_CPU_PXA930
 #define __cpu_is_pxa930(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x683;				\
 	 })
-#else
-#define __cpu_is_pxa930(id)	(0)
-#endif

-#ifdef CONFIG_CPU_PXA935
 #define __cpu_is_pxa935(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x693;				\
 	 })
-#else
-#define __cpu_is_pxa935(id)	(0)
-#endif

-#ifdef CONFIG_CPU_PXA950
 #define __cpu_is_pxa950(id)                             \
 	({                                              \
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x697;				\
 	 })
 #else
+#define __cpu_is_pxa300(id)	(0)
+#define __cpu_is_pxa310(id)	(0)
+#define __cpu_is_pxa320(id)	(0)
+#define __cpu_is_pxa930(id)	(0)
+#define __cpu_is_pxa935(id)	(0)
 #define __cpu_is_pxa950(id)	(0)
 #endif

-- 
1.5.6.5
