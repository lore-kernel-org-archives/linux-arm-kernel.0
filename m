From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 20 Aug 2013 17:42:37 +0800
Subject: [PATCH] i2c: imx: use exact SoC revision document binding
Message-ID: <1376991757-9727-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use exact SoC revision instead of wildcard describing
the compatible property requirement in the binding
document. This will make the binding more clearer.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index 3614242..4e7282d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -1,7 +1,10 @@
 * Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.MX
 
 Required properties:
-- compatible : Should be "fsl,<chip>-i2c"
+- compatible :
+  - "fsl,imx1-i2c" for I2C used similar to that on i.MX1 SoC
+  - "fsl,imx21-i2c" for I2C used similar to that on i.MX21 SoC
+  - "fsl,vf610-i2c" for I2C used similar to that on Vybrid vf610 SoC
 - reg : Should contain I2C/HS-I2C registers location and length
 - interrupts : Should contain I2C/HS-I2C interrupt
 
-- 
1.8.0
