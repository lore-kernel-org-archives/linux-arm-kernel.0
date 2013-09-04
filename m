From: jwboyer@redhat.com (Josh Boyer)
Date: Wed, 4 Sep 2013 09:38:50 -0400
Subject: ARM: OMAP2: Make MACH_OMAP3EVM select NOP_USB_XCEIV
Message-ID: <20130904133850.GC12834@hansolo.jdub.homelinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board-omap3evm.c file unconditionally calls usb_nop_xceiv_register but
doesn't ensure this is built-in.  This can lead to build failures like:

arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
linux-3.12.0-0.rc0.git2.1.fc21.armv7hl/arch/arm/mach-omap2/board-omap3evm.c:686: undefined reference to `usb_nop_xceiv_register'
make: *** [vmlinux] Error 1

Make MACH_OMAP3EVM select NOP_USB_XCEIV to avoid this.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eed000..3350389 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -258,6 +258,7 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select NOP_USB_XCEIV
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
-- 
1.8.3.1
