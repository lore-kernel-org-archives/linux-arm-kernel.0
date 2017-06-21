From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Jun 2017 12:21:28 +0200
Subject: [PATCH 7/9] ARM: dts/imx: ensure UARTs used for rs485 specify
 rs485-rts-delay
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170621102130.21024-8-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/serial/rs485.txt the
rs485-rts-delay parameter is required. To prepare making use of
of_get_rs485_mode which is strict here, add this property to all imx
compatible devices that make use of one of the optional properties.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 5d94b5ee6aa0..669bb8446574 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -288,6 +288,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
 	uart-has-rtscts;
+	rs485-rts-delay = <0 0>;
 	linux,rs485-enabled-at-boot-time;
 	status = "okay";
 };
-- 
2.11.0
