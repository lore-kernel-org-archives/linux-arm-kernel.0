From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Wed, 31 Oct 2012 17:57:49 +0200
Subject: [PATCH] arm-dt: Enable DT proc updates.
Message-ID: <1351699069-4661-1-git-send-email-panto@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simple patch enables dynamic changes of the DT tree on runtime
to be visible to the device-tree proc interface.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 arch/arm/include/asm/prom.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index aeae9c6..6d65ba2 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -11,6 +11,8 @@
 #ifndef __ASMARM_PROM_H
 #define __ASMARM_PROM_H
 
+#define HAVE_ARCH_DEVTREE_FIXUPS
+
 #ifdef CONFIG_OF
 
 extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
-- 
1.7.12
