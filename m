From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu,  5 Mar 2015 12:31:18 +0100
Subject: [PATCH v3 2/9] Documentation: bindings: document the clocks for
 pxa3xx-nand
In-Reply-To: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425555085-29531-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx nand driver requires at least one clock to probe correctly.
A second one, named 'ecc' can be specified if needed. Add the
corresponding documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
index de8b517a5521..ecd1fc071f81 100644
--- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
@@ -8,6 +8,8 @@ Required properties:
  - reg: 		The register base for the controller
  - interrupts:		The interrupt to map
  - #address-cells:	Set to <1> if the node includes partitions
+ - clocks:		A phandle to the clocks
+ - clock-names:		'nfc' and 'ecc'. The 'nfc' clock is mandatory.
 
 Optional properties:
 
@@ -32,6 +34,8 @@ Example:
 		compatible = "marvell,pxa3xx-nand";
 		reg = <0x43100000 90>;
 		interrupts = <45>;
+		clocks = <&gateclk 11>;
+		clock-names = "nfc";
 		#address-cells = <1>;
 
 		marvell,nand-enable-arbiter;
-- 
2.3.1
