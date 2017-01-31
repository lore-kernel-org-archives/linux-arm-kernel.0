From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue, 31 Jan 2017 11:05:45 +0100
Subject: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
In-Reply-To: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
Message-ID: <20170131100552.27949-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible for sun4i-i2s driver to handle some
SoCs that have a reset line that must be asserted/deasserted.

This new compatible, "allwinner,sun6i-a31-i2s", requires the
property "resets" which should be a phandle to the reset line.
Except these differences, the compatible is identical to previous one
which will not handle a reset line.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 7a2c0945fd22..b71df552bc0c 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the following:
    - "allwinner,sun4i-a10-i2s"
+   - "allwinner,sun6i-a31-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -19,6 +20,10 @@ Required properties:
    - "mod" : module clock for the I2S controller
 - #sound-dai-cells : Must be equal to 0
 
+Required properties for the following compatibles:
+		- "allwinner,sun6i-a31-i2s"
+- resets: phandle to the reset line for this codec
+
 Example:
 
 i2s0: i2s at 01c22400 {
-- 
2.11.0
