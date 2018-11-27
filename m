From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:46 +0100
Subject: [PATCH 45/77] ARM: dts: sun7i: som204: Use the UART3 TX and RX pin
 group
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <a759b993e411da67166b0a6a86e79c6b93b7b421.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SOM204-EVB doesn't use the CTS pin, and thus was defining its own
pinctrl node for the UART3 muxing. Since we split away the TX and RX pin,
we can use the global node now, and only have the RTS pin in our local
node.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index 631a80ae958e..249bb57d50e0 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -203,8 +203,8 @@
 };
 
 &pio {
-	bt_uart_pins: bt_uart_pins at 0 {
-		pins = "PG6", "PG7", "PG8";
+	uart3_rts_pin: uart3-rts-pin {
+		pins = "PG8";
 		function = "uart3";
 	};
 };
@@ -296,7 +296,7 @@
 /* Used for RTL8723BS bluetooth */
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&bt_uart_pins>;
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_rts_pin>;
 	status = "okay";
 };
 
-- 
git-series 0.9.1
