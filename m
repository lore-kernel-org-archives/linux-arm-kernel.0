From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  2 Jan 2013 22:41:20 +0100
Subject: [PATCH 2/2] ARM: nomadik: bump the IRQ numbers again
Message-ID: <1357162880-6954-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bump the IRQ numbers from offset at 1 (right above NO_IRQ)
to 32. This is the painful way to learn that if you're using
SPARSE_IRQ and avoid to define .nr_irqs in your machine,
the first 16 IRQs will be pre-allocated, and the IRQdomain
code (as the VIC core code before it) will then assume
that all IRQ descriptors are pre-allocated, and 16 of them
are - by somebody else. So mapping the IRQs will fail in
irq_create_mapping(). Moving the offset upward rids us of
this problem.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/include/mach/irqs.h | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
index b549d05..215f8cd 100644
--- a/arch/arm/mach-nomadik/include/mach/irqs.h
+++ b/arch/arm/mach-nomadik/include/mach/irqs.h
@@ -22,49 +22,49 @@
 
 #include <mach/hardware.h>
 
-#define IRQ_VIC_START		1	/* first VIC interrupt is 1 */
+#define IRQ_VIC_START		32	/* first VIC interrupt is 1 */
 
 /*
  * Interrupt numbers generic for all Nomadik Chip cuts
  */
-#define IRQ_WATCHDOG			1
-#define IRQ_SOFTINT			2
-#define IRQ_CRYPTO			3
-#define IRQ_OWM				4
-#define IRQ_MTU0			5
-#define IRQ_MTU1			6
-#define IRQ_GPIO0			7
-#define IRQ_GPIO1			8
-#define IRQ_GPIO2			9
-#define IRQ_GPIO3			10
-#define IRQ_RTC_RTT			11
-#define IRQ_SSP				12
-#define IRQ_UART0			13
-#define IRQ_DMA1			14
-#define IRQ_CLCD_MDIF			15
-#define IRQ_DMA0			16
-#define IRQ_PWRFAIL			17
-#define IRQ_UART1			18
-#define IRQ_FIRDA			19
-#define IRQ_MSP0			20
-#define IRQ_I2C0			21
-#define IRQ_I2C1			22
-#define IRQ_SDMMC			23
-#define IRQ_USBOTG			24
-#define IRQ_SVA_IT0			25
-#define IRQ_SVA_IT1			26
-#define IRQ_SAA_IT0			27
-#define IRQ_SAA_IT1			28
-#define IRQ_UART2			29
-#define IRQ_MSP2			30
-#define IRQ_L2CC			49
-#define IRQ_HPI				50
-#define IRQ_SKE				51
-#define IRQ_KP				52
-#define IRQ_MEMST			55
-#define IRQ_SGA_IT			59
-#define IRQ_USBM			61
-#define IRQ_MSP1			63
+#define IRQ_WATCHDOG			(IRQ_VIC_START+0)
+#define IRQ_SOFTINT			(IRQ_VIC_START+1)
+#define IRQ_CRYPTO			(IRQ_VIC_START+2)
+#define IRQ_OWM				(IRQ_VIC_START+3)
+#define IRQ_MTU0			(IRQ_VIC_START+4)
+#define IRQ_MTU1			(IRQ_VIC_START+5)
+#define IRQ_GPIO0			(IRQ_VIC_START+6)
+#define IRQ_GPIO1			(IRQ_VIC_START+7)
+#define IRQ_GPIO2			(IRQ_VIC_START+8)
+#define IRQ_GPIO3			(IRQ_VIC_START+9)
+#define IRQ_RTC_RTT			(IRQ_VIC_START+10)
+#define IRQ_SSP				(IRQ_VIC_START+11)
+#define IRQ_UART0			(IRQ_VIC_START+12)
+#define IRQ_DMA1			(IRQ_VIC_START+13)
+#define IRQ_CLCD_MDIF			(IRQ_VIC_START+14)
+#define IRQ_DMA0			(IRQ_VIC_START+15)
+#define IRQ_PWRFAIL			(IRQ_VIC_START+16)
+#define IRQ_UART1			(IRQ_VIC_START+17)
+#define IRQ_FIRDA			(IRQ_VIC_START+18)
+#define IRQ_MSP0			(IRQ_VIC_START+19)
+#define IRQ_I2C0			(IRQ_VIC_START+20)
+#define IRQ_I2C1			(IRQ_VIC_START+21)
+#define IRQ_SDMMC			(IRQ_VIC_START+22)
+#define IRQ_USBOTG			(IRQ_VIC_START+23)
+#define IRQ_SVA_IT0			(IRQ_VIC_START+24)
+#define IRQ_SVA_IT1			(IRQ_VIC_START+25)
+#define IRQ_SAA_IT0			(IRQ_VIC_START+26)
+#define IRQ_SAA_IT1			(IRQ_VIC_START+27)
+#define IRQ_UART2			(IRQ_VIC_START+28)
+#define IRQ_MSP2			(IRQ_VIC_START+29)
+#define IRQ_L2CC			(IRQ_VIC_START+30)
+#define IRQ_HPI				(IRQ_VIC_START+31)
+#define IRQ_SKE				(IRQ_VIC_START+32)
+#define IRQ_KP				(IRQ_VIC_START+33)
+#define IRQ_MEMST			(IRQ_VIC_START+34)
+#define IRQ_SGA_IT			(IRQ_VIC_START+35)
+#define IRQ_USBM			(IRQ_VIC_START+36)
+#define IRQ_MSP1			(IRQ_VIC_START+37)
 
 #define NOMADIK_GPIO_OFFSET		(IRQ_VIC_START+64)
 
-- 
1.7.11.7
