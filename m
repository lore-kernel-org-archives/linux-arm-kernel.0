From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:48 +0300
Subject: [PATCH v2 4/8] ARM: sa1100: shift IRQs by one
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416942592-23059-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As IRQ0 should not be used (especially in when using irq domains), shift all
virtual IRQ numbers by one.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/include/mach/irqs.h | 102 +++++++++++++++----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index 3790298..de09834 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -8,56 +8,56 @@
  * 2001/11/14	RMK	Cleaned up and standardised a lot of the IRQs.
  */
 
-#define	IRQ_GPIO0		0
-#define	IRQ_GPIO1		1
-#define	IRQ_GPIO2		2
-#define	IRQ_GPIO3		3
-#define	IRQ_GPIO4		4
-#define	IRQ_GPIO5		5
-#define	IRQ_GPIO6		6
-#define	IRQ_GPIO7		7
-#define	IRQ_GPIO8		8
-#define	IRQ_GPIO9		9
-#define	IRQ_GPIO10		10
-#define	IRQ_GPIO11_27		11
-#define	IRQ_LCD  		12	/* LCD controller           */
-#define	IRQ_Ser0UDC		13	/* Ser. port 0 UDC          */
-#define	IRQ_Ser1SDLC		14	/* Ser. port 1 SDLC         */
-#define	IRQ_Ser1UART		15	/* Ser. port 1 UART         */
-#define	IRQ_Ser2ICP		16	/* Ser. port 2 ICP          */
-#define	IRQ_Ser3UART		17	/* Ser. port 3 UART         */
-#define	IRQ_Ser4MCP		18	/* Ser. port 4 MCP          */
-#define	IRQ_Ser4SSP		19	/* Ser. port 4 SSP          */
-#define	IRQ_DMA0 		20	/* DMA controller channel 0 */
-#define	IRQ_DMA1 		21	/* DMA controller channel 1 */
-#define	IRQ_DMA2 		22	/* DMA controller channel 2 */
-#define	IRQ_DMA3 		23	/* DMA controller channel 3 */
-#define	IRQ_DMA4 		24	/* DMA controller channel 4 */
-#define	IRQ_DMA5 		25	/* DMA controller channel 5 */
-#define	IRQ_OST0 		26	/* OS Timer match 0         */
-#define	IRQ_OST1 		27	/* OS Timer match 1         */
-#define	IRQ_OST2 		28	/* OS Timer match 2         */
-#define	IRQ_OST3 		29	/* OS Timer match 3         */
-#define	IRQ_RTC1Hz		30	/* RTC 1 Hz clock           */
-#define	IRQ_RTCAlrm		31	/* RTC Alarm                */
+#define	IRQ_GPIO0		1
+#define	IRQ_GPIO1		2
+#define	IRQ_GPIO2		3
+#define	IRQ_GPIO3		4
+#define	IRQ_GPIO4		5
+#define	IRQ_GPIO5		6
+#define	IRQ_GPIO6		7
+#define	IRQ_GPIO7		8
+#define	IRQ_GPIO8		9
+#define	IRQ_GPIO9		10
+#define	IRQ_GPIO10		11
+#define	IRQ_GPIO11_27		12
+#define	IRQ_LCD			13	/* LCD controller           */
+#define	IRQ_Ser0UDC		14	/* Ser. port 0 UDC          */
+#define	IRQ_Ser1SDLC		15	/* Ser. port 1 SDLC         */
+#define	IRQ_Ser1UART		16	/* Ser. port 1 UART         */
+#define	IRQ_Ser2ICP		17	/* Ser. port 2 ICP          */
+#define	IRQ_Ser3UART		18	/* Ser. port 3 UART         */
+#define	IRQ_Ser4MCP		19	/* Ser. port 4 MCP          */
+#define	IRQ_Ser4SSP		20	/* Ser. port 4 SSP          */
+#define	IRQ_DMA0		21	/* DMA controller channel 0 */
+#define	IRQ_DMA1		22	/* DMA controller channel 1 */
+#define	IRQ_DMA2		23	/* DMA controller channel 2 */
+#define	IRQ_DMA3		24	/* DMA controller channel 3 */
+#define	IRQ_DMA4		25	/* DMA controller channel 4 */
+#define	IRQ_DMA5		26	/* DMA controller channel 5 */
+#define	IRQ_OST0		27	/* OS Timer match 0         */
+#define	IRQ_OST1		28	/* OS Timer match 1         */
+#define	IRQ_OST2		29	/* OS Timer match 2         */
+#define	IRQ_OST3		30	/* OS Timer match 3         */
+#define	IRQ_RTC1Hz		31	/* RTC 1 Hz clock           */
+#define	IRQ_RTCAlrm		32	/* RTC Alarm                */
 
-#define	IRQ_GPIO11		32
-#define	IRQ_GPIO12		33
-#define	IRQ_GPIO13		34
-#define	IRQ_GPIO14		35
-#define	IRQ_GPIO15		36
-#define	IRQ_GPIO16		37
-#define	IRQ_GPIO17		38
-#define	IRQ_GPIO18		39
-#define	IRQ_GPIO19		40
-#define	IRQ_GPIO20		41
-#define	IRQ_GPIO21		42
-#define	IRQ_GPIO22		43
-#define	IRQ_GPIO23		44
-#define	IRQ_GPIO24		45
-#define	IRQ_GPIO25		46
-#define	IRQ_GPIO26		47
-#define	IRQ_GPIO27		48
+#define	IRQ_GPIO11		33
+#define	IRQ_GPIO12		34
+#define	IRQ_GPIO13		35
+#define	IRQ_GPIO14		36
+#define	IRQ_GPIO15		37
+#define	IRQ_GPIO16		38
+#define	IRQ_GPIO17		39
+#define	IRQ_GPIO18		40
+#define	IRQ_GPIO19		41
+#define	IRQ_GPIO20		42
+#define	IRQ_GPIO21		43
+#define	IRQ_GPIO22		44
+#define	IRQ_GPIO23		45
+#define	IRQ_GPIO24		46
+#define	IRQ_GPIO25		47
+#define	IRQ_GPIO26		48
+#define	IRQ_GPIO27		49
 
 /*
  * The next 16 interrupts are for board specific purposes.  Since
@@ -65,8 +65,8 @@
  * these.  If you need more, increase IRQ_BOARD_END, but keep it
  * within sensible limits.  IRQs 49 to 64 are available.
  */
-#define IRQ_BOARD_START		49
-#define IRQ_BOARD_END		65
+#define IRQ_BOARD_START		50
+#define IRQ_BOARD_END		66
 
 /*
  * Figure out the MAX IRQ number.
-- 
2.1.3
