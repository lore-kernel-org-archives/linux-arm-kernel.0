From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 24 Sep 2014 20:59:11 +0200
Subject: [PATCH] ARM: efm32: drop selecting NO_DMA
Message-ID: <1411585151.19525.29.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig entry for ARCH_EFM32 selects NO_DMA. But that doesn't have
any effect as arm doesn't have a Kconfig entry for NO_DMA. This select
is a nop. Drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested by playing with arch/arm/configs/efm32_defconfig. After "make
oldconfig" the .config contains CONFIG_HAS_DMA=y both before and after
this patch, as is expected.

Actually, the only difference I found in the .config file was that after
this patch the .config file contained
    CONFIG_ARCH_EFM32=y

I have no idea why. Did I botch my test?

 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d63e50615e9c..804ddc134c3c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -426,7 +426,6 @@ config ARCH_EFM32
 	select COMMON_CLK
 	select CPU_V7M
 	select GENERIC_CLOCKEVENTS
-	select NO_DMA
 	select NO_IOPORT_MAP
 	select SPARSE_IRQ
 	select USE_OF
-- 
1.9.3
