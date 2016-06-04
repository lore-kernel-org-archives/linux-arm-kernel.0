From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:57 +0300
Subject: [PATCH 05/22] serial: clps711x: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt | 4 ++--
 drivers/tty/serial/clps711x.c                                     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
index caaeb25..07013fa 100644
--- a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
+++ b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
@@ -1,7 +1,7 @@
 * Cirrus Logic CLPS711X Universal Asynchronous Receiver/Transmitter (UART)
 
 Required properties:
-- compatible: Should be "cirrus,clps711x-uart".
+- compatible: Should be "cirrus,ep7209-uart".
 - reg: Address and length of the register set for the device.
 - interrupts: Should contain UART TX and RX interrupt.
 - clocks: Should contain UART core clock number.
@@ -20,7 +20,7 @@ Example:
 	};
 
 	uart1: uart at 80000480 {
-		compatible = "cirrus,clps711x-uart";
+		compatible = "cirrus,ep7312-uart","cirrus,ep7209-uart";
 		reg = <0x80000480 0x80>;
 		interrupts = <12 13>;
 		clocks = <&clks 11>;
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 5beafd2..ac13286 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -539,7 +539,7 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
-	{ .compatible = "cirrus,clps711x-uart", },
+	{ .compatible = "cirrus,ep7209-uart", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_uart_dt_ids);
-- 
2.4.9
