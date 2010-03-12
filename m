From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 08:51:54 -0500
Subject: [PATCH] [ARM] pxa: fix the cpu_is_pxa950
Message-ID: <mailman.340.1272529100.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the wrong variable used in cpu_is_pxa950().

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/hardware.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index 7515757..3d8d8cb 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -202,7 +202,7 @@
 #define __cpu_is_pxa950(id)                             \
 	({                                              \
 		unsigned int _id = (id) >> 4 & 0xfff;	\
-		id == 0x697;				\
+		_id == 0x697;				\
 	 })
 #else
 #define __cpu_is_pxa950(id)	(0)
-- 
1.5.6.5
