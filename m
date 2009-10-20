From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2009 17:11:27 -0700
Subject: [PATCH] omap: Split vmalloc.h for mach-omap1 and mach-omap2
Message-ID: <mailman.83.1255998071.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier patch "omap: Remap L3, L4 to get more kernel io address space"
changed the VMALLOC_END.

However, this change causes problems on mach-omap1:

BUG: mapping for 0xe0000000 at 0xe0000000 overlaps vmalloc space
BUG: mapping for 0xe1000000 at 0xe1000000 overlaps vmalloc space

Fix this by creating separate vmalloc.h files for mach-omap1
and mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
index 085a18a..1b2af14 100644
--- a/arch/arm/mach-omap1/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -1,5 +1,20 @@
 /*
- * arch/arm/mach-omap1/include/mach/vmalloc.h
+ *  arch/arm/mach-omap1/include/mach/vmalloc.h
+ *
+ *  Copyright (C) 2000 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-
-#include <plat/vmalloc.h>
+#define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
diff --git a/arch/arm/mach-omap2/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
index 1423223..9ce9b6e 100644
--- a/arch/arm/mach-omap2/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -1,5 +1,20 @@
 /*
- * arch/arm/mach-omap2/include/mach/vmalloc.h
+ *  arch/arm/plat-omap/include/mach/vmalloc.h
+ *
+ *  Copyright (C) 2000 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-
-#include <plat/vmalloc.h>
+#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
diff --git a/arch/arm/plat-omap/include/plat/vmalloc.h b/arch/arm/plat-omap/include/plat/vmalloc.h
deleted file mode 100644
index 9eebf62..0000000
--- a/arch/arm/plat-omap/include/plat/vmalloc.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
-

--twz1s1Hj1O0rHoT0--
