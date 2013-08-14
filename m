From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Aug 2013 21:50:18 +0200
Subject: [PATCH] ARM: integrator: Make sure INTEGRATOR_AP depends on PCI
Message-ID: <1376509818-22163-1-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add this dependency to the Kconfig file to fix the following
build error when CONFIG_INTEGRATOR_AP is set but CONFIG_PCI
is not:

  LD      init/built-in.o
arch/arm/mach-integrator/built-in.o: In function `ap_map_io':
integrator_cp.c:(.init.text+0x570): undefined reference to `pci_v3_early_init'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

Signed-off-by: Joerg Roedel <joro@8bytes.org>
---
 arch/arm/mach-integrator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index abeff25..be16569 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -9,6 +9,7 @@ config ARCH_INTEGRATOR_AP
 	select SERIAL_AMBA_PL010
 	select SERIAL_AMBA_PL010_CONSOLE
 	select SOC_BUS
+	depends on PCI
 	help
 	  Include support for the ARM(R) Integrator/AP and
 	  Integrator/PP2 platforms.
-- 
1.7.9.5
