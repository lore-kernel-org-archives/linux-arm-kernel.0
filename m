From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 09:58:10 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT documentation
Message-ID: <20140320092639.48F68A6279@smtp3-g21.free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C address (reg) is required for the TDA998x driver to be loaded
and initialized.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch applies to linux-next.
---
 Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index d7df01c..fc7effa 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -3,6 +3,8 @@ Device-Tree bindings for the NXP TDA998x HDMI transmitter
 Required properties;
   - compatible: must be "nxp,tda998x"
 
+  - reg: I2C address - must be <0x70>
+
 Optional properties:
   - interrupts: interrupt number and trigger type
 	default: polling
-- 
1.9.1
