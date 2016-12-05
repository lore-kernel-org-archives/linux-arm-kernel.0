From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon,  5 Dec 2016 02:10:25 +0200
Subject: [PATCH] dt: pwm: bcm2835: fix typo in clocks property name
Message-ID: <20161205001025.13909-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the examples of BCM2835 PWM device nodes there is a typo in
'clocks' property name, which is a common property name on clock consumer
side to store a phandle to an input clock.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index fb6fb31..cf573e8 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -3,7 +3,7 @@ BCM2835 PWM controller (Raspberry Pi controller)
 Required properties:
 - compatible: should be "brcm,bcm2835-pwm"
 - reg: physical base address and length of the controller's registers
-- clock: This clock defines the base clock frequency of the PWM hardware
+- clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
 - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
-- 
2.10.2
