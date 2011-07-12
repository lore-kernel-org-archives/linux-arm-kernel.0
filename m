From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 11 Jul 2011 17:02:04 -0700
Subject: [PATCH 2/6] ARM: i.MX53: UARTn_CTS pin should not change RTS input
	select
In-Reply-To: <1310428928-2637-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1310428928-2637-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1310428928-2637-2-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If both the RTS pad and CTS pad definitions setup
IOMUXC_UARTn_IPP_UART_RTS_MUX_SELECT_INPUT, then
the order of setup will matter. We don't want that.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
You might think that selecting the CTS pad in the
xxx_RTS_MUX_SELECT_INPUT would swap the RTS and CTS
pins. That does not seem to be the case. Output still
happens on the CTS pin. This appears merely to loopback
CTS to RTS.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 29ce1e6..0dac888 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -107,7 +107,7 @@
 #define _MX53_PAD_KEY_ROW4__GPIO4_15	IOMUX_PAD(0x370, 0x48, 1, 0x0, 0, 0)
 #define _MX53_PAD_KEY_ROW4__CAN2_RXCAN	IOMUX_PAD(0x370, 0x48, 2, 0x764, 0, 0)
 #define _MX53_PAD_KEY_ROW4__IPU_SISG_5	IOMUX_PAD(0x370, 0x48, 3, 0x0, 0, 0)
-#define _MX53_PAD_KEY_ROW4__UART5_CTS	IOMUX_PAD(0x370, 0x48, 4, 0x894, 1, 0)
+#define _MX53_PAD_KEY_ROW4__UART5_CTS	IOMUX_PAD(0x370, 0x48, 4, 0x0, 0, 0)
 #define _MX53_PAD_KEY_ROW4__USBOH3_USBOTG_PWR	IOMUX_PAD(0x370, 0x48, 5, 0x0, 0, 0)
 #define _MX53_PAD_KEY_ROW4__USBPHY1_VBUSVALID	IOMUX_PAD(0x370, 0x48, 7, 0x0, 0, 0)
 #define _MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK	IOMUX_PAD(0x378, 0x4C, 0, 0x0, 0, 0)
@@ -428,7 +428,7 @@
 #define _MX53_PAD_CSI0_DAT16__TPIU_TRACE_13		IOMUX_PAD(0x42C, 0x100, 7, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT17__IPU_CSI0_D_17		IOMUX_PAD(0x430, 0x104, 0, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT17__GPIO6_3		IOMUX_PAD(0x430, 0x104, 1, 0x0, 0, 0)
-#define _MX53_PAD_CSI0_DAT17__UART4_CTS		IOMUX_PAD(0x430, 0x104, 2, 0x88C, 1, 0)
+#define _MX53_PAD_CSI0_DAT17__UART4_CTS		IOMUX_PAD(0x430, 0x104, 2, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT17__USBOH3_USBH3_DATA_5	IOMUX_PAD(0x430, 0x104, 4, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT17__SDMA_DEBUG_PC_11	IOMUX_PAD(0x430, 0x104, 5, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT17__EMI_EMI_DEBUG_46	IOMUX_PAD(0x430, 0x104, 6, 0x0, 0, 0)
@@ -442,7 +442,7 @@
 #define _MX53_PAD_CSI0_DAT18__TPIU_TRACE_15		IOMUX_PAD(0x434, 0x108, 7, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT19__IPU_CSI0_D_19		IOMUX_PAD(0x438, 0x10C, 0, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT19__GPIO6_5		IOMUX_PAD(0x438, 0x10C, 1, 0x0, 0, 0)
-#define _MX53_PAD_CSI0_DAT19__UART5_CTS		IOMUX_PAD(0x438, 0x10C, 2, 0x894, 3, 0)
+#define _MX53_PAD_CSI0_DAT19__UART5_CTS		IOMUX_PAD(0x438, 0x10C, 2, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT19__USBOH3_USBH3_DATA_7	IOMUX_PAD(0x438, 0x10C, 4, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT19__SDMA_DEBUG_PC_13	IOMUX_PAD(0x438, 0x10C, 5, 0x0, 0, 0)
 #define _MX53_PAD_CSI0_DAT19__EMI_EMI_DEBUG_48	IOMUX_PAD(0x438, 0x10C, 6, 0x0, 0, 0)
@@ -485,7 +485,7 @@
 #define _MX53_PAD_EIM_D19__IPU_DISPB1_SER_RS	IOMUX_PAD(0x46C, 0x124, 3, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D19__ECSPI1_SS1		IOMUX_PAD(0x46C, 0x124, 4, 0x7AC, 2, 0)
 #define _MX53_PAD_EIM_D19__EPIT1_EPITO		IOMUX_PAD(0x46C, 0x124, 5, 0x0, 0, 0)
-#define _MX53_PAD_EIM_D19__UART1_CTS			IOMUX_PAD(0x46C, 0x124, 6, 0x874, 0, 0)
+#define _MX53_PAD_EIM_D19__UART1_CTS			IOMUX_PAD(0x46C, 0x124, 6, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D19__USBOH3_USBH2_OC		IOMUX_PAD(0x46C, 0x124, 7, 0x8A4, 0, 0)
 #define _MX53_PAD_EIM_D20__EMI_WEIM_D_20		IOMUX_PAD(0x470, 0x128, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D20__GPIO3_20			IOMUX_PAD(0x470, 0x128, 1, 0x0, 0, 0)
@@ -510,7 +510,7 @@
 #define _MX53_PAD_EIM_D22__USBOH3_USBOTG_PWR	IOMUX_PAD(0x478, 0x130, 6, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D23__EMI_WEIM_D_23		IOMUX_PAD(0x47C, 0x134, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D23__GPIO3_23			IOMUX_PAD(0x47C, 0x134, 1, 0x0, 0, 0)
-#define _MX53_PAD_EIM_D23__UART3_CTS			IOMUX_PAD(0x47C, 0x134, 2, 0x884, 0, 0)
+#define _MX53_PAD_EIM_D23__UART3_CTS			IOMUX_PAD(0x47C, 0x134, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D23__UART1_DCD		IOMUX_PAD(0x47C, 0x134, 3, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D23__IPU_DI0_D0_CS		IOMUX_PAD(0x47C, 0x134, 4, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D23__IPU_DI1_PIN2		IOMUX_PAD(0x47C, 0x134, 5, 0x0, 0, 0)
@@ -557,7 +557,7 @@
 #define _MX53_PAD_EIM_D27__IPU_DISP1_DAT_23		IOMUX_PAD(0x490, 0x148, 7, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D28__EMI_WEIM_D_28		IOMUX_PAD(0x494, 0x14C, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D28__GPIO3_28			IOMUX_PAD(0x494, 0x14C, 1, 0x0, 0, 0)
-#define _MX53_PAD_EIM_D28__UART2_CTS			IOMUX_PAD(0x494, 0x14C, 2, 0x87C, 0, 0)
+#define _MX53_PAD_EIM_D28__UART2_CTS			IOMUX_PAD(0x494, 0x14C, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO	IOMUX_PAD(0x494, 0x14C, 3, 0x82C, 1, 0)
 #define _MX53_PAD_EIM_D28__CSPI_MOSI			IOMUX_PAD(0x494, 0x14C, 4, 0x788, 1, 0)
 #define _MX53_PAD_EIM_D28__I2C1_SDA			IOMUX_PAD(0x494, 0x14C, 5, 0x818, 1, 0)
@@ -573,7 +573,7 @@
 #define _MX53_PAD_EIM_D29__IPU_DI0_PIN14		IOMUX_PAD(0x498, 0x150, 7, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D30__EMI_WEIM_D_30		IOMUX_PAD(0x49C, 0x154, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D30__GPIO3_30			IOMUX_PAD(0x49C, 0x154, 1, 0x0, 0, 0)
-#define _MX53_PAD_EIM_D30__UART3_CTS			IOMUX_PAD(0x49C, 0x154, 2, 0x884, 2, 0)
+#define _MX53_PAD_EIM_D30__UART3_CTS			IOMUX_PAD(0x49C, 0x154, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D30__IPU_CSI0_D_3		IOMUX_PAD(0x49C, 0x154, 3, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D30__IPU_DI0_PIN11		IOMUX_PAD(0x49C, 0x154, 4, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D30__IPU_DISP1_DAT_21		IOMUX_PAD(0x49C, 0x154, 5, 0x0, 0, 0)
@@ -877,7 +877,7 @@
 #define _MX53_PAD_PATA_BUFFER_EN__USBPHY2_DATAOUT_5	IOMUX_PAD(0x5FC, 0x27C, 7, 0x0, 0, 0)
 #define _MX53_PAD_PATA_INTRQ__PATA_INTRQ		IOMUX_PAD(0x600, 0x280, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_INTRQ__GPIO7_2		IOMUX_PAD(0x600, 0x280, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_INTRQ__UART2_CTS		IOMUX_PAD(0x600, 0x280, 3, 0x87C, 2, 0)
+#define _MX53_PAD_PATA_INTRQ__UART2_CTS		IOMUX_PAD(0x600, 0x280, 3, 0x0, 0, 0)
 #define _MX53_PAD_PATA_INTRQ__CAN1_TXCAN		IOMUX_PAD(0x600, 0x280, 4, 0x0, 0, 0)
 #define _MX53_PAD_PATA_INTRQ__CCM_CCM_OUT_2	IOMUX_PAD(0x600, 0x280, 5, 0x0, 0, 0)
 #define _MX53_PAD_PATA_INTRQ__USBPHY2_DATAOUT_6	IOMUX_PAD(0x600, 0x280, 7, 0x0, 0, 0)
@@ -889,7 +889,7 @@
 #define _MX53_PAD_PATA_RESET_B__PATA_PATA_RESET_B	IOMUX_PAD(0x608, 0x288, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_RESET_B__GPIO7_4		IOMUX_PAD(0x608, 0x288, 1, 0x0, 0, 0)
 #define _MX53_PAD_PATA_RESET_B__ESDHC3_CMD		IOMUX_PAD(0x608, 0x288, 2, 0x0, 0, 0)
-#define _MX53_PAD_PATA_RESET_B__UART1_CTS		IOMUX_PAD(0x608, 0x288, 3, 0x874, 2, 0)
+#define _MX53_PAD_PATA_RESET_B__UART1_CTS		IOMUX_PAD(0x608, 0x288, 3, 0x0, 0, 0)
 #define _MX53_PAD_PATA_RESET_B__CAN2_TXCAN		IOMUX_PAD(0x608, 0x288, 4, 0x0, 0, 0)
 #define _MX53_PAD_PATA_RESET_B__USBPHY1_DATAOUT_0	IOMUX_PAD(0x608, 0x288, 7, 0x0, 0, 0)
 #define _MX53_PAD_PATA_IORDY__PATA_IORDY		IOMUX_PAD(0x60C, 0x28C, 0, 0x0, 0, 0)
@@ -906,7 +906,7 @@
 #define _MX53_PAD_PATA_DA_1__PATA_DA_1		IOMUX_PAD(0x614, 0x294, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DA_1__GPIO7_7		IOMUX_PAD(0x614, 0x294, 1, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DA_1__ESDHC4_CMD		IOMUX_PAD(0x614, 0x294, 2, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DA_1__UART3_CTS		IOMUX_PAD(0x614, 0x294, 4, 0x884, 4, 0)
+#define _MX53_PAD_PATA_DA_1__UART3_CTS		IOMUX_PAD(0x614, 0x294, 4, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DA_1__USBPHY1_DATAOUT_3	IOMUX_PAD(0x614, 0x294, 7, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DA_2__PATA_DA_2		IOMUX_PAD(0x618, 0x298, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DA_2__GPIO7_8		IOMUX_PAD(0x618, 0x298, 1, 0x0, 0, 0)
-- 
1.7.0.4
