From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 17 Aug 2011 14:29:03 +0800
Subject: [PATCH] ARM: Footbridge: select CLKEVT_I8253 for ARCH_NETWINDER
Message-ID: <1313562543.2024.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8560a6cfc9818edde1fd8677961714b264ffa03d
"arm: Footbridge: Use common i8253 clockevent",
ARCH_NETWINDER nees to select CLKEVT_I8253.

This patch fixes below build error with "make netwinder_defconfig".

  LD      .tmp_vmlinux1
arch/arm/mach-footbridge/built-in.o: In function `isa_timer_init':
isa-rtc.c:(.init.text+0x12c8): undefined reference to `clockevent_i8253_init'
isa-rtc.c:(.init.text+0x12d0): undefined reference to `i8253_clockevent'
arch/arm/mach-footbridge/built-in.o:(.data+0x198): undefined reference to `i8253_clockevent'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-footbridge/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index dc26fff..c8e7afc 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -62,6 +62,7 @@ config ARCH_EBSA285_HOST
 config ARCH_NETWINDER
 	bool "NetWinder"
 	select CLKSRC_I8253
+	select CLKEVT_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
-- 
1.7.4.1
