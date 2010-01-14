From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:08 +0100
Subject: [PATCH 3/5] Change type of VMALLOC_END to unsigned long.
In-Reply-To: <1263465370-4192-3-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-3-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1263465370-4192-4-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes it consistent with VMALLOC_START

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/include/asm/memory.h                 |    4 ++--
 arch/arm/include/asm/pgtable-nommu.h          |    4 ++--
 arch/arm/mach-davinci/include/mach/hardware.h |    2 +-
 arch/arm/mach-dove/include/mach/vmalloc.h     |    2 +-
 arch/arm/mach-ep93xx/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-gemini/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-iop32x/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-iop33x/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-ixp2000/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-ixp23xx/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-ixp4xx/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-kirkwood/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-lh7a40x/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-loki/include/mach/vmalloc.h     |    2 +-
 arch/arm/mach-mmp/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-mv78xx0/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-nomadik/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-ns9xxx/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-orion5x/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-pxa/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-realview/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s3c24a0/include/mach/vmalloc.h  |    2 +-
 arch/arm/mach-sa1100/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-u300/include/mach/vmalloc.h     |    2 +-
 arch/arm/mach-ux500/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-w90x900/include/mach/vmalloc.h  |    2 +-
 arch/arm/mm/init.c                            |    2 +-
 arch/arm/plat-mxc/include/mach/vmalloc.h      |    2 +-
 arch/arm/plat-s3c/include/mach/vmalloc.h      |    2 +-
 arch/arm/plat-stmp3xxx/include/mach/vmalloc.h |    2 +-
 30 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index f5e693b..4312ee5 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -104,11 +104,11 @@
 #endif
 
 #ifndef PHYS_OFFSET
-#define PHYS_OFFSET 		(CONFIG_DRAM_BASE)
+#define PHYS_OFFSET 		UL(CONFIG_DRAM_BASE)
 #endif
 
 #ifndef END_MEM
-#define END_MEM     		(CONFIG_DRAM_BASE + CONFIG_DRAM_SIZE)
+#define END_MEM     		(UL(CONFIG_DRAM_BASE) + CONFIG_DRAM_SIZE)
 #endif
 
 #ifndef PAGE_OFFSET
diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index b011f2e..013cfcd 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -86,8 +86,8 @@ extern unsigned int kobjsize(const void *objp);
  * All 32bit addresses are effectively valid for vmalloc...
  * Sort of meaningless for non-VM targets.
  */
-#define	VMALLOC_START	0
-#define	VMALLOC_END	0xffffffff
+#define	VMALLOC_START	0UL
+#define	VMALLOC_END	0xffffffffUL
 
 #define FIRST_USER_ADDRESS      (0)
 
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 41c8938..c45ba1f 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -27,7 +27,7 @@
 /*
  * I/O mapping
  */
-#define IO_PHYS				0x01c00000
+#define IO_PHYS				0x01c00000UL
 #define IO_OFFSET			0xfd000000 /* Virtual IO = 0xfec00000 */
 #define IO_SIZE				0x00400000
 #define IO_VIRT				(IO_PHYS + IO_OFFSET)
diff --git a/arch/arm/mach-dove/include/mach/vmalloc.h b/arch/arm/mach-dove/include/mach/vmalloc.h
index 8b2c974..a28792c 100644
--- a/arch/arm/mach-dove/include/mach/vmalloc.h
+++ b/arch/arm/mach-dove/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-dove/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfd800000
+#define VMALLOC_END	0xfd800000UL
diff --git a/arch/arm/mach-ep93xx/include/mach/vmalloc.h b/arch/arm/mach-ep93xx/include/mach/vmalloc.h
index aed21cd..1b3f25d 100644
--- a/arch/arm/mach-ep93xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-ep93xx/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-ep93xx/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe800000
+#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-gemini/include/mach/vmalloc.h b/arch/arm/mach-gemini/include/mach/vmalloc.h
index 83e536d..45371eb 100644
--- a/arch/arm/mach-gemini/include/mach/vmalloc.h
+++ b/arch/arm/mach-gemini/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * (at your option) any later version.
  */
 
-#define VMALLOC_END	0xF0000000
+#define VMALLOC_END	0xf0000000UL
diff --git a/arch/arm/mach-iop32x/include/mach/vmalloc.h b/arch/arm/mach-iop32x/include/mach/vmalloc.h
index 85ceb09..c4862d4 100644
--- a/arch/arm/mach-iop32x/include/mach/vmalloc.h
+++ b/arch/arm/mach-iop32x/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-iop32x/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe000000
+#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-iop33x/include/mach/vmalloc.h b/arch/arm/mach-iop33x/include/mach/vmalloc.h
index f9f99de..48331dc 100644
--- a/arch/arm/mach-iop33x/include/mach/vmalloc.h
+++ b/arch/arm/mach-iop33x/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-iop33x/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe000000
+#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-ixp2000/include/mach/vmalloc.h b/arch/arm/mach-ixp2000/include/mach/vmalloc.h
index d195e35..61c8dae 100644
--- a/arch/arm/mach-ixp2000/include/mach/vmalloc.h
+++ b/arch/arm/mach-ixp2000/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
  */
-#define VMALLOC_END	    0xfb000000
+#define VMALLOC_END	    0xfb000000UL
diff --git a/arch/arm/mach-ixp23xx/include/mach/vmalloc.h b/arch/arm/mach-ixp23xx/include/mach/vmalloc.h
index dd519f6..896c56a 100644
--- a/arch/arm/mach-ixp23xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-ixp23xx/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * specific static I/O.
  */
 
-#define VMALLOC_END	(0xec000000)
+#define VMALLOC_END	(0xec000000UL)
diff --git a/arch/arm/mach-ixp4xx/include/mach/vmalloc.h b/arch/arm/mach-ixp4xx/include/mach/vmalloc.h
index 7b3580b..9bcd64d 100644
--- a/arch/arm/mach-ixp4xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-ixp4xx/include/mach/vmalloc.h
@@ -1,5 +1,5 @@
 /*
  * arch/arm/mach-ixp4xx/include/mach/vmalloc.h
  */
-#define VMALLOC_END       (0xFF000000)
+#define VMALLOC_END       (0xff000000UL)
 
diff --git a/arch/arm/mach-kirkwood/include/mach/vmalloc.h b/arch/arm/mach-kirkwood/include/mach/vmalloc.h
index 8f48260..bf162ca 100644
--- a/arch/arm/mach-kirkwood/include/mach/vmalloc.h
+++ b/arch/arm/mach-kirkwood/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-kirkwood/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe800000
+#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-lh7a40x/include/mach/vmalloc.h b/arch/arm/mach-lh7a40x/include/mach/vmalloc.h
index 3fbd494..d62da73 100644
--- a/arch/arm/mach-lh7a40x/include/mach/vmalloc.h
+++ b/arch/arm/mach-lh7a40x/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  *  version 2 as published by the Free Software Foundation.
  *
  */
-#define VMALLOC_END       (0xe8000000)
+#define VMALLOC_END       (0xe8000000UL)
diff --git a/arch/arm/mach-loki/include/mach/vmalloc.h b/arch/arm/mach-loki/include/mach/vmalloc.h
index 8dc3bfc..5dcbd86 100644
--- a/arch/arm/mach-loki/include/mach/vmalloc.h
+++ b/arch/arm/mach-loki/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-loki/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe800000
+#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-mmp/include/mach/vmalloc.h b/arch/arm/mach-mmp/include/mach/vmalloc.h
index b60ccaf..1d0bac0 100644
--- a/arch/arm/mach-mmp/include/mach/vmalloc.h
+++ b/arch/arm/mach-mmp/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * linux/arch/arm/mach-mmp/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe000000
+#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-mv78xx0/include/mach/vmalloc.h b/arch/arm/mach-mv78xx0/include/mach/vmalloc.h
index 1c49543..ba26fe9 100644
--- a/arch/arm/mach-mv78xx0/include/mach/vmalloc.h
+++ b/arch/arm/mach-mv78xx0/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-mv78xx0/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END	0xfe000000
+#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-nomadik/include/mach/vmalloc.h b/arch/arm/mach-nomadik/include/mach/vmalloc.h
index be12e31..f83d574 100644
--- a/arch/arm/mach-nomadik/include/mach/vmalloc.h
+++ b/arch/arm/mach-nomadik/include/mach/vmalloc.h
@@ -1,2 +1,2 @@
 
-#define VMALLOC_END       0xe8000000
+#define VMALLOC_END       0xe8000000UL
diff --git a/arch/arm/mach-ns9xxx/include/mach/vmalloc.h b/arch/arm/mach-ns9xxx/include/mach/vmalloc.h
index fe964d3..c865197 100644
--- a/arch/arm/mach-ns9xxx/include/mach/vmalloc.h
+++ b/arch/arm/mach-ns9xxx/include/mach/vmalloc.h
@@ -11,6 +11,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END     (0xf0000000)
+#define VMALLOC_END     (0xf0000000UL)
 
 #endif /* ifndef __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-orion5x/include/mach/vmalloc.h b/arch/arm/mach-orion5x/include/mach/vmalloc.h
index 7147a29..06b50ae 100644
--- a/arch/arm/mach-orion5x/include/mach/vmalloc.h
+++ b/arch/arm/mach-orion5x/include/mach/vmalloc.h
@@ -2,4 +2,4 @@
  * arch/arm/mach-orion5x/include/mach/vmalloc.h
  */
 
-#define VMALLOC_END       0xfd800000
+#define VMALLOC_END       0xfd800000UL
diff --git a/arch/arm/mach-pxa/include/mach/vmalloc.h b/arch/arm/mach-pxa/include/mach/vmalloc.h
index e90c5ee..bfecfbf 100644
--- a/arch/arm/mach-pxa/include/mach/vmalloc.h
+++ b/arch/arm/mach-pxa/include/mach/vmalloc.h
@@ -8,4 +8,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define VMALLOC_END       (0xe8000000)
+#define VMALLOC_END       (0xe8000000UL)
diff --git a/arch/arm/mach-realview/include/mach/vmalloc.h b/arch/arm/mach-realview/include/mach/vmalloc.h
index fe0de1b..a2a4c68 100644
--- a/arch/arm/mach-realview/include/mach/vmalloc.h
+++ b/arch/arm/mach-realview/include/mach/vmalloc.h
@@ -18,4 +18,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END		0xf8000000
+#define VMALLOC_END		0xf8000000UL
diff --git a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h b/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
index 4d4fe48..9146568 100644
--- a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	  (0xe0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-sa1100/include/mach/vmalloc.h b/arch/arm/mach-sa1100/include/mach/vmalloc.h
index ec8fdc5..b3d0023 100644
--- a/arch/arm/mach-sa1100/include/mach/vmalloc.h
+++ b/arch/arm/mach-sa1100/include/mach/vmalloc.h
@@ -1,4 +1,4 @@
 /*
  * arch/arm/mach-sa1100/include/mach/vmalloc.h
  */
-#define VMALLOC_END       (0xe8000000)
+#define VMALLOC_END       (0xe8000000UL)
diff --git a/arch/arm/mach-u300/include/mach/vmalloc.h b/arch/arm/mach-u300/include/mach/vmalloc.h
index b00c51a..ec423b9 100644
--- a/arch/arm/mach-u300/include/mach/vmalloc.h
+++ b/arch/arm/mach-u300/include/mach/vmalloc.h
@@ -9,4 +9,4 @@
  * End must be above the I/O registers and on an even 2MiB boundary.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#define VMALLOC_END	0xfe800000
+#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-ux500/include/mach/vmalloc.h b/arch/arm/mach-ux500/include/mach/vmalloc.h
index 86cdbbc..a4945cb 100644
--- a/arch/arm/mach-ux500/include/mach/vmalloc.h
+++ b/arch/arm/mach-ux500/include/mach/vmalloc.h
@@ -15,4 +15,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END	0xf0000000
+#define VMALLOC_END	0xf0000000UL
diff --git a/arch/arm/mach-w90x900/include/mach/vmalloc.h b/arch/arm/mach-w90x900/include/mach/vmalloc.h
index 2f9dfb9..b067e44 100644
--- a/arch/arm/mach-w90x900/include/mach/vmalloc.h
+++ b/arch/arm/mach-w90x900/include/mach/vmalloc.h
@@ -18,6 +18,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	  (0xe0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c06edd3..f4d67bf 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -668,7 +668,7 @@ void __init mem_init(void)
 #ifdef CONFIG_MMU
 			MLM(CONSISTENT_BASE, CONSISTENT_END),
 #endif
-			MLM(VMALLOC_START, (unsigned long)VMALLOC_END),
+			MLM(VMALLOC_START, VMALLOC_END),
 			MLM(PAGE_SIZE, (unsigned long)high_memory),
 #ifdef CONFIG_HIGHMEM
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
diff --git a/arch/arm/plat-mxc/include/mach/vmalloc.h b/arch/arm/plat-mxc/include/mach/vmalloc.h
index 62d9762..44243a2 100644
--- a/arch/arm/plat-mxc/include/mach/vmalloc.h
+++ b/arch/arm/plat-mxc/include/mach/vmalloc.h
@@ -21,6 +21,6 @@
 #define __ASM_ARCH_MXC_VMALLOC_H__
 
 /* vmalloc ending address */
-#define VMALLOC_END       0xF4000000
+#define VMALLOC_END       0xf4000000UL
 
 #endif /* __ASM_ARCH_MXC_VMALLOC_H__ */
diff --git a/arch/arm/plat-s3c/include/mach/vmalloc.h b/arch/arm/plat-s3c/include/mach/vmalloc.h
index bfd2ca6..299d95f 100644
--- a/arch/arm/plat-s3c/include/mach/vmalloc.h
+++ b/arch/arm/plat-s3c/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	  (0xe0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/vmalloc.h b/arch/arm/plat-stmp3xxx/include/mach/vmalloc.h
index 541b880..943c1a2 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/vmalloc.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/vmalloc.h
@@ -9,4 +9,4 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
-#define VMALLOC_END       (0xF0000000)
+#define VMALLOC_END       0xf0000000UL
-- 
1.6.6
