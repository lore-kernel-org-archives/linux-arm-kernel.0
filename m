From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:56 +0530
Subject: [PATCH 4/9] ux500: remove ambiguous irq macros
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the irq number macros which don't specify which SoC they're for.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c      |    6 ++--
 arch/arm/mach-ux500/include/mach/irqs.h |   44 -------------------------------
 arch/arm/mach-ux500/prcmu.c             |    3 +-
 3 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 8edc27f..287956c 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -98,9 +98,9 @@ static struct ab8500_platform_data ab8500_platdata = {
 
 static struct resource ab8500_resources[] = {
 	[0] = {
-		.start = IRQ_AB8500,
-		.end = IRQ_AB8500,
-		.flags = IORESOURCE_IRQ
+		.start	= IRQ_DB8500_AB8500,
+		.end	= IRQ_DB8500_AB8500,
+		.flags	= IORESOURCE_IRQ
 	}
 };
 
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 693aa57..880ae45 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -21,50 +21,6 @@
 
 /* Interrupt numbers generic for shared peripheral */
 #define IRQ_MTU0		(IRQ_SHPI_START + 4)
-#define IRQ_SPI2		(IRQ_SHPI_START + 6)
-#define IRQ_SPI0		(IRQ_SHPI_START + 8)
-#define IRQ_UART0		(IRQ_SHPI_START + 11)
-#define IRQ_I2C3		(IRQ_SHPI_START + 12)
-#define IRQ_SSP0		(IRQ_SHPI_START + 14)
-#define IRQ_MTU1		(IRQ_SHPI_START + 17)
-#define IRQ_RTC_RTT		(IRQ_SHPI_START + 18)
-#define IRQ_UART1		(IRQ_SHPI_START + 19)
-#define IRQ_I2C0		(IRQ_SHPI_START + 21)
-#define IRQ_I2C1		(IRQ_SHPI_START + 22)
-#define IRQ_USBOTG		(IRQ_SHPI_START + 23)
-#define IRQ_DMA			(IRQ_SHPI_START + 25)
-#define IRQ_UART2		(IRQ_SHPI_START + 26)
-#define IRQ_HSIR_EXCEP		(IRQ_SHPI_START + 29)
-#define IRQ_MSP0		(IRQ_SHPI_START + 31)
-#define IRQ_HSIR_CH0_OVRRUN	(IRQ_SHPI_START + 32)
-#define IRQ_HSIR_CH1_OVRRUN	(IRQ_SHPI_START + 33)
-#define IRQ_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
-#define IRQ_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
-#define IRQ_AB8500		(IRQ_SHPI_START + 40)
-#define IRQ_PRCMU               (IRQ_SHPI_START + 47)
-#define IRQ_DISP		(IRQ_SHPI_START + 48)
-#define IRQ_SiPI3		(IRQ_SHPI_START + 49)
-#define IRQ_I2C4		(IRQ_SHPI_START + 51)
-#define IRQ_SSP1		(IRQ_SHPI_START + 52)
-#define IRQ_I2C2		(IRQ_SHPI_START + 55)
-#define IRQ_SDMMC0		(IRQ_SHPI_START + 60)
-#define IRQ_MSP1		(IRQ_SHPI_START + 62)
-#define IRQ_SPI1		(IRQ_SHPI_START + 96)
-#define IRQ_MSP2		(IRQ_SHPI_START + 98)
-#define IRQ_SDMMC4		(IRQ_SHPI_START + 99)
-#define IRQ_HSIRD0		(IRQ_SHPI_START + 104)
-#define IRQ_HSIRD1		(IRQ_SHPI_START + 105)
-#define IRQ_HSITD0		(IRQ_SHPI_START + 106)
-#define IRQ_HSITD1		(IRQ_SHPI_START + 107)
-#define IRQ_GPIO0		(IRQ_SHPI_START + 119)
-#define IRQ_GPIO1		(IRQ_SHPI_START + 120)
-#define IRQ_GPIO2		(IRQ_SHPI_START + 121)
-#define IRQ_GPIO3		(IRQ_SHPI_START + 122)
-#define IRQ_GPIO4		(IRQ_SHPI_START + 123)
-#define IRQ_GPIO5		(IRQ_SHPI_START + 124)
-#define IRQ_GPIO6		(IRQ_SHPI_START + 125)
-#define IRQ_GPIO7		(IRQ_SHPI_START + 126)
-#define IRQ_GPIO8		(IRQ_SHPI_START + 127)
 
 /* There are 128 shared peripheral interrupts assigned to
  * INTID[160:32]. The first 32 interrupts are reserved.
diff --git a/arch/arm/mach-ux500/prcmu.c b/arch/arm/mach-ux500/prcmu.c
index 3ba3e32..07d5f13 100644
--- a/arch/arm/mach-ux500/prcmu.c
+++ b/arch/arm/mach-ux500/prcmu.c
@@ -240,7 +240,8 @@ static int __init prcmu_init(void)
 	/* Clean up the mailbox interrupts after pre-kernel code. */
 	writel((MBOX_BIT(NUM_MBOX) - 1), PRCM_ARM_IT1_CLEAR);
 
-	return request_irq(IRQ_PRCMU, prcmu_irq_handler, 0, "prcmu", NULL);
+	return request_irq(IRQ_DB8500_PRCMU1, prcmu_irq_handler, 0,
+			   "prcmu", NULL);
 }
 
 arch_initcall(prcmu_init);
-- 
1.7.2.dirty
