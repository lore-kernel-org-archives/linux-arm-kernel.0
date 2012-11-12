From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 12 Nov 2012 14:30:07 +0800
Subject: [PATCH] ARM: select PINCTRL for ARCH_MMP
Message-ID: <1352701807.15066.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes PINCTRL related config options visible.
Otherwise there is no way to build pinctrl drivers for MMP2, PXA168 and PXA910.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 48eea16..24e9339 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -581,6 +581,7 @@ config ARCH_MMP
 	select GPIO_PXA
 	select IRQ_DOMAIN
 	select NEED_MACH_GPIO_H
+	select PINCTRL
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
-- 
1.7.9.5
