From: kevans@FreeBSD.org (kevans at FreeBSD.org)
Date: Thu, 19 Apr 2018 09:11:03 -0500
Subject: [PATCH v3] ARM: dts: sunxi: Add sid for a83t
Message-ID: <20180419141103.38196-1-kevans@FreeBSD.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner a83t has a 1 KB sid block with efuse for security rootkey and thermal
calibration data, add node to describe it.

a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
supported in an external driver for FreeBSD.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
---

Changes in v3:
- rebased against 4.17

Changes in v2:
- remove bogus "From:" line in commit text, no functional change

 .../devicetree/bindings/nvmem/allwinner,sunxi-sid.txt        | 1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d69543701d5d..e319fe5e205a 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be one of the following:
   "allwinner,sun4i-a10-sid"
   "allwinner,sun7i-a20-sid"
+  "allwinner,sun8i-a83t-sid"
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
 
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 568307639be8..379981389eea 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -492,6 +492,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 1c14000 {
+			compatible = "allwinner,sun8i-a83t-sid";
+			reg = <0x1c14000 0x400>;
+		};
+
 		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-a83t-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.17.0
