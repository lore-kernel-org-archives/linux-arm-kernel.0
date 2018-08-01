From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:09 +0530
Subject: [PATCH v2 04/10] dt-bindings: reset: Add Actions Semi S900 SoC RMU
 support
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RMU (Reset Management Unit) support for the Actions Semi S900
SoC which is a part of the Actions Semi Owl family series.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/reset/actions,owl-reset.txt      | 33 ++++++++++
 include/dt-bindings/reset/actions,s900-rmu.h  | 65 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/actions,owl-reset.txt
 create mode 100644 include/dt-bindings/reset/actions,s900-rmu.h

diff --git a/Documentation/devicetree/bindings/reset/actions,owl-reset.txt b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
new file mode 100644
index 000000000000..38e2c7051d86
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
@@ -0,0 +1,33 @@
+Actions Semi Owl SoCs Reset Management Unit (RMU)
+=================================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+The RMU registers are part of the system-controller block on Owl SoCs.
+
+Required properties:
+- compatible: Should be "actions,s900-rmu"
+- #reset-cells: Should be 1
+
+All available resets are defined as preprocessor macros in corresponding
+dt-bindings/reset/actions,s900-rmu.h header and can be used in device
+tree sources.
+
+Parent node should have the following properties :
+- compatible: "syscon", "simple-mfd"
+- reg: physical base address of the system controller and length of
+  memory mapped region.
+
+Example:
+
+        sysctrl: system-controller at e0160000 {
+                compatible = "syscon", "simple-mfd";
+                reg = <0x0 0xe0160000 0x0 0x1000>;
+
+                rmu: reset-controller {
+                        compatible = "actions,s900-rmu";
+                        #reset-cells = <1>;
+                };
+        };
+
diff --git a/include/dt-bindings/reset/actions,s900-rmu.h b/include/dt-bindings/reset/actions,s900-rmu.h
new file mode 100644
index 000000000000..09e6dca46936
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s900-rmu.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S900 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef _DT_BINDINGS_ACTIONS_S900_RESET_H
+#define _DT_BINDINGS_ACTIONS_S900_RESET_H
+
+#define S900_RESET_CHIPID		0
+#define S900_RESET_CPU_SCNT		1
+#define S900_RESET_SRAMI		2
+#define S900_RESET_DDR_CTL_PHY		3
+#define S900_RESET_DMAC			4
+#define S900_RESET_GPIO			5
+#define S900_RESET_BISP_AXI		6
+#define S900_RESET_CSI0			7
+#define S900_RESET_CSI1			8
+#define S900_RESET_DE			9
+#define S900_RESET_DSI			10
+#define S900_RESET_GPU3D_PA		11
+#define S900_RESET_GPU3D_PB		12
+#define S900_RESET_HDE			13
+#define S900_RESET_I2C0			14
+#define S900_RESET_I2C1			15
+#define S900_RESET_I2C2			16
+#define S900_RESET_I2C3			17
+#define S900_RESET_I2C4			18
+#define S900_RESET_I2C5			19
+#define S900_RESET_IMX			20
+#define S900_RESET_NANDC0		21
+#define S900_RESET_NANDC1		22
+#define S900_RESET_SD0			23
+#define S900_RESET_SD1			24
+#define S900_RESET_SD2			25
+#define S900_RESET_SD3			26
+#define S900_RESET_SPI0			27
+#define S900_RESET_SPI1			28
+#define S900_RESET_SPI2			29
+#define S900_RESET_SPI3			30
+#define S900_RESET_UART0		31
+#define S900_RESET_UART1		32
+#define S900_RESET_UART2		33
+#define S900_RESET_UART3		34
+#define S900_RESET_UART4		35
+#define S900_RESET_UART5		36
+#define S900_RESET_UART6		37
+#define S900_RESET_HDMI			38
+#define S900_RESET_LVDS			39
+#define S900_RESET_EDP			40
+#define S900_RESET_USB2HUB		41
+#define S900_RESET_USB2HSIC		42
+#define S900_RESET_USB3			43
+#define S900_RESET_PCM1			44
+#define S900_RESET_AUDIO		45
+#define S900_RESET_PCM0			46
+#define S900_RESET_SE			47
+#define S900_RESET_GIC			48
+#define S900_RESET_DDR_CTL_PHY_AXI	49
+#define S900_RESET_CMU_DDR		50
+#define S900_RESET_DMM			51
+#define S900_RESET_HDCP2TX		52
+#define S900_RESET_ETHERNET		53
+
+#endif /* _DT_BINDINGS_ACTIONS_S900_RESET_H */
-- 
2.17.1
