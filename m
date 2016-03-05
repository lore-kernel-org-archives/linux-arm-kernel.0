From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 18:02:50 +0000
Subject: [PATCH 2/5] ARM: bcm2835: add defines for each interrupt
In-Reply-To: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
References: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457200973-11662-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Define names for all interrupt "magic numbers" so that they
can get used inside the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 include/dt-bindings/interrupt-controller/bcm2835.h | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/bcm2835.h

diff --git a/include/dt-bindings/interrupt-controller/bcm2835.h b/include/dt-bindings/interrupt-controller/bcm2835.h
new file mode 100644
index 0000000..b8723f6
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/bcm2835.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/* the interrupt tables in the form <BANK> <ID> */
+
+/* ARM interrupts - bank 0 */
+#define BCM2835_INT_ARM_TIMER		0 0
+#define BCM2835_INT_ARM_MAILBOX		0 1
+#define BCM2835_INT_ARM_DORBELL0	0 2
+#define BCM2835_INT_ARM_DORBELL1	0 3
+#define BCM2835_INT_ARM_VPU0_HALTED	0 4
+#define BCM2835_INT_ARM_VPU1_HALTED	0 5
+#define BCM2835_INT_ARM_ILLEGAL_TYPE0	0 6
+#define BCM2835_INT_ARM_ILLEGAL_TYPE0	0 6
+
+/* peripheral interrupts - bank 1 */
+#define BCM2835_INT_TIMER0		1 0
+#define BCM2835_INT_TIMER1		1 1
+#define BCM2835_INT_TIMER2		1 2
+#define BCM2835_INT_TIMER3		1 3
+#define BCM2835_INT_CODEC0		1 4
+#define BCM2835_INT_CODEC1		1 5
+#define BCM2835_INT_CODEC2		1 6
+#define BCM2835_INT_JPEG		1 7
+#define BCM2835_INT_ISP			1 8
+#define BCM2835_INT_USB			1 9
+#define BCM2835_INT_3D			1 10
+#define BCM2835_INT_TRANSPOSER		1 11
+#define BCM2835_INT_MULTICORESYNC0	1 12
+#define BCM2835_INT_MULTICORESYNC1	1 13
+#define BCM2835_INT_MULTICORESYNC2	1 14
+#define BCM2835_INT_MULTICORESYNC3	1 15
+#define BCM2835_INT_DMA0		1 16
+#define BCM2835_INT_DMA1		1 17
+#define BCM2835_INT_DMA2		1 18
+#define BCM2835_INT_DMA3		1 19
+#define BCM2835_INT_DMA4		1 20
+#define BCM2835_INT_DMA5		1 21
+#define BCM2835_INT_DMA6		1 22
+#define BCM2835_INT_DMA7		1 23
+#define BCM2835_INT_DMA8		1 24
+#define BCM2835_INT_DMA9		1 25
+#define BCM2835_INT_DMA10		1 26
+#define BCM2835_INT_DMA11_12_13_14	1 27
+#define BCM2835_INT_DMA_ALL		1 28
+#define BCM2835_INT_AUX			1 29
+#define BCM2835_INT_AUX_UART		BCM2835_INT_AUX
+#define BCM2835_INT_AUX_SPI1		BCM2835_INT_AUX
+#define BCM2835_INT_AUX_SPI2		BCM2835_INT_AUX
+#define BCM2835_INT_ARM			1 30
+#define BCM2835_INT_DMA_VPU		1 31
+
+/* peripheral interrupts - bank 2 */
+#define BCM2835_INT_HOSTPORT		2 0
+#define BCM2835_INT_VIDEOSCALER		2 1
+#define BCM2835_INT_CCP2TX		2 2
+#define BCM2835_INT_SDC			2 3
+#define BCM2835_INT_DSI0		2 4
+#define BCM2835_INT_AVE			2 5
+#define BCM2835_INT_CAM0		2 6
+#define BCM2835_INT_CAM1		2 7
+#define BCM2835_INT_HDMI0		2 8
+#define BCM2835_INT_HDMI1		2 9
+#define BCM2835_INT_PIXELVALVE1		2 10
+#define BCM2835_INT_I2C_SLV		2 11
+#define BCM2835_INT_DSI1		2 12
+#define BCM2835_INT_PWA0		2 13
+#define BCM2835_INT_PWA1		2 14
+#define BCM2835_INT_CPR			2 15
+#define BCM2835_INT_SMI			2 16
+#define BCM2835_INT_GPIO0		2 17
+#define BCM2835_INT_GPIO1		2 18
+#define BCM2835_INT_GPIO2		2 19
+#define BCM2835_INT_GPIO3		2 20
+#define BCM2835_INT_I2C			2 21
+#define BCM2835_INT_SPI			2 22
+#define BCM2835_INT_I2SPCM		2 23
+#define BCM2835_INT_SDIO		2 24
+#define BCM2835_INT_UART		2 25
+#define BCM2835_INT_SLIMBUS		2 26
+#define BCM2835_INT_VEC			2 27
+#define BCM2835_INT_CPG			2 28
+#define BCM2835_INT_RNG			2 29
+#define BCM2835_INT_ARSANSDIO		2 30
+#define BCM2835_INT_AVSPMON		2 31
-- 
2.1.4
