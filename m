From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:26 +0000
Subject: [PATCH-WIP 05/13] xen/arm: empty implementation of grant_table arch
 specific functions
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/Makefile      |    2 +-
 arch/arm/xen/grant-table.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/xen/grant-table.c

diff --git a/arch/arm/xen/Makefile b/arch/arm/xen/Makefile
index 0bad594..563f22a 100644
--- a/arch/arm/xen/Makefile
+++ b/arch/arm/xen/Makefile
@@ -1 +1 @@
-obj-y		:= enlighten.o
+obj-y		:= enlighten.o grant-table.o
diff --git a/arch/arm/xen/grant-table.c b/arch/arm/xen/grant-table.c
new file mode 100644
index 0000000..b82a799
--- /dev/null
+++ b/arch/arm/xen/grant-table.c
@@ -0,0 +1,47 @@
+/******************************************************************************
+ * grant_table.c
+ * ARM specific part
+ *
+ * Granting foreign access to our memory reservation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <xen/interface/xen.h>
+#include <xen/page.h>
+#include <xen/grant_table.h>
+
+int arch_gnttab_map_shared(unsigned long *frames, unsigned long nr_gframes,
+			   unsigned long max_nr_gframes,
+			   struct grant_entry **__shared)
+{
+	return -1;
+}
+
+void arch_gnttab_unmap_shared(struct grant_entry *shared,
+			      unsigned long nr_gframes)
+{
+	return;
+}
-- 
1.7.2.5
