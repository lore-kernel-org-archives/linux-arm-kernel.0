From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 12 Nov 2010 14:32:47 +0530
Subject: [PATCH v2] ARM: fix compile warning in mm/init.c
Message-ID: <1289552567-14005-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
changed VMALLOC_END to be an explicit value. Before this, it was
relative to PAGE_OFFSET and therefore automatically upgraded to
unsigned long as PAGE_OFFSET was an unsigned long. This introduced
the following build warning. Fix this by changing the explicit
defines of VMALLOC_END to be unsigned long.

  CC      arch/arm/mm/init.o
arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-aaec2000/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-bcmring/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-clps711x/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-ebsa110/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-footbridge/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-h720x/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-integrator/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-msm/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-netx/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-omap1/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-omap2/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-pnx4008/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-rpc/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-shark/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-versatile/include/mach/vmalloc.h  |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

Index: ehci/arch/arm/mach-aaec2000/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-aaec2000/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-aaec2000/include/mach/vmalloc.h
@@ -11,6 +11,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END		0xd0000000
+#define VMALLOC_END		0xd0000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
Index: ehci/arch/arm/mach-bcmring/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-bcmring/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-bcmring/include/mach/vmalloc.h
@@ -22,4 +22,4 @@
  * 0xe0000000 to 0xefffffff. This gives us 256 MB of vm space and handles
  * larger physical memory designs better.
  */
-#define VMALLOC_END       0xf0000000
+#define VMALLOC_END       0xf0000000UL
Index: ehci/arch/arm/mach-clps711x/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-clps711x/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-clps711x/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
Index: ehci/arch/arm/mach-ebsa110/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-ebsa110/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-ebsa110/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define VMALLOC_END       0xdf000000
+#define VMALLOC_END       0xdf000000UL
Index: ehci/arch/arm/mach-footbridge/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-footbridge/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-footbridge/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  */
 
 
-#define VMALLOC_END       0xf0000000
+#define VMALLOC_END       0xf0000000UL
Index: ehci/arch/arm/mach-h720x/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-h720x/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-h720x/include/mach/vmalloc.h
@@ -5,6 +5,6 @@
 #ifndef __ARCH_ARM_VMALLOC_H
 #define __ARCH_ARM_VMALLOC_H
 
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
 
 #endif
Index: ehci/arch/arm/mach-integrator/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-integrator/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-integrator/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
Index: ehci/arch/arm/mach-msm/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-msm/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-msm/include/mach/vmalloc.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_ARCH_MSM_VMALLOC_H
 #define __ASM_ARCH_MSM_VMALLOC_H
 
-#define VMALLOC_END	  0xd0000000
+#define VMALLOC_END	  0xd0000000UL
 
 #endif
 
Index: ehci/arch/arm/mach-netx/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-netx/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-netx/include/mach/vmalloc.h
@@ -16,4 +16,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
Index: ehci/arch/arm/mach-omap1/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-omap1/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	0xd8000000
+#define VMALLOC_END	0xd8000000UL
Index: ehci/arch/arm/mach-omap2/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-omap2/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	  0xf8000000
+#define VMALLOC_END	  0xf8000000UL
Index: ehci/arch/arm/mach-pnx4008/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-pnx4008/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-pnx4008/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
  */
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
Index: ehci/arch/arm/mach-rpc/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-rpc/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-rpc/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define VMALLOC_END       0xdc000000
+#define VMALLOC_END       0xdc000000UL
Index: ehci/arch/arm/mach-shark/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-shark/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-shark/include/mach/vmalloc.h
@@ -1,4 +1,4 @@
 /*
  * arch/arm/mach-shark/include/mach/vmalloc.h
  */
-#define VMALLOC_END       0xd0000000
+#define VMALLOC_END       0xd0000000UL
Index: ehci/arch/arm/mach-versatile/include/mach/vmalloc.h
===================================================================
--- ehci.orig/arch/arm/mach-versatile/include/mach/vmalloc.h
+++ ehci/arch/arm/mach-versatile/include/mach/vmalloc.h
@@ -18,4 +18,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END		0xd8000000
+#define VMALLOC_END		0xd8000000UL
