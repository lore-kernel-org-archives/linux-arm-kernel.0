From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jan 2017 17:28:00 +0000
Subject: [PATCH v2 06/10] dt-bindings: serial: Update 'uart-has-rtscts'
 description
In-Reply-To: <20170127172804.23881-1-lee.jones@linaro.org>
References: <20170127172804.23881-1-lee.jones@linaro.org>
Message-ID: <20170127172804.23881-7-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'uart-has-rtscts' property and 'rts-gpios|cts-gpios' are normally
mutually exclusive, however it is possible for some drivers to have
a dynamic approach, meaning that both properties can be relevant.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
index fd970f7..b542a0e 100644
--- a/Documentation/devicetree/bindings/serial/serial.txt
+++ b/Documentation/devicetree/bindings/serial/serial.txt
@@ -23,7 +23,8 @@ Optional properties:
     they are available for use (wired and enabled by pinmux configuration).
     This depends on both the UART hardware and the board wiring.
     Note that this property is mutually-exclusive with "cts-gpios" and
-    "rts-gpios" above.
+    "rts-gpios" above, unless support is provided to switch between modes
+    dynamically.
 
 
 Examples:
-- 
2.9.3
