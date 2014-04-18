From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 18 Apr 2014 17:45:04 +0200
Subject: [PATCH RESEND] tty/serial: atmel_serial: Fix device tree documentation
Message-ID: <1397835904-866-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTS pin is an active low pin.
For now, this doesn't change anything as the ACTIVE_LOW (1) flag is not
handled in atmel_serial, but it will be in 3.16.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 17c1042b2df8..0dd0a5493a54 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -35,7 +35,7 @@ Example:
 		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
-		rts-gpios = <&pioD 15 0>;
+		rts-gpios = <&pioD 15 1>;
 	};
 
 - use DMA:
-- 
1.8.5.5
