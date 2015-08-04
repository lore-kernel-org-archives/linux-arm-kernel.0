From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 04 Aug 2015 12:59:49 +0300
Subject: [PATCH TRIVIAL] Enable GICv2m on ARM virt machine
Message-ID: <00f501d0ce9c$4d57bcc0$e8073640$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

qemu implementation of "virt" includes GICv2m. This commit allows to use
it also on ARM32 architecture.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/Kconfig            | 1 +
 arch/arm/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..1091025 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -815,6 +815,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V2M if PCI_MSI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 3c4596d..01806f5 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += poll.h
-- 
1.9.5.msysgit.0
