From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 13 May 2014 20:20:41 +0200
Subject: [PATCH RESEND 1/5] tty/serial: atmel_serial: Fix device tree
 documentation
In-Reply-To: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1400005245-11943-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTS pin is an active low pin.
For now, this doesn't change anything as the ACTIVE_LOW flag is not
handled in atmel_serial, but it will be in 3.16.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 17c1042..2f7aad7 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -35,7 +35,7 @@ Example:
 		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
-		rts-gpios = <&pioD 15 0>;
+		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
 	};
 
 - use DMA:
-- 
1.7.10.4
