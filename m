From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 06 Aug 2010 13:23:43 +0900
Subject: [PATCH 1/3] ARM: S5PC210: Use the correct GPIO base addresses
Message-ID: <20100806042343.GA19431@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

The S5PC210 has three GPIO base addresses.

Part1 Base Address=0x11400000
Part2 Base Address=0x11000000
Part3 Base Address=0x03860000

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/map.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 87697c9..7eb2a7a 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -39,8 +39,10 @@
 #define S5PV310_PA_GIC_DIST		(0x10501000)
 #define S5PV310_PA_L2CC			(0x10502000)
 
-#define S5PV310_PA_GPIO			(0x11000000)
+#define S5PV310_PA_GPIO			(0x11400000)
 #define S5P_PA_GPIO			S5PV310_PA_GPIO
+#define S5PV310_PA_GPIO2		(0x11000000)
+#define S5PV310_PA_GPIO3		(0x03860000)
 
 #define S5PV310_PA_UART			(0x13800000)
 
-- 
1.5.3.3
