From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:04:05 +0800
Subject: [PATCH v4 08/20] arm64: dts: hikey960: add WL1837 Bluetooth device
 node
In-Reply-To: <20170615030417.14059-1-guodong.xu@linaro.org>
References: <20170615030417.14059-1-guodong.xu@linaro.org>
Message-ID: <20170615030417.14059-9-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the serial slave device for the WL1837 Bluetooth interface.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 0a3f2e0..c25fff9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -9,6 +9,7 @@
 
 #include "hi3660.dtsi"
 #include "hikey960-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "HiKey960";
@@ -63,6 +64,16 @@
 	status = "okay";
 };
 
+&uart4 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio15 6 GPIO_ACTIVE_HIGH>;
+		max-speed = <921600>;
+	};
+};
+
 &uart6 {
 	/* On Low speed expansion */
 	label = "LS-UART1";
-- 
2.10.2
