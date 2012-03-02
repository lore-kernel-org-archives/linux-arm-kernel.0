From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:19 -0600
Subject: [PATCH v3 07/30] ARM: iop13xx: move io.h externs to pci.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

These variables are just needed in pci.c and io.c, so move them out of
io.h in preparation to remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-iop13xx/include/mach/io.h |    4 ----
 arch/arm/mach-iop13xx/io.c              |    2 ++
 arch/arm/mach-iop13xx/pci.h             |    6 ++++++
 3 files changed, 8 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-iop13xx/pci.h

diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index 2a69fc0..058dbfd 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -26,9 +26,5 @@
 #define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
-extern u32 iop13xx_atue_mem_base;
-extern u32 iop13xx_atux_mem_base;
-extern size_t iop13xx_atue_mem_size;
-extern size_t iop13xx_atux_mem_size;
 
 #endif
diff --git a/arch/arm/mach-iop13xx/io.c b/arch/arm/mach-iop13xx/io.c
index d63585e..70f716f 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 
+#include "pci.h"
+
 void * __iomem __iop13xx_io(unsigned long io_addr)
 {
 	void __iomem * io_virt;
diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
new file mode 100644
index 0000000..c70cf5b
--- /dev/null
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -0,0 +1,6 @@
+#include <linux/types.h>
+
+extern u32 iop13xx_atue_mem_base;
+extern u32 iop13xx_atux_mem_base;
+extern size_t iop13xx_atue_mem_size;
+extern size_t iop13xx_atux_mem_size;
-- 
1.7.5.4
