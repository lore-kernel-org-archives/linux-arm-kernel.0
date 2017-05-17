From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 17 May 2017 16:37:44 +0800
Subject: [PATCH 11/12] arm64: dts: hi3660: add power key dts node
In-Reply-To: <20170517083745.24479-1-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
Message-ID: <20170517083745.24479-12-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Jun <chenjun14@huawei.com>

We use gpio_034 as power key on hikey960, and set gpio with pull-up
state, when key press the voltage on the gpio will come to lower, and
power key event will be reported.

Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 79735ee..6de86c0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -10,6 +10,8 @@
 #include "hi3660.dtsi"
 #include "hikey960-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "HiKey960";
@@ -32,6 +34,21 @@
 		/* rewrite this at bootloader */
 		reg = <0x0 0x0 0x0 0x0>;
 	};
+
+	soc {
+		keys: gpio-keys {
+			compatible = "gpio-keys";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwr_key_pmx_func &pwr_key_cfg_func>;
+
+			power {
+				wakeup-source;
+				gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+				label = "GPIO Power";
+				linux,code = <KEY_POWER>;
+			};
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2
