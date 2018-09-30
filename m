From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 30 Sep 2018 11:32:28 +0800
Subject: [PATCH V3 3/3] ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk
 support
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1538278348-7716-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6ULZ is new SoC of i.MX6 family, compared to i.MX6ULL,
it removes below modules:

- UART5/UART6/UART7/UART8;
- PWM5/PWM6/PWM7/PWM8;
- eCSPI3/eCSPI4;
- CAN1/CAN2;
- FEC1/FEC2;
- I2C3/I2C4;
- EPIT2;
- LCDIF;
- GPT2;
- ADC1;
- TSC;

This patch adds support for i.MX6ULZ and i.MX6ULZ 14x14 EVK
board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	Add "fsl,imx6ull" to DT compatible.
 arch/arm/boot/dts/Makefile              |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts | 20 +++++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi          | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b3ec70d..d7268ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -560,7 +560,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb
+	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-14x14-evk.dts b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
new file mode 100644
index 0000000..6f1af24
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+/dts-v1/;
+
+#include "imx6ulz.dtsi"
+#include "imx6ul-14x14-evk.dtsi"
+
+/delete-node/ &fec1;
+/delete-node/ &fec2;
+/delete-node/ &lcdif;
+/delete-node/ &tsc;
+
+/ {
+	model = "Freescale i.MX6 ULZ 14x14 EVK Board";
+	compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ull", "fsl,imx6ulz";
+
+	/delete-node/ panel;
+};
diff --git a/arch/arm/boot/dts/imx6ulz.dtsi b/arch/arm/boot/dts/imx6ulz.dtsi
new file mode 100644
index 0000000..ae6d7e5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+#include "imx6ull.dtsi"
+
+/ {
+	aliases {
+		/delete-property/ ethernet0;
+		/delete-property/ ethernet1;
+		/delete-property/ i2c2;
+		/delete-property/ i2c3;
+		/delete-property/ serial4;
+		/delete-property/ serial5;
+		/delete-property/ serial6;
+		/delete-property/ serial7;
+		/delete-property/ spi2;
+		/delete-property/ spi3;
+	};
+};
+
+/delete-node/ &adc1;
+/delete-node/ &can1;
+/delete-node/ &can2;
+/delete-node/ &ecspi3;
+/delete-node/ &ecspi4;
+/delete-node/ &epit2;
+/delete-node/ &gpt2;
+/delete-node/ &i2c3;
+/delete-node/ &i2c4;
+/delete-node/ &pwm5;
+/delete-node/ &pwm6;
+/delete-node/ &pwm7;
+/delete-node/ &pwm8;
+/delete-node/ &uart5;
+/delete-node/ &uart6;
+/delete-node/ &uart7;
+/delete-node/ &uart8;
-- 
2.7.4
