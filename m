From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Jul 2015 17:27:22 +0200
Subject: [PATCH v2 2/7] Documentation: bindings: document the clocks for
 pxa3xx-nand
In-Reply-To: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1436282847-21137-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx nand driver can optionally uses clocks if needed. Currently
two clocks can be specified: 'nfc' and 'ecc'. Add the corresponding
documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
index 4f833e3c4f51..d9aa0a6729a8 100644
--- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
@@ -11,6 +11,8 @@ Required properties:
 
 Optional properties:
 
+ - clocks:		A phandle to the clocks
+ - clock-names:		'nfc' and 'ecc'
  - marvell,nand-enable-arbiter:	Set to enable the bus arbiter
  - marvell,nand-keep-config:	Set to keep the NAND controller config as set
 				by the bootloader
@@ -32,6 +34,8 @@ Example:
 		compatible = "marvell,pxa3xx-nand";
 		reg = <0x43100000 90>;
 		interrupts = <45>;
+		clocks = <&gateclk 11>;
+		clock-names = "nfc";
 		#address-cells = <1>;
 
 		marvell,nand-enable-arbiter;
-- 
2.4.5
