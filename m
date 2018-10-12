From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Oct 2018 13:25:23 +0900
Subject: [PATCH v2 1/2] dt-bindings: uniphier: add bindings for UniPhier SoC
 family
Message-ID: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the list of SoCs and boards of UniPhier platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  Changes suggested by Rob.
  - Move the file to
    Documentation/devicetree/bindings/arm/socionext/uniphier.txt
  - Group boards by each SoC

Previous posts:
  v1: https://patchwork.ozlabs.org/patch/842010/

 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt

diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
new file mode 100644
index 0000000..dafc466
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
@@ -0,0 +1,47 @@
+Socionext UniPhier SoC family
+-----------------------------
+
+Required properties in the root node:
+  - compatible: should contain board and SoC compatible strings
+
+SoC and board compatible strings:
+  (sorted chronologically)
+
+  - LD4 SoC:  "socionext,uniphier-ld4"
+      - Reference board: "socionext,uniphier-ld4-ref"
+
+  - Pro4 SoC: "socionext,uniphier-pro4"
+      - Reference Board: "socionext,uniphier-pro4-ref"
+      - Ace Board:       "socionext,uniphier-pro4-ace"
+      - Sanji Board:     "socionext,uniphier-pro4-sanji"
+
+  - sLD8 SoC: "socionext,uniphier-sld8"
+      - Reference Board: "socionext,uniphier-sld8-ref"
+
+  - PXs2 SoC: "socionext,uniphier-pxs2"
+      - Gentil Board:    "socionext,uniphier-pxs2-gentil"
+      - Vodka Board:     "socionext,uniphier-pxs2-vodka"
+
+  - LD6b SoC: "socionext,uniphier-ld6b"
+      - Reference Board: "socionext,uniphier-ld6b-ref"
+
+  - LD11 SoC: "socionext,uniphier-ld11"
+      - Reference Board: "socionext,uniphier-ld11-ref"
+      - Global Board:    "socionext,uniphier-ld11-global"
+
+  - LD20 SoC: "socionext,uniphier-ld20"
+      - Reference Board: "socionext,uniphier-ld20-ref"
+      - Global Board:    "socionext,uniphier-ld20-global"
+
+  - PXs3 SoC: "socionext,uniphier-pxs3"
+      - Reference Board: "socionext,uniphier-pxs3-ref"
+
+Example:
+
+/dts-v1/;
+
+/ {
+	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
+
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index a5c951c..c0c2abb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2183,6 +2183,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/socionext/uniphier.txt
 F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
 F:	arch/arm/boot/dts/uniphier*
-- 
2.7.4
