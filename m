From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:15 +0200
Subject: [PATCH v4 02/17] arm: mach-kirkwood: use plus instead of or for
 address definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are going to use IOMEM() to define many base virtual
addresses, we can no longer use binary or to define the individual
register addresses ("binary or" arithmetic on pointers is not
allowed). Instead, use the more conventional plus operator to do so.

The binary or operators were actually not useful because the low-order
bits of the base address were always zero, so the usage of the binary
or operators was effectively identical to a plus operator.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |   20 ++--
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |  110 ++++++++++-----------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index a115142..5c82b7d 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -13,37 +13,37 @@
 
 #include <mach/kirkwood.h>
 
-#define CPU_CONFIG		(BRIDGE_VIRT_BASE | 0x0100)
+#define CPU_CONFIG		(BRIDGE_VIRT_BASE + 0x0100)
 #define CPU_CONFIG_ERROR_PROP	0x00000004
 
-#define CPU_CONTROL		(BRIDGE_VIRT_BASE | 0x0104)
+#define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
 #define CPU_RESET		0x00000002
 
-#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE | 0x0108)
+#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
 #define WDT_RESET_OUT_EN	0x00000002
 #define SOFT_RESET_OUT_EN	0x00000004
 
-#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
+#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
 
-#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
+#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
 #define WDT_INT_REQ		0x0008
 
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
-#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
+#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
 #define IRQ_CAUSE_LOW_OFF	0x0000
 #define IRQ_MASK_LOW_OFF	0x0004
 #define IRQ_CAUSE_HIGH_OFF	0x0010
 #define IRQ_MASK_HIGH_OFF	0x0014
 
-#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
-#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE | 0x0300)
+#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
+#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
 
-#define L2_CONFIG_REG		(BRIDGE_VIRT_BASE | 0x0128)
+#define L2_CONFIG_REG		(BRIDGE_VIRT_BASE + 0x0128)
 #define L2_WRITETHROUGH		0x00000010
 
-#define CLOCK_GATING_CTRL	(BRIDGE_VIRT_BASE | 0x11c)
+#define CLOCK_GATING_CTRL	(BRIDGE_VIRT_BASE + 0x11c)
 #define CGC_BIT_GE0		(0)
 #define CGC_BIT_PEX0		(2)
 #define CGC_BIT_USB0		(3)
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index c5b6851..9695592 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -61,61 +61,61 @@
 /*
  * Register Map
  */
-#define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x00000)
-#define  DDR_WINDOW_CPU_BASE	(DDR_VIRT_BASE | 0x1500)
-#define DDR_OPERATION_BASE	(DDR_VIRT_BASE | 0x1418)
-
-#define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x10000)
-#define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x10000)
-#define  SAMPLE_AT_RESET	(DEV_BUS_VIRT_BASE | 0x0030)
-#define  DEVICE_ID		(DEV_BUS_VIRT_BASE | 0x0034)
-#define  GPIO_LOW_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x0100)
-#define  GPIO_HIGH_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x0140)
-#define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0300)
-#define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0600)
-#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x1000)
-#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
-#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2000)
-#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2100)
-#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2100)
-
-#define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x20000)
-#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x20000)
-
-#define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x30000)
-
-#define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x40000)
-#define PCIE_LINK_CTRL		(PCIE_VIRT_BASE | 0x70)
-#define PCIE_STATUS		(PCIE_VIRT_BASE | 0x1a04)
-#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x44000)
-#define PCIE1_LINK_CTRL		(PCIE1_VIRT_BASE | 0x70)
-#define PCIE1_STATUS		(PCIE1_VIRT_BASE | 0x1a04)
-
-#define USB_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x50000)
-
-#define XOR0_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x60800)
-#define XOR0_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x60800)
-#define XOR1_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x60900)
-#define XOR1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x60900)
-#define XOR0_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x60A00)
-#define XOR0_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x60A00)
-#define XOR1_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE | 0x60B00)
-#define XOR1_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x60B00)
-
-#define GE00_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x70000)
-#define GE01_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x74000)
-
-#define SATA_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x80000)
-#define SATA_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x80000)
-#define SATA0_IF_CTRL		(SATA_VIRT_BASE | 0x2050)
-#define SATA0_PHY_MODE_2	(SATA_VIRT_BASE | 0x2330)
-#define SATA1_IF_CTRL		(SATA_VIRT_BASE | 0x4050)
-#define SATA1_PHY_MODE_2	(SATA_VIRT_BASE | 0x4330)
-
-#define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x90000)
-
-#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0xA0000)
-#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0xA0000)
+#define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x00000)
+#define  DDR_WINDOW_CPU_BASE	(DDR_VIRT_BASE + 0x1500)
+#define DDR_OPERATION_BASE	(DDR_VIRT_BASE + 0x1418)
+
+#define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x10000)
+#define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x10000)
+#define  SAMPLE_AT_RESET	(DEV_BUS_VIRT_BASE + 0x0030)
+#define  DEVICE_ID		(DEV_BUS_VIRT_BASE + 0x0034)
+#define  GPIO_LOW_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0100)
+#define  GPIO_HIGH_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0140)
+#define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0300)
+#define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0600)
+#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x1000)
+#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2000)
+#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2000)
+#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2100)
+#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2100)
+
+#define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x20000)
+#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
+
+#define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x30000)
+
+#define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x40000)
+#define PCIE_LINK_CTRL		(PCIE_VIRT_BASE + 0x70)
+#define PCIE_STATUS		(PCIE_VIRT_BASE + 0x1a04)
+#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x44000)
+#define PCIE1_LINK_CTRL		(PCIE1_VIRT_BASE + 0x70)
+#define PCIE1_STATUS		(PCIE1_VIRT_BASE + 0x1a04)
+
+#define USB_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x50000)
+
+#define XOR0_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60800)
+#define XOR0_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60800)
+#define XOR1_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60900)
+#define XOR1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60900)
+#define XOR0_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60A00)
+#define XOR0_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60A00)
+#define XOR1_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60B00)
+#define XOR1_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60B00)
+
+#define GE00_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x70000)
+#define GE01_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x74000)
+
+#define SATA_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x80000)
+#define SATA_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x80000)
+#define SATA0_IF_CTRL		(SATA_VIRT_BASE + 0x2050)
+#define SATA0_PHY_MODE_2	(SATA_VIRT_BASE + 0x2330)
+#define SATA1_IF_CTRL		(SATA_VIRT_BASE + 0x4050)
+#define SATA1_PHY_MODE_2	(SATA_VIRT_BASE + 0x4330)
+
+#define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x90000)
+
+#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0xA0000)
+#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0xA0000)
 
 /*
  * Supported devices and revisions.
-- 
1.7.9.5
