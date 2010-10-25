From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Mon, 25 Oct 2010 12:53:57 -0200
Subject: [PATCH 1/4] mx31_3ds: Remove unused debug board definitions
Message-ID: <AANLkTi=GFQgwoVhv2UGZ+gpYKHYNrZi4p-A-x1Jk5=NO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit (c5d38f08): "mx31_3ds: revert 3ds debug board relate code"
the debug board definitions are placed in a separate file.

Remove the remaining debug board related define from mach-mx31_3ds.c.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 6fe69e1..bc21efc 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -38,39 +38,9 @@
 #include "devices-imx31.h"
 #include "devices.h"

-/* Definitions for components on the Debug board */
-
-/* Base address of CPLD controller on the Debug board */
-#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(MX3x_CS5_BASE_ADDR)
-
-/* LAN9217 ethernet base address */
-#define LAN9217_BASE_ADDR		MX3x_CS5_BASE_ADDR
-
-/* CPLD config and interrupt base address */
-#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
-
-/* status, interrupt */
-#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
-#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
-#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
-#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
-/* CPLD code version */
-#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
-
 /* CPLD IRQ line for external uart, external ethernet etc */
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)

-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
-
-#define MXC_MAX_EXP_IO_LINES	16
-
 /*
  * This file contains the board-specific initialization routines.
  */
-- 
1.7.0.4
