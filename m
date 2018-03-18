From: andre.przywara@arm.com (Andre Przywara)
Date: Sun, 18 Mar 2018 23:28:46 +0000
Subject: [PATCH v2 3/4] dt-bindings: pwm: sunxi: add new compatible strings
In-Reply-To: <20180318232847.14278-1-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Message-ID: <20180318232847.14278-4-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM controllers found in the Allwinner A64 and H5 SoCs are fully
compatible to the PWM controllers found in the A13 and H3.
Add new compatible strings for those SoCs to the binding document, so
that they can be safely used, together with a fallback string
(preferably "allwinner,sun5i-a13-pwm").

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index 51ff54c8b8ef..2a1affbff45e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -7,6 +7,8 @@ Required properties:
     - "allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
+    - "allwinner,sun50i-a64-pwm", "allwinner,sun5i-a13-pwm"
+    - "allwinner,sun50i-h5-pwm", "allwinner,sun5i-a13-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
     the cells format.
-- 
2.14.1
