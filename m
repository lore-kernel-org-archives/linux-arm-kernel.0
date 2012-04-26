From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 Apr 2012 16:29:52 -0700
Subject: [PATCH/RFT 7/8] ARM: OMAP: remove unused cpu_is_omap3530()
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Message-ID: <1335482993-14035-8-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_is_omap3530() macro is unused, remove.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index b34bf6c..d584ac7 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -289,7 +289,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
-#define cpu_is_omap3530()		0
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap3630()		0
@@ -342,7 +341,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
-# undef cpu_is_omap3530
 # undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
@@ -350,7 +348,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
-# define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3517()		is_omap3517()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
-- 
1.7.9.2
