From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 17 Aug 2011 17:29:38 +0800
Subject: [PATCH] ARM: mach-orion5x: add missing header file <linux/vga.h>
Message-ID: <1313573378-20791-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixed following building error:
--
arch/arm/mach-orion5x/pci.c: In function 'orion5x_pci_sys_setup':
arch/arm/mach-orion5x/pci.c:563:2: error: 'vga_base' undeclared (first use in this function)
arch/arm/mach-orion5x/pci.c:563:2: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-orion5x/pci.o] Error 1
make[1]: *** Waiting for unfinished jobs....
--

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
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
1.7.5
