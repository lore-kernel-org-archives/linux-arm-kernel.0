From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 28 Apr 2016 19:03:39 -0300
Subject: [PATCH v3 2/3] devicetree: leds: Introduce "panic-indicator" optional
 property
In-Reply-To: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1461881020-13964-3-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's desirable to specify which LEDs are to be blinked on a kernel
panic. Therefore, introduce a devicetree boolean property to mark
which LEDs should be treated this way, if possible.

Acked-by: Rob Herring <rob@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 Documentation/devicetree/bindings/leds/common.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 68419843e32f..af10678ea2f6 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -37,6 +37,9 @@ Optional properties for child nodes:
                      property is mandatory for the LEDs in the non-flash modes
                      (e.g. torch or indicator).
 
+- panic-indicator : This property specifies that the LED should be used,
+		    if at all possible, as a panic indicator.
+
 Required properties for flash LED child nodes:
 - flash-max-microamp : Maximum flash LED supply current in microamperes.
 - flash-max-timeout-us : Maximum timeout in microseconds after which the flash
-- 
2.7.0
