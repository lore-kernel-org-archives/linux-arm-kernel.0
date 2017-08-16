From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 17:17:15 -0500
Subject: [PATCH v2 3/3] dt-bindings: i2c: i2c-davinci: Update binding for
 66AK2Gx pwr dm property
In-Reply-To: <20170816221715.15027-1-fcooper@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
Message-ID: <20170816221715.15027-4-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
unique clocks property usage.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
index 5b123e0..64e6e65 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
@@ -6,6 +6,18 @@ davinci/keystone i2c interface contains.
 Required properties:
 - compatible: "ti,davinci-i2c" or "ti,keystone-i2c";
 - reg : Offset and length of the register set for the device
+- clocks: I2C functional clock phandle.
+	  For 66AK2G this property should be set per binding,
+	  Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+
+SoC-specific Required Properties:
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the I2C device id
+			value. This property is as per the binding,
+			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
 Recommended properties :
 - interrupts : standard interrupt property.
-- 
2.9.4.dirty
