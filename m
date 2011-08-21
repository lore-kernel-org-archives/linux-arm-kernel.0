From: robherring2@gmail.com (Rob Herring)
Date: Sun, 21 Aug 2011 14:01:11 -0500
Subject: [PATCH 1/2] ARM: orion5x: add missing header file <video/vga.h>
Message-ID: <1313953272-24733-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This fixes the following build error:

arch/arm/mach-orion5x/pci.c: In function ?orion5x_pci_sys_setup?:
arch/arm/mach-orion5x/pci.c:563:2: error: ?vga_base? undeclared (first use in this function)
arch/arm/mach-orion5x/pci.c:563:2: note: each undeclared identifier is reported only once for each func

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 28b8760..bc4a920 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mbus.h>
+#include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
-- 
1.7.4.1
