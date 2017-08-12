From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 12 Aug 2017 12:19:43 +0200
Subject: [PATCH V2 1/2] dt-bindings: pwm-bcm2835: Increase pwm-cells
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1502533184-15765-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to increase the pwm-cells for the optional flags parameter,
before we can implement support for polarity setting via DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index cf573e8..8cf87d1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -6,7 +6,7 @@ Required properties:
 - clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
-- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
 Examples:
@@ -15,7 +15,7 @@ pwm at 2020c000 {
 	compatible = "brcm,bcm2835-pwm";
 	reg = <0x2020c000 0x28>;
 	clocks = <&clk_pwm>;
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 };
 
 clocks {
-- 
2.7.4
