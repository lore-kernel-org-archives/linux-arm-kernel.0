From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Tue, 13 Mar 2012 11:35:22 +0000
Subject: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
Message-ID: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mehnert <tmehnert@eckelmann.de>
Date: Mon, 13 Mar 2012 12:13:51 +0100
Subject: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins

For some reason (sadly i don't identifying the patch right now)
two LCD data lines configured PAD_CTL_SRE_SLOW (wrong slew rate)
since Kernel 3.1. MX25_PAD_GPIO_E__LD16 and MX25_PAD_GPIO_F__LD17
This results in an fauly behaviour and strange color effects.

To ensure that all LCD data pins configured with the proper slew rate,
this patch changes to IOMUX define of all LCD __LDxx pins to PAD_CTL_SRE_FAST.

This problem may affect other mx25 platforms like mx25pdk. Sadly i can't test
it. Of course this problem shouldn't occur when you done your LCD muxing 
correctly in the bootloader.

Best regards,
Torsten

---
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h	2012-02-28 00:43:05.000000000 +0100
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h	2012-03-13 12:08:39.920736789 +0100
@@ -139,15 +139,15 @@
 #define MX25_PAD_NFRB__GPIO_3_31	IOMUX_PAD(0x27c, 0x084, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_D15__D15		IOMUX_PAD(0x280, 0x088, 0x00, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_D15__LD16		IOMUX_PAD(0x280, 0x088, 0x01, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_D15__LD16		IOMUX_PAD(0x280, 0x088, 0x01, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_D15__GPIO_4_5		IOMUX_PAD(0x280, 0x088, 0x05, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_D14__D14		IOMUX_PAD(0x284, 0x08c, 0x00, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_D14__LD17		IOMUX_PAD(0x284, 0x08c, 0x01, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_D14__LD17		IOMUX_PAD(0x284, 0x08c, 0x01, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_D14__GPIO_4_6		IOMUX_PAD(0x284, 0x08c, 0x05, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_D13__D13		IOMUX_PAD(0x288, 0x090, 0x00, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_D13__LD18		IOMUX_PAD(0x288, 0x090, 0x01, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_D13__LD18		IOMUX_PAD(0x288, 0x090, 0x01, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_D13__GPIO_4_7		IOMUX_PAD(0x288, 0x090, 0x05, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_D12__D12		IOMUX_PAD(0x28c, 0x094, 0x00, 0, 0, NO_PAD_CTRL)
@@ -192,54 +192,54 @@
 #define MX25_PAD_D0__D0			IOMUX_PAD(0x2bc, 0x0c4, 0x00, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_D0__GPIO_4_20		IOMUX_PAD(0x2bc, 0x0c4, 0x05, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD0__LD0		IOMUX_PAD(0x2c0, 0x0c8, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD0__LD0		IOMUX_PAD(0x2c0, 0x0c8, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD0__CSI_D0		IOMUX_PAD(0x2c0, 0x0c8, 0x12, 0x488, 0, NO_PAD_CTRL)
 #define MX25_PAD_LD0__GPIO_2_15		IOMUX_PAD(0x2c0, 0x0c8, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD1__LD1		IOMUX_PAD(0x2c4, 0x0cc, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD1__LD1		IOMUX_PAD(0x2c4, 0x0cc, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD1__CSI_D1		IOMUX_PAD(0x2c4, 0x0cc, 0x12, 0x48c, 0, NO_PAD_CTRL)
 #define MX25_PAD_LD1__GPIO_2_16		IOMUX_PAD(0x2c4, 0x0cc, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD2__LD2		IOMUX_PAD(0x2c8, 0x0d0, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD2__LD2		IOMUX_PAD(0x2c8, 0x0d0, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD2__GPIO_2_17		IOMUX_PAD(0x2c8, 0x0d0, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD3__LD3		IOMUX_PAD(0x2cc, 0x0d4, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD3__LD3		IOMUX_PAD(0x2cc, 0x0d4, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD3__GPIO_2_18		IOMUX_PAD(0x2cc, 0x0d4, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD4__LD4		IOMUX_PAD(0x2d0, 0x0d8, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD4__LD4		IOMUX_PAD(0x2d0, 0x0d8, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD4__GPIO_2_19		IOMUX_PAD(0x2d0, 0x0d8, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD5__LD5		IOMUX_PAD(0x2d4, 0x0dc, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD5__LD5		IOMUX_PAD(0x2d4, 0x0dc, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD5__GPIO_1_19		IOMUX_PAD(0x2d4, 0x0dc, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD6__LD6		IOMUX_PAD(0x2d8, 0x0e0, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD6__LD6		IOMUX_PAD(0x2d8, 0x0e0, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD6__GPIO_1_20		IOMUX_PAD(0x2d8, 0x0e0, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD7__LD7		IOMUX_PAD(0x2dc, 0x0e4, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD7__LD7		IOMUX_PAD(0x2dc, 0x0e4, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD7__GPIO_1_21		IOMUX_PAD(0x2dc, 0x0e4, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD8__LD8		IOMUX_PAD(0x2e0, 0x0e8, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD8__LD8		IOMUX_PAD(0x2e0, 0x0e8, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD8__FEC_TX_ERR	IOMUX_PAD(0x2e0, 0x0e8, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD9__LD9		IOMUX_PAD(0x2e4, 0x0ec, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD9__LD9		IOMUX_PAD(0x2e4, 0x0ec, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD9__FEC_COL		IOMUX_PAD(0x2e4, 0x0ec, 0x15, 0x504, 1, NO_PAD_CTRL)
 
-#define MX25_PAD_LD10__LD10		IOMUX_PAD(0x2e8, 0x0f0, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD10__LD10		IOMUX_PAD(0x2e8, 0x0f0, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD10__FEC_RX_ER	IOMUX_PAD(0x2e8, 0x0f0, 0x15, 0x518, 1, NO_PAD_CTRL)
 
-#define MX25_PAD_LD11__LD11		IOMUX_PAD(0x2ec, 0x0f4, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD11__LD11		IOMUX_PAD(0x2ec, 0x0f4, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD11__FEC_RDATA2	IOMUX_PAD(0x2ec, 0x0f4, 0x15, 0x50c, 1, NO_PAD_CTRL)
 
-#define MX25_PAD_LD12__LD12		IOMUX_PAD(0x2f0, 0x0f8, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD12__LD12		IOMUX_PAD(0x2f0, 0x0f8, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD12__FEC_RDATA3	IOMUX_PAD(0x2f0, 0x0f8, 0x15, 0x510, 1, NO_PAD_CTRL)
 
-#define MX25_PAD_LD13__LD13		IOMUX_PAD(0x2f4, 0x0fc, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD13__LD13		IOMUX_PAD(0x2f4, 0x0fc, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD13__FEC_TDATA2	IOMUX_PAD(0x2f4, 0x0fc, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD14__LD14		IOMUX_PAD(0x2f8, 0x100, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD14__LD14		IOMUX_PAD(0x2f8, 0x100, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD14__FEC_TDATA3	IOMUX_PAD(0x2f8, 0x100, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_LD15__LD15		IOMUX_PAD(0x2fc, 0x104, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_LD15__LD15		IOMUX_PAD(0x2fc, 0x104, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD15__FEC_RX_CLK	IOMUX_PAD(0x2fc, 0x104, 0x15, 0x514, 1, NO_PAD_CTRL)
 
 #define MX25_PAD_HSYNC__HSYNC		IOMUX_PAD(0x300, 0x108, 0x10, 0, 0, NO_PAD_CTRL)
@@ -468,11 +468,11 @@
 #define MX25_PAD_GPIO_C__CAN2_TX	IOMUX_PAD(0x3f8, 0x1fc, 0x16, 0, 0, PAD_CTL_PUS_22K_UP)
 
 #define MX25_PAD_GPIO_D__GPIO_D		IOMUX_PAD(0x3fc, 0x200, 0x10, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_GPIO_E__LD16		IOMUX_PAD(0x400, 0x204, 0x02, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_GPIO_E__LD16		IOMUX_PAD(0x400, 0x204, 0x02, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_GPIO_D__CAN2_RX	IOMUX_PAD(0x3fc, 0x200, 0x16, 0x484, 1, PAD_CTL_PUS_22K_UP)
 
 #define MX25_PAD_GPIO_E__GPIO_E		IOMUX_PAD(0x400, 0x204, 0x10, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_GPIO_F__LD17		IOMUX_PAD(0x404, 0x208, 0x02, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_GPIO_F__LD17		IOMUX_PAD(0x404, 0x208, 0x02, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_GPIO_E__AUD7_TXD	IOMUX_PAD(0x400, 0x204, 0x14, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_GPIO_F__GPIO_F		IOMUX_PAD(0x404, 0x208, 0x10, 0, 0, NO_PAD_CTRL)
---
Torsten Mehnert
K?lte- und Geb?udeleittechnik (KGL)
?
ECKELMANN AG
Berliner Stra?e 161
D - 65205 Wiesbaden
?
Phone:	+49 (0) 611 / 7103 - 370
Fax:	+49 (0) 611 / 7103 - 133

e-Mail:	mailto:t.mehnert at eckelmann.de
Web:	http://www.eckelmann.de
