From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 27 Nov 2015 14:34:31 +0300
Subject: [PATCH v2] ARM: Enable GICv2m on 32-bit virt machine
Message-ID: <1448624071-9552-1-git-send-email-p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern qemu includes GICv2m support for both 64 and 32 bits, therefore
32-bit guests may also use MSI.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
v1 => v2:
- Rebased on top of 4.4rc1. msi.h is already added by 0ab089c.
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0365cbb..a5f5843 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -797,6 +797,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V2M if PCI_MSI
 	select ARM_GIC_V3
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
-- 
2.4.4
