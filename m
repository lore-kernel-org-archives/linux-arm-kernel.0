From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:02 -0500
Subject: [PATCH v2 06/15] ARM: integrator: remove trailing whitespace on
 pci_v3.c
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

No functional changes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-integrator/pci_v3.c |   46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 810f4ec..6f78aae 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -41,61 +41,61 @@
 /*
  * The V3 PCI interface chip in Integrator provides several windows from
  * local bus memory into the PCI memory areas.   Unfortunately, there
- * are not really enough windows for our usage, therefore we reuse 
+ * are not really enough windows for our usage, therefore we reuse
  * one of the windows for access to PCI configuration space.  The
  * memory map is as follows:
- * 
+ *
  * Local Bus Memory         Usage
- * 
+ *
  * 40000000 - 4FFFFFFF      PCI memory.  256M non-prefetchable
  * 50000000 - 5FFFFFFF      PCI memory.  256M prefetchable
  * 60000000 - 60FFFFFF      PCI IO.  16M
  * 61000000 - 61FFFFFF      PCI Configuration. 16M
- * 
+ *
  * There are three V3 windows, each described by a pair of V3 registers.
  * These are LB_BASE0/LB_MAP0, LB_BASE1/LB_MAP1 and LB_BASE2/LB_MAP2.
  * Base0 and Base1 can be used for any type of PCI memory access.   Base2
  * can be used either for PCI I/O or for I20 accesses.  By default, uHAL
  * uses this only for PCI IO space.
- * 
+ *
  * Normally these spaces are mapped using the following base registers:
- * 
+ *
  * Usage Local Bus Memory         Base/Map registers used
- * 
+ *
  * Mem   40000000 - 4FFFFFFF      LB_BASE0/LB_MAP0
  * Mem   50000000 - 5FFFFFFF      LB_BASE1/LB_MAP1
  * IO    60000000 - 60FFFFFF      LB_BASE2/LB_MAP2
  * Cfg   61000000 - 61FFFFFF
- * 
+ *
  * This means that I20 and PCI configuration space accesses will fail.
- * When PCI configuration accesses are needed (via the uHAL PCI 
+ * When PCI configuration accesses are needed (via the uHAL PCI
  * configuration space primitives) we must remap the spaces as follows:
- * 
+ *
  * Usage Local Bus Memory         Base/Map registers used
- * 
+ *
  * Mem   40000000 - 4FFFFFFF      LB_BASE0/LB_MAP0
  * Mem   50000000 - 5FFFFFFF      LB_BASE0/LB_MAP0
  * IO    60000000 - 60FFFFFF      LB_BASE2/LB_MAP2
  * Cfg   61000000 - 61FFFFFF      LB_BASE1/LB_MAP1
- * 
+ *
  * To make this work, the code depends on overlapping windows working.
- * The V3 chip translates an address by checking its range within 
+ * The V3 chip translates an address by checking its range within
  * each of the BASE/MAP pairs in turn (in ascending register number
  * order).  It will use the first matching pair.   So, for example,
  * if the same address is mapped by both LB_BASE0/LB_MAP0 and
- * LB_BASE1/LB_MAP1, the V3 will use the translation from 
+ * LB_BASE1/LB_MAP1, the V3 will use the translation from
  * LB_BASE0/LB_MAP0.
- * 
+ *
  * To allow PCI Configuration space access, the code enlarges the
  * window mapped by LB_BASE0/LB_MAP0 from 256M to 512M.  This occludes
  * the windows currently mapped by LB_BASE1/LB_MAP1 so that it can
  * be remapped for use by configuration cycles.
- * 
- * At the end of the PCI Configuration space accesses, 
+ *
+ * At the end of the PCI Configuration space accesses,
  * LB_BASE1/LB_MAP1 is reset to map PCI Memory.  Finally the window
  * mapped by LB_BASE0/LB_MAP0 is reduced in size from 512M to 256M to
  * reveal the now restored LB_BASE1/LB_MAP1 window.
- * 
+ *
  * NOTE: We do not set up I2O mapping.  I suspect that this is only
  * for an intelligent (target) device.  Using I2O disables most of
  * the mappings into PCI memory.
@@ -127,8 +127,8 @@
  *
  * returns:	configuration address to play on the PCI bus
  *
- * To generate the appropriate PCI configuration cycles in the PCI 
- * configuration address space, you present the V3 with the following pattern 
+ * To generate the appropriate PCI configuration cycles in the PCI
+ * configuration address space, you present the V3 with the following pattern
  * (which is very nearly a type 1 (except that the lower two bits are 00 and
  * not 01).   In order for this mapping to work you need to set up one of
  * the local to PCI aperatures to 16Mbytes in length translating to
@@ -138,7 +138,7 @@
  *
  * Type 0:
  *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
+ *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1
  *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  * | | |D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|D|F|F|F|R|R|R|R|R|R|0|0|
@@ -150,7 +150,7 @@
  *
  * Type 1:
  *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
+ *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1
  *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  * | | | | | | | | | | |B|B|B|B|B|B|B|B|D|D|D|D|D|F|F|F|R|R|R|R|R|R|0|1|
@@ -161,7 +161,7 @@
  *	15:11	Device number (5 bits)
  *	10:8	function number
  *	 7:2	register number
- *  
+ *
  */
 static DEFINE_RAW_SPINLOCK(v3_lock);
 
-- 
1.7.9.5
