From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 15:11:55 +0100
Subject: [PATCH] pcmcia: add missing include for new pci resource handler
Message-ID: <5425521.E2szj8uYq0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added rsrc_pci.c file calls pci_bus_alloc_resource without
including the header file that declares it, and that sometimes causes
a build warning on ARM:

drivers/pcmcia/rsrc_pci.c: In function 'find_io_region':
drivers/pcmcia/rsrc_pci.c:40:2: error: implicit declaration of function 'pci_bus_alloc_resource' [-Werror=implicit-function-declaration]

This adds the missing include statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 02b03846bb2be ("pcmcia: add a new resource manager for non ISA systems")
---
diff --git a/drivers/pcmcia/rsrc_pci.c b/drivers/pcmcia/rsrc_pci.c
index 8934d3c01f80..21c3683b1a53 100644
--- a/drivers/pcmcia/rsrc_pci.c
+++ b/drivers/pcmcia/rsrc_pci.c
@@ -1,6 +1,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 
 #include <pcmcia/ss.h>
 #include <pcmcia/cistpl.h>
