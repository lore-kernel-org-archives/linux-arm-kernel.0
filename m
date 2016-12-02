From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:34 +0000
Subject: [RFC v3 PATCH 16/25] ARM: ep93xx: select ARM_PATCH_PHYS_VIRT for MMU
 builds only
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-17-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building in NOMMU configurations lead to the following splat:

warning: (ARCH_INTEGRATOR && ARCH_MULTIPLATFORM && ARCH_EP93XX) selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU)

Make sure ARM_PATCH_PHYS_VIRT is selected for MMU builds only.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90c91de..b3fa6e9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -380,7 +380,7 @@ config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select ARM_VIC
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
-- 
1.7.9.5
