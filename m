From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 25 May 2018 11:41:17 +0530
Subject: [PATCH v8 07/12] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
In-Reply-To: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
References: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1527228682-12285-8-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the common data for all dk07 based boards.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..9f1a5a66
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
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
+			serial_0_pins: serial0-pinmux {
+				pins = "gpio16", "gpio17";
+				function = "blsp_uart0";
+				bias-disable;
+			};
+
+			i2c_0_pins: i2c-0-pinmux {
+				pins = "gpio20", "gpio21";
+				function = "blsp_i2c0";
+				bias-disable;
+			};
+
+			nand_pins: nand-pins {
+				pins = "gpio53", "gpio55", "gpio56",
+				       "gpio57", "gpio58", "gpio59",
+				       "gpio60", "gpio62", "gpio63",
+				       "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68", "gpio69";
+				function = "qpic";
+                        };
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
+			pinctrl-0 = <&nand_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
