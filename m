From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 27 Jan 2014 14:55:26 +0800
Subject: [PATCH v2 3/3] Binding: atmel-wm8904: add option to choose clock
In-Reply-To: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1390805726-1841-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the option to choose clock on which pin input to SSC (as slave).
Default is on TK pin to SSC, add "atmel,clk-from-rk-pin" option to
specify the clock is on RK pin to SSC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - using "-" replace "_" in binding document

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
index 8bbe50c..2d86e2b 100644
--- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
@@ -33,6 +33,12 @@ Required properties:
 
 Optional properties:
   - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+  - atmel,clk-from-rk-pin: bool property.
+     - When SSC works in slave mode, according to the hardware design, the
+       clock can get from TK pin, and also can get from RK pin. So, add
+       this parameter to choose where the clock from.
+     - By default the clock is from TK pin, if the clock from RK pin, this
+       property is needed.
 
 Example:
 sound {
-- 
1.8.5.2
