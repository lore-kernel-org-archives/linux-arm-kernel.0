From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:47:48 +0000
Subject: [PATCH 06/11] ARM: realview: remove old AMBA device DMA definitions
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSCS-0003pD-3F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AMBA DMA macro definitions are not used, and the AMBA Primecell DMA
support makes no use of them either, so they can be removed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.h            |    1 -
 arch/arm/mach-realview/realview_eb.c     |   21 ---------------------
 arch/arm/mach-realview/realview_pb1176.c |   21 ---------------------
 arch/arm/mach-realview/realview_pb11mp.c |   21 ---------------------
 arch/arm/mach-realview/realview_pba8.c   |   21 ---------------------
 arch/arm/mach-realview/realview_pbx.c    |   21 ---------------------
 6 files changed, 0 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 27c9273..5c83d1e 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -42,7 +42,6 @@ static struct amba_device name##_device = {			\
 	},							\
 	.dma_mask	= ~0,					\
 	.irq		= base##_IRQ,				\
-	/* .dma		= base##_DMA,*/				\
 }
 
 struct machine_desc;
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index c00e527..d0f851b 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -144,60 +144,39 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * These devices are connected via the core APB bridge
  */
 #define GPIO2_IRQ	{ IRQ_EB_GPIO2, NO_IRQ }
-#define GPIO2_DMA	{ 0, 0 }
 #define GPIO3_IRQ	{ IRQ_EB_GPIO3, NO_IRQ }
-#define GPIO3_DMA	{ 0, 0 }
 
 #define AACI_IRQ	{ IRQ_EB_AACI, NO_IRQ }
-#define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_EB_MMCI0A, IRQ_EB_MMCI0B }
-#define MMCI0_DMA	{ 0x84, 0 }
 #define KMI0_IRQ	{ IRQ_EB_KMI0, NO_IRQ }
-#define KMI0_DMA	{ 0, 0 }
 #define KMI1_IRQ	{ IRQ_EB_KMI1, NO_IRQ }
-#define KMI1_DMA	{ 0, 0 }
 
 /*
  * These devices are connected directly to the multi-layer AHB switch
  */
 #define EB_SMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define EB_SMC_DMA	{ 0, 0 }
 #define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA	{ 0, 0 }
 #define EB_CLCD_IRQ	{ IRQ_EB_CLCD, NO_IRQ }
-#define EB_CLCD_DMA	{ 0, 0 }
 #define DMAC_IRQ	{ IRQ_EB_DMA, NO_IRQ }
-#define DMAC_DMA	{ 0, 0 }
 
 /*
  * These devices are connected via the core APB bridge
  */
 #define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA	{ 0, 0 }
 #define EB_WATCHDOG_IRQ	{ IRQ_EB_WDOG, NO_IRQ }
-#define EB_WATCHDOG_DMA	{ 0, 0 }
 #define EB_GPIO0_IRQ	{ IRQ_EB_GPIO0, NO_IRQ }
-#define EB_GPIO0_DMA	{ 0, 0 }
 #define GPIO1_IRQ	{ IRQ_EB_GPIO1, NO_IRQ }
-#define GPIO1_DMA	{ 0, 0 }
 #define EB_RTC_IRQ	{ IRQ_EB_RTC, NO_IRQ }
-#define EB_RTC_DMA	{ 0, 0 }
 
 /*
  * These devices are connected via the DMA APB bridge
  */
 #define SCI_IRQ		{ IRQ_EB_SCI, NO_IRQ }
-#define SCI_DMA		{ 7, 6 }
 #define EB_UART0_IRQ	{ IRQ_EB_UART0, NO_IRQ }
-#define EB_UART0_DMA	{ 15, 14 }
 #define EB_UART1_IRQ	{ IRQ_EB_UART1, NO_IRQ }
-#define EB_UART1_DMA	{ 13, 12 }
 #define EB_UART2_IRQ	{ IRQ_EB_UART2, NO_IRQ }
-#define EB_UART2_DMA	{ 11, 10 }
 #define EB_UART3_IRQ	{ IRQ_EB_UART3, NO_IRQ }
-#define EB_UART3_DMA	{ 0x86, 0x87 }
 #define EB_SSP_IRQ	{ IRQ_EB_SSP, NO_IRQ }
-#define EB_SSP_DMA	{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,  "fpga:aaci",  AACI,     NULL);
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index f0447bb..61f6a9d 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -134,47 +134,26 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * RealView PB1176 AMBA devices
  */
 #define GPIO2_IRQ	{ IRQ_PB1176_GPIO2, NO_IRQ }
-#define GPIO2_DMA	{ 0, 0 }
 #define GPIO3_IRQ	{ IRQ_PB1176_GPIO3, NO_IRQ }
-#define GPIO3_DMA	{ 0, 0 }
 #define AACI_IRQ	{ IRQ_PB1176_AACI, NO_IRQ }
-#define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_PB1176_MMCI0A, IRQ_PB1176_MMCI0B }
-#define MMCI0_DMA	{ 0x84, 0 }
 #define KMI0_IRQ	{ IRQ_PB1176_KMI0, NO_IRQ }
-#define KMI0_DMA	{ 0, 0 }
 #define KMI1_IRQ	{ IRQ_PB1176_KMI1, NO_IRQ }
-#define KMI1_DMA	{ 0, 0 }
 #define PB1176_SMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define PB1176_SMC_DMA	{ 0, 0 }
 #define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA	{ 0, 0 }
 #define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD, NO_IRQ }
-#define PB1176_CLCD_DMA	{ 0, 0 }
 #define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA	{ 0, 0 }
 #define PB1176_WATCHDOG_IRQ	{ IRQ_DC1176_WATCHDOG, NO_IRQ }
-#define PB1176_WATCHDOG_DMA	{ 0, 0 }
 #define PB1176_GPIO0_IRQ	{ IRQ_PB1176_GPIO0, NO_IRQ }
-#define PB1176_GPIO0_DMA	{ 0, 0 }
 #define GPIO1_IRQ	{ IRQ_PB1176_GPIO1, NO_IRQ }
-#define GPIO1_DMA	{ 0, 0 }
 #define PB1176_RTC_IRQ	{ IRQ_DC1176_RTC, NO_IRQ }
-#define PB1176_RTC_DMA	{ 0, 0 }
 #define SCI_IRQ		{ IRQ_PB1176_SCI, NO_IRQ }
-#define SCI_DMA		{ 7, 6 }
 #define PB1176_UART0_IRQ	{ IRQ_DC1176_UART0, NO_IRQ }
-#define PB1176_UART0_DMA	{ 15, 14 }
 #define PB1176_UART1_IRQ	{ IRQ_DC1176_UART1, NO_IRQ }
-#define PB1176_UART1_DMA	{ 13, 12 }
 #define PB1176_UART2_IRQ	{ IRQ_DC1176_UART2, NO_IRQ }
-#define PB1176_UART2_DMA	{ 11, 10 }
 #define PB1176_UART3_IRQ	{ IRQ_DC1176_UART3, NO_IRQ }
-#define PB1176_UART3_DMA	{ 0x86, 0x87 }
 #define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4, NO_IRQ }
-#define PB1176_UART4_DMA	{ 0, 0 }
 #define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP, NO_IRQ }
-#define PB1176_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 3b4f788..27bfeca 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -136,47 +136,26 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  */
 
 #define GPIO2_IRQ		{ IRQ_PB11MP_GPIO2, NO_IRQ }
-#define GPIO2_DMA		{ 0, 0 }
 #define GPIO3_IRQ		{ IRQ_PB11MP_GPIO3, NO_IRQ }
-#define GPIO3_DMA		{ 0, 0 }
 #define AACI_IRQ		{ IRQ_TC11MP_AACI, NO_IRQ }
-#define AACI_DMA		{ 0x80, 0x81 }
 #define MMCI0_IRQ		{ IRQ_TC11MP_MMCI0A, IRQ_TC11MP_MMCI0B }
-#define MMCI0_DMA		{ 0x84, 0 }
 #define KMI0_IRQ		{ IRQ_TC11MP_KMI0, NO_IRQ }
-#define KMI0_DMA		{ 0, 0 }
 #define KMI1_IRQ		{ IRQ_TC11MP_KMI1, NO_IRQ }
-#define KMI1_DMA		{ 0, 0 }
 #define PB11MP_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PB11MP_SMC_DMA		{ 0, 0 }
 #define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA		{ 0, 0 }
 #define PB11MP_CLCD_IRQ		{ IRQ_PB11MP_CLCD, NO_IRQ }
-#define PB11MP_CLCD_DMA		{ 0, 0 }
 #define DMAC_IRQ		{ IRQ_PB11MP_DMAC, NO_IRQ }
-#define DMAC_DMA		{ 0, 0 }
 #define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA		{ 0, 0 }
 #define PB11MP_WATCHDOG_IRQ	{ IRQ_PB11MP_WATCHDOG, NO_IRQ }
-#define PB11MP_WATCHDOG_DMA	{ 0, 0 }
 #define PB11MP_GPIO0_IRQ	{ IRQ_PB11MP_GPIO0, NO_IRQ }
-#define PB11MP_GPIO0_DMA	{ 0, 0 }
 #define GPIO1_IRQ		{ IRQ_PB11MP_GPIO1, NO_IRQ }
-#define GPIO1_DMA		{ 0, 0 }
 #define PB11MP_RTC_IRQ		{ IRQ_TC11MP_RTC, NO_IRQ }
-#define PB11MP_RTC_DMA		{ 0, 0 }
 #define SCI_IRQ			{ IRQ_PB11MP_SCI, NO_IRQ }
-#define SCI_DMA			{ 7, 6 }
 #define PB11MP_UART0_IRQ	{ IRQ_TC11MP_UART0, NO_IRQ }
-#define PB11MP_UART0_DMA	{ 15, 14 }
 #define PB11MP_UART1_IRQ	{ IRQ_TC11MP_UART1, NO_IRQ }
-#define PB11MP_UART1_DMA	{ 13, 12 }
 #define PB11MP_UART2_IRQ	{ IRQ_PB11MP_UART2, NO_IRQ }
-#define PB11MP_UART2_DMA	{ 11, 10 }
 #define PB11MP_UART3_IRQ	{ IRQ_PB11MP_UART3, NO_IRQ }
-#define PB11MP_UART3_DMA	{ 0x86, 0x87 }
 #define PB11MP_SSP_IRQ		{ IRQ_PB11MP_SSP, NO_IRQ }
-#define PB11MP_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index f98d4fa..11972df 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -126,47 +126,26 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  */
 
 #define GPIO2_IRQ		{ IRQ_PBA8_GPIO2, NO_IRQ }
-#define GPIO2_DMA		{ 0, 0 }
 #define GPIO3_IRQ		{ IRQ_PBA8_GPIO3, NO_IRQ }
-#define GPIO3_DMA		{ 0, 0 }
 #define AACI_IRQ		{ IRQ_PBA8_AACI, NO_IRQ }
-#define AACI_DMA		{ 0x80, 0x81 }
 #define MMCI0_IRQ		{ IRQ_PBA8_MMCI0A, IRQ_PBA8_MMCI0B }
-#define MMCI0_DMA		{ 0x84, 0 }
 #define KMI0_IRQ		{ IRQ_PBA8_KMI0, NO_IRQ }
-#define KMI0_DMA		{ 0, 0 }
 #define KMI1_IRQ		{ IRQ_PBA8_KMI1, NO_IRQ }
-#define KMI1_DMA		{ 0, 0 }
 #define PBA8_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBA8_SMC_DMA		{ 0, 0 }
 #define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA		{ 0, 0 }
 #define PBA8_CLCD_IRQ		{ IRQ_PBA8_CLCD, NO_IRQ }
-#define PBA8_CLCD_DMA		{ 0, 0 }
 #define DMAC_IRQ		{ IRQ_PBA8_DMAC, NO_IRQ }
-#define DMAC_DMA		{ 0, 0 }
 #define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA		{ 0, 0 }
 #define PBA8_WATCHDOG_IRQ	{ IRQ_PBA8_WATCHDOG, NO_IRQ }
-#define PBA8_WATCHDOG_DMA	{ 0, 0 }
 #define PBA8_GPIO0_IRQ		{ IRQ_PBA8_GPIO0, NO_IRQ }
-#define PBA8_GPIO0_DMA		{ 0, 0 }
 #define GPIO1_IRQ		{ IRQ_PBA8_GPIO1, NO_IRQ }
-#define GPIO1_DMA		{ 0, 0 }
 #define PBA8_RTC_IRQ		{ IRQ_PBA8_RTC, NO_IRQ }
-#define PBA8_RTC_DMA		{ 0, 0 }
 #define SCI_IRQ			{ IRQ_PBA8_SCI, NO_IRQ }
-#define SCI_DMA			{ 7, 6 }
 #define PBA8_UART0_IRQ		{ IRQ_PBA8_UART0, NO_IRQ }
-#define PBA8_UART0_DMA		{ 15, 14 }
 #define PBA8_UART1_IRQ		{ IRQ_PBA8_UART1, NO_IRQ }
-#define PBA8_UART1_DMA		{ 13, 12 }
 #define PBA8_UART2_IRQ		{ IRQ_PBA8_UART2, NO_IRQ }
-#define PBA8_UART2_DMA		{ 11, 10 }
 #define PBA8_UART3_IRQ		{ IRQ_PBA8_UART3, NO_IRQ }
-#define PBA8_UART3_DMA		{ 0x86, 0x87 }
 #define PBA8_SSP_IRQ		{ IRQ_PBA8_SSP, NO_IRQ }
-#define PBA8_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index b0521e1..73ab3ca 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -148,47 +148,26 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  */
 
 #define GPIO2_IRQ		{ IRQ_PBX_GPIO2, NO_IRQ }
-#define GPIO2_DMA		{ 0, 0 }
 #define GPIO3_IRQ		{ IRQ_PBX_GPIO3, NO_IRQ }
-#define GPIO3_DMA		{ 0, 0 }
 #define AACI_IRQ		{ IRQ_PBX_AACI, NO_IRQ }
-#define AACI_DMA		{ 0x80, 0x81 }
 #define MMCI0_IRQ		{ IRQ_PBX_MMCI0A, IRQ_PBX_MMCI0B }
-#define MMCI0_DMA		{ 0x84, 0 }
 #define KMI0_IRQ		{ IRQ_PBX_KMI0, NO_IRQ }
-#define KMI0_DMA		{ 0, 0 }
 #define KMI1_IRQ		{ IRQ_PBX_KMI1, NO_IRQ }
-#define KMI1_DMA		{ 0, 0 }
 #define PBX_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBX_SMC_DMA		{ 0, 0 }
 #define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_DMA		{ 0, 0 }
 #define PBX_CLCD_IRQ		{ IRQ_PBX_CLCD, NO_IRQ }
-#define PBX_CLCD_DMA		{ 0, 0 }
 #define DMAC_IRQ		{ IRQ_PBX_DMAC, NO_IRQ }
-#define DMAC_DMA		{ 0, 0 }
 #define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define SCTL_DMA		{ 0, 0 }
 #define PBX_WATCHDOG_IRQ	{ IRQ_PBX_WATCHDOG, NO_IRQ }
-#define PBX_WATCHDOG_DMA	{ 0, 0 }
 #define PBX_GPIO0_IRQ		{ IRQ_PBX_GPIO0, NO_IRQ }
-#define PBX_GPIO0_DMA		{ 0, 0 }
 #define GPIO1_IRQ		{ IRQ_PBX_GPIO1, NO_IRQ }
-#define GPIO1_DMA		{ 0, 0 }
 #define PBX_RTC_IRQ		{ IRQ_PBX_RTC, NO_IRQ }
-#define PBX_RTC_DMA		{ 0, 0 }
 #define SCI_IRQ			{ IRQ_PBX_SCI, NO_IRQ }
-#define SCI_DMA			{ 7, 6 }
 #define PBX_UART0_IRQ		{ IRQ_PBX_UART0, NO_IRQ }
-#define PBX_UART0_DMA		{ 15, 14 }
 #define PBX_UART1_IRQ		{ IRQ_PBX_UART1, NO_IRQ }
-#define PBX_UART1_DMA		{ 13, 12 }
 #define PBX_UART2_IRQ		{ IRQ_PBX_UART2, NO_IRQ }
-#define PBX_UART2_DMA		{ 11, 10 }
 #define PBX_UART3_IRQ		{ IRQ_PBX_UART3, NO_IRQ }
-#define PBX_UART3_DMA		{ 0x86, 0x87 }
 #define PBX_SSP_IRQ		{ IRQ_PBX_SSP, NO_IRQ }
-#define PBX_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
-- 
1.6.2.5
