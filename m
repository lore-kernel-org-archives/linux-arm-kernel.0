From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 27 Jun 2016 09:09:57 -0400
Subject: [PATCH v2 3/3] dt-bindings: pwm: lpc32xx: Add nxp,
 pwm-disabled-level-high property
In-Reply-To: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1467032997-5340-4-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Document the nxp,pwm-disabled-level-high property used by the
pwm-lpc32xx driver to setup the pin output level to high when
the PWM is disabled.

The driver setup the pin output level to the reset value
by default.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
* New patch in version 2.

 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index 74b5bc5..5829f3f 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -4,6 +4,9 @@ Required properties:
 - compatible: should be "nxp,lpc3220-pwm"
 - reg: physical base address and length of the controller's registers
 
+Optional properties:
+- nxp,pwm-disabled-level-high: Set the PWM output level to high when disabled
+
 Examples:
 
 pwm at 4005c000 {
-- 
1.8.3.1
