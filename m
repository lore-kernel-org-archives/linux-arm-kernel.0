From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Wed, 21 Sep 2016 14:57:15 +0800
Subject: [v12,
 3/8] dt: bindings: move guts devicetree doc out of powerpc directory
In-Reply-To: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1474441040-11946-4-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/
since it's used by not only PowerPC but also ARM. And add a specification
for 'little-endian' property.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Scott Wood <oss@buserror.net>
---
Changes for v4:
	- Added this patch
Changes for v5:
	- Modified the description for little-endian property
Changes for v6:
	- None
Changes for v7:
	- None
Changes for v8:
	- Added 'Acked-by: Scott Wood'
	- Added 'Acked-by: Rob Herring'
Changes for v9:
	- None
Changes for v10:
	- None
Changes for v11:
	- None
Changes for v12:
	- None
---
 Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt | 3 +++
 1 file changed, 3 insertions(+)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
similarity index 91%
rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
index b71b203..07adca9 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
@@ -25,6 +25,9 @@ Recommended properties:
  - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
    registers, for those SOCs that have a PAMU device.
 
+ - little-endian : Indicates that the global utilities block is little
+   endian. The default is big endian.
+
 Examples:
 	global-utilities at e0000 {	/* global utilities block */
 		compatible = "fsl,mpc8548-guts";
-- 
2.1.0.27.g96db324
