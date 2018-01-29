From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:26 +0530
Subject: [PATCH 12/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board
 file
In-Reply-To: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1517202689-14212-13-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 78 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ef5b133..b4339ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -729,6 +729,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk04.1-c5.dtb \
 	qcom-ipq4019-ap.dk04.1-c3.dtb \
 	qcom-ipq4019-ap.dk07.1-c1.dtb \
+	qcom-ipq4019-ap.dk07.1-c2.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
new file mode 100644
index 0000000..d4ee52d
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk07.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C2";
+
+	soc {
+		pcie0: pci at 40000000 {
+			status = "disabled";
+		};
+
+		pinctrl at 1000000 {
+			serial_1_pins: serial1_pinmux {
+				mux {
+					pins = "gpio8", "gpio9";
+					function = "blsp_uart1";
+					bias-disable;
+				};
+			};
+
+			spi_0_pins: spi_0_pinmux {
+				mux {
+					pins = "gpio13", "gpio14", "gpio15";
+					function = "blsp_spi0";
+					bias-disable;
+				};
+				cs1 {
+					pins = "gpio12";
+					function = "gpio";
+				};
+				host_int1 {
+					pins = "gpio10";
+					function = "gpio";
+					input;
+				};
+				cs2 {
+					pins = "gpio45";
+					function = "gpio";
+				};
+				host_int2 {
+					pins = "gpio61";
+					function = "gpio";
+					input;
+				};
+				rst {
+					pins = "gpio36";
+					function = "gpio";
+					output-high;
+				};
+			};
+		};
+
+		serial at 78b0000 {
+			pinctrl-0 = <&serial_1_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		spi_0: spi at 78b5000 { /* BLSP1 QUP1 */
+			pinctrl-0 = <&spi_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+
+			spidev0_0 {
+				compatible = "spidev";
+				reg = <0>;
+				spi-max-frequency = <24000000>;
+			};
+			spidev0_1 {
+				compatible = "spidev";
+				reg = <1>;
+				spi-max-frequency = <24000000>;
+			};
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
