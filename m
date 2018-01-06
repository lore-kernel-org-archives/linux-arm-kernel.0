From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 6 Jan 2018 08:10:43 +0800
Subject: [PATCH v2 4/5] ARM64: dts: meson-axg: complete the pinctrl info for
 UART_AO_A
In-Reply-To: <20180106001044.108163-1-yixun.lan@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
Message-ID: <20180106001044.108163-5-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explictly request the pinctrl info for the UART_AO_A controller,
otherwise we may need to rely on bootloader for the initialization.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 447b98d30921..9c1b78028ccb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -26,6 +26,8 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
 &ir {
-- 
2.15.1
