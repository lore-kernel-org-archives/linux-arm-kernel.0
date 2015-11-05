From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Thu,  5 Nov 2015 16:07:56 -0600
Subject: [PATCH 5/5] dts: ipq4019: Add support for IPQ4019 DK01 board
In-Reply-To: <1446761276-9111-1-git-send-email-mmcclint@codeaurora.org>
References: <1446761276-9111-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1446761276-9111-6-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial board support dts files for DK01 board.

Signed-off-by: Senthilkumar N L <snlakshm@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts | 22 +++++++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   | 49 +++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bb8fa02..445340d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -491,6 +491,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
+	qcom-ipq4019-ap.dk01.1-c1.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
new file mode 100644
index 0000000..0d92f1b
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
@@ -0,0 +1,22 @@
+/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include "qcom-ipq4019-ap.dk01.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK01.1-C1";
+
+};
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
new file mode 100644
index 0000000..7448058
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -0,0 +1,49 @@
+/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include "qcom-ipq4019.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
+	compatible = "qcom,ipq4019";
+
+	soc {
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <1 2 0xf08>,
+				     <1 3 0xf08>,
+				     <1 4 0xf08>,
+				     <1 1 0xf08>;
+			clock-frequency = <48000000>;
+		};
+
+		pinctrl at 0x01000000 {
+			serial_pins: serial_pinmux {
+				mux {
+					pins = "gpio60", "gpio61";
+					function = "blsp_uart0";
+					bias-disable;
+				};
+			};
+		};
+
+		serial at 78af000 {
+			pinctrl-0 = <&serial_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
