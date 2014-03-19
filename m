From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:36 +0100
Subject: [PATCH 39/62] ARM: footbridge: fix build with PCI disabled
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-40-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dc21285.c source file cannot be built when CONFIG_PCI is
disabled, because it calls a number of PCI core interfaces.

This changes the Makefile so we don't include this file in the
build if CONFIG_PCI is disabled. No other code references anything
defined inside of this file in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-footbridge/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 0b64dd4..c3faa3b 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -4,11 +4,12 @@
 
 # Object file lists.
 
-obj-y			:= common.o dc21285.o dma.o isa-irq.o
+obj-y			:= common.o dma.o isa-irq.o
 obj-m			:=
 obj-n			:=
 obj-			:=
 
+pci-y			+= dc21285.o
 pci-$(CONFIG_ARCH_CATS) += cats-pci.o
 pci-$(CONFIG_ARCH_EBSA285_HOST) += ebsa285-pci.o
 pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
-- 
1.8.3.2
