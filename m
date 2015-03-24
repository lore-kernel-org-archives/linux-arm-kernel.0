From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 10:50:32 +0200
Subject: [PATCH 1/2] ARM: Alpine: add support for generic pci
Message-ID: <55112558.9CrgVqMUZd7D6Boo%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Alpine platform requires generic-pci driver to access the internal pci bus.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/mach-alpine/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index 79b2649..2c44b93 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -6,5 +6,7 @@ config ARCH_ALPINE
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_SMP
 	select MFD_SYSCON
+	select PCI
+	select PCI_HOST_GENERIC
 	help
 	  This enables support for the Annapurna Labs Alpine V1 boards.
-- 
1.9.1
