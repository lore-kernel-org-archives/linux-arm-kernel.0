From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 23 Mar 2018 15:48:51 +0530
Subject: [PATCH v5 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
In-Reply-To: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the common data for all dk07 based boards.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..4cc519f
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
+	compatible = "qcom,ipq4019";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512MB */
+	};
+
+	aliases {
+		serial0 = &blsp1_uart1;
+		serial1 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	soc {
+		pinctrl at 1000000 {
+			serial_0_pins: serial0_pinmux {
+				mux {
+					pins = "gpio16", "gpio17";
+					function = "blsp_uart0";
+					bias-disable;
+				};
+			};
+
+			i2c_0_pins: i2c_0_pinmux {
+				mux {
+					pins = "gpio20", "gpio21";
+					function = "blsp_i2c0";
+					bias-disable;
+				};
+			};
+		};
+
+		serial at 78af000 {
+			pinctrl-0 = <&serial_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		dma at 7884000 {
+			status = "ok";
+		};
+
+		i2c at 78b7000 { /* BLSP1 QUP2 */
+			pinctrl-0 = <&i2c_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		dma at 7984000 {
+			status = "ok";
+		};
+
+		qpic-nand at 79b0000 {
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
