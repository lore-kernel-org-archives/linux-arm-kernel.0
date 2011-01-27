From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:47:27 +0000
Subject: [PATCH 05/11] ARM: versatile: remove old AMBA device DMA definitions
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSC7-0003p9-Ls@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AMBA DMA macro definitions are not used, and the AMBA Primecell DMA
support makes no use of them either, so they can be removed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/core.c         |   18 ------------------
 arch/arm/mach-versatile/core.h         |    1 -
 arch/arm/mach-versatile/versatile_pb.c |    5 -----
 3 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 606e046..630a1c9 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -634,53 +634,35 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 };
 
 #define AACI_IRQ	{ IRQ_AACI, NO_IRQ }
-#define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
-#define MMCI0_DMA	{ 0x84, 0 }
 #define KMI0_IRQ	{ IRQ_SIC_KMI0, NO_IRQ }
-#define KMI0_DMA	{ 0, 0 }
 #define KMI1_IRQ	{ IRQ_SIC_KMI1, NO_IRQ }
-#define KMI1_DMA	{ 0, 0 }
 
 /*
  * These devices are connected directly to the multi-layer AHB switch
  */
 #define SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define SMC_DMA		{ 0, 0 }
 #define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA	{ 0, 0 }
 #define CLCD_IRQ	{ IRQ_CLCDINT, NO_IRQ }
-#define CLCD_DMA	{ 0, 0 }
 #define DMAC_IRQ	{ IRQ_DMAINT, NO_IRQ }
-#define DMAC_DMA	{ 0, 0 }
 
 /*
  * These devices are connected via the core APB bridge
  */
 #define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA	{ 0, 0 }
 #define WATCHDOG_IRQ	{ IRQ_WDOGINT, NO_IRQ }
-#define WATCHDOG_DMA	{ 0, 0 }
 #define GPIO0_IRQ	{ IRQ_GPIOINT0, NO_IRQ }
-#define GPIO0_DMA	{ 0, 0 }
 #define GPIO1_IRQ	{ IRQ_GPIOINT1, NO_IRQ }
-#define GPIO1_DMA	{ 0, 0 }
 #define RTC_IRQ		{ IRQ_RTCINT, NO_IRQ }
-#define RTC_DMA		{ 0, 0 }
 
 /*
  * These devices are connected via the DMA APB bridge
  */
 #define SCI_IRQ		{ IRQ_SCIINT, NO_IRQ }
-#define SCI_DMA		{ 7, 6 }
 #define UART0_IRQ	{ IRQ_UARTINT0, NO_IRQ }
-#define UART0_DMA	{ 15, 14 }
 #define UART1_IRQ	{ IRQ_UARTINT1, NO_IRQ }
-#define UART1_DMA	{ 13, 12 }
 #define UART2_IRQ	{ IRQ_UARTINT2, NO_IRQ }
-#define UART2_DMA	{ 11, 10 }
 #define SSP_IRQ		{ IRQ_SSPINT, NO_IRQ }
-#define SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,  "fpga:04", AACI,     NULL);
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index e04768a..fd6404e 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -45,7 +45,6 @@ static struct amba_device name##_device = {			\
 	},							\
 	.dma_mask	= ~0,					\
 	.irq		= base##_IRQ,				\
-	/* .dma		= base##_DMA,*/				\
 }
 
 #endif
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 97fb306..37c23df 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -59,19 +59,14 @@ static struct pl061_platform_data gpio3_plat_data = {
 };
 
 #define UART3_IRQ	{ IRQ_SIC_UART3, NO_IRQ }
-#define UART3_DMA	{ 0x86, 0x87 }
 #define SCI1_IRQ	{ IRQ_SIC_SCI3, NO_IRQ }
-#define SCI1_DMA	{ 0x88, 0x89 }
 #define MMCI1_IRQ	{ IRQ_MMCI1A, IRQ_SIC_MMCI1B }
-#define MMCI1_DMA	{ 0x85, 0 }
 
 /*
  * These devices are connected via the core APB bridge
  */
 #define GPIO2_IRQ	{ IRQ_GPIOINT2, NO_IRQ }
-#define GPIO2_DMA	{ 0, 0 }
 #define GPIO3_IRQ	{ IRQ_GPIOINT3, NO_IRQ }
-#define GPIO3_DMA	{ 0, 0 }
 
 /*
  * These devices are connected via the DMA APB bridge
-- 
1.6.2.5
