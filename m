From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Jun 2017 14:05:44 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: amlogic: Add SoC information bindings
In-Reply-To: <1497441946-24379-1-git-send-email-narmstrong@baylibre.com>
References: <1497441946-24379-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497441946-24379-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for the SoC information register of the Amlogic SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 5c01e65..a6d8754 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -60,3 +60,32 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,q201" (Meson gxm s912)
   - "kingnovel,r-box-pro" (Meson gxm S912)
   - "nexbox,a1" (Meson gxm s912)
+
+Amlogic Meson Firmware registers Interface
+------------------------------------------
+
+The Meson SoCs have a register bank with status and data shared with the
+secure firmware.
+
+Required properties:
+ - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
+
+Properties should indentify components of this register interface :
+
+Meson GX SoC Information
+------------------------
+A firmware register encodes the SoC type, package and revision information on
+the Meson GX SoCs.
+If present, the following property should be added :
+
+Optional properties:
+  - has-chip-id: If present, the interface gives the current SoC version.
+
+Example
+-------
+
+ao-secure at 140 {
+	compatible = "amlogic,meson-gx-ao-secure", "syscon";
+	reg = <0x0 0x140 0x0 0x140>;
+	has-chip-id;
+};
-- 
1.9.1
