From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 6 Jan 2018 08:10:44 +0800
Subject: [PATCH v2 5/5] ARM64: dts: meson-axg: enable the UART_A controller
In-Reply-To: <20180106001044.108163-1-yixun.lan@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
Message-ID: <20180106001044.108163-6-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART_A is connected to a BT module on the S400 board.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 9c1b78028ccb..d56894dbb209 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -14,6 +14,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 	};
 };
 
@@ -24,6 +25,12 @@
 	pinctrl-names = "default";
 };
 
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>;
+	pinctrl-names = "default";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.15.1
