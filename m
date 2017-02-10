From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 10 Feb 2017 11:00:46 +0100
Subject: [PATCH RESEND] ASoC: sun4i-i2s: Update binding documentation to
 include A31
Message-ID: <20170210100046.32647-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible for sun4i-i2s driver to handle some
SoCs that have a reset line that must be asserted/deasserted.

This new compatible, "allwinner,sun6i-a31-i2s", requires the
property "resets" which should be a phandle to the reset line.
Except these differences, the compatible is identical to previous one
which will not handle a reset line.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 7b526ec64991..f4adc58f82ba 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the followings
    - "allwinner,sun4i-a10-i2s"
+   - "allwinner,sun6i-a31-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -19,6 +20,10 @@ Required properties:
    - "mod" : module clock for the I2S controller
 - #sound-dai-cells : Must be equal to 0
 
+Required properties for the following compatibles:
+	- "allwinner,sun6i-a31-i2s"
+- resets: phandle to the reset line for this codec
+
 Example:
 
 i2s0: i2s at 01c22400 {
-- 
2.11.0
