From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:49:27 +0200
Subject: [PATCH 02/12] ARM: ep93xx: use ARM_PATCH_PHYS_VIRT
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720154939.3250697-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like ARCH_MULTIPLATFORM, we want to use ARM_PATCH_PHYS_VIRT
when possible, but that fails for NOMMU or XIP_KERNEL configurations.
Using 'imply' instead of 'select' gets this right and only uses
the symbol when we don't have to hardcode the address anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d6e6f40addf6..db856355bd24 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -406,7 +406,7 @@ config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
+	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
-- 
2.9.0
