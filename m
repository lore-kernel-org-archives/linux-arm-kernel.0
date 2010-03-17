From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 11:21:18 -0400
Subject: [PATCH] [ARM] pxa: remove ifdef in ssp.h
Message-ID: <mailman.248.1269013967.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to keep minimum ifdef in ssp.h.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/ssp.h |   41 ++++++++++++---------------------
 1 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
b/arch/arm/plat-pxa/include/plat/ssp.h
index 4c4ce62..74f70c7 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -40,10 +40,7 @@
 #define SSRSA		(0x34)  /* SSP Rx Timeslot Active */
 #define SSTSS		(0x38)  /* SSP Timeslot Status */
 #define SSACD		(0x3C)  /* SSP Audio Clock Divider */
-
-#if defined(CONFIG_PXA3xx)
 #define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
-#endif

 /* Common PXA2xx bits first */
 #define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
@@ -56,20 +53,17 @@
 #define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
 #define SSCR0_SCR(x)	((x) << 8)	/* Serial Clock Rate (mask) */

-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+/* PXA27x, PXA3xx */
 #define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
 #define SSCR0_NCS	(1 << 21)	/* Network clock select */
 #define SSCR0_RIM	(1 << 22)	/* Receive FIFO overrrun interrupt mask */
 #define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun interrupt mask */
 #define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
 #define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per
frame [1..8] */
+#define SSCR0_FPCKE	(1 << 29)	/* FIFO packing enable */
 #define SSCR0_ACS	(1 << 30)	/* Audio clock select */
 #define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
-#endif

-#if defined(CONFIG_PXA3xx)
-#define SSCR0_FPCKE	(1 << 29)	/* FIFO packing enable */
-#endif

 #define SSCR1_RIE	(1 << 0)	/* Receive FIFO Interrupt Enable */
 #define SSCR1_TIE	(1 << 1)	/* Transmit FIFO Interrupt Enable */
@@ -89,10 +83,6 @@
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */

-#define SSCR0_TIM		(1 << 23)	/* Transmit FIFO Under Run Interrupt Mask */
-#define SSCR0_RIM		(1 << 22)	/* Receive FIFO Over Run interrupt Mask */
-#define SSCR0_NCS		(1 << 21)	/* Network Clock Select */
-#define SSCR0_EDSS		(1 << 20)	/* Extended Data Size Select */

 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
@@ -122,27 +112,26 @@
 #define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
 #define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */

-#if defined(CONFIG_PXA3xx)
-#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
-#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
-#endif

-#define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
-#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
-#define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
-#define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
-#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
-#define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
-#define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
-#define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
 #define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
+#define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
+#define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
+#define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
+#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
+#define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
+#define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
+#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
+#define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
+
+/* PXA3xx */
+#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
+#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
+#define SSPSP_TIMING_MASK	(0x7f8001f0)

 #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
 #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
-#if defined(CONFIG_PXA3xx)
 #define SSACD_SCDX8		(1 << 7)	/* SYSCLK division ratio select */
-#endif

 enum pxa_ssp_type {
 	SSP_UNDEFINED = 0,
-- 
1.5.6.5
