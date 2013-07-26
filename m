From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jul 2013 14:05:51 +0100
Subject: [RFC PATCH] ARM: dma: default ZONE_DMA to y if ARM_LPAE
Message-ID: <1374843951-1615-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems running with LPAE enabled, DMA masters capable only of 32-bit
addressing require ZONE_DMA to be set. Given the proliferation of such
masters, and the tendency to re-use existing system IP with newer
processors, this patch defaults ZONE_DMA to y if ARM_LPAE, rather than
force each SoC to select it individually.

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82f06982..7fede35 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -192,6 +192,7 @@ config ARCH_MAY_HAVE_PC_FDC
 
 config ZONE_DMA
 	bool
+	default y if ARM_LPAE
 
 config NEED_DMA_MAP_STATE
        def_bool y
-- 
1.8.2.2
