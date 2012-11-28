From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 28 Nov 2012 14:42:35 +0800
Subject: [PATCH] ARM: mmp: select PINCTRL for ARCH_MMP
Message-ID: <1354084955.18972.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes PINCTRL related config options visible.
Otherwise there is no way to build pinctrl drivers for MMP2, PXA168 and PXA910.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on https://lkml.org/lkml/2012/11/12/10
Resend to Haojian's correct email address.

 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1fd4208..2f8bfd4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -591,6 +591,7 @@ config ARCH_MMP
 	select GPIO_PXA
 	select IRQ_DOMAIN
 	select NEED_MACH_GPIO_H
+	select PINCTRL
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
-- 
1.7.9.5
