From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 Aug 2016 11:54:21 +0200
Subject: [PATCH v5 3/6] dt-bindings: media: meson-ir: Add Meson8b and GXBB
 compatible strings
In-Reply-To: <20160820095424.636-1-martin.blumenstingl@googlemail.com>
References: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160820095424.636-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160820095424.636-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

New bindings are needed as the register layout on the newer platforms
is slightly different compared to Meson6b.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/meson-ir.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/meson-ir.txt b/Documentation/devicetree/bindings/media/meson-ir.txt
index 407848e..e7e3f3c 100644
--- a/Documentation/devicetree/bindings/media/meson-ir.txt
+++ b/Documentation/devicetree/bindings/media/meson-ir.txt
@@ -1,7 +1,10 @@
 * Amlogic Meson IR remote control receiver
 
 Required properties:
- - compatible	: should be "amlogic,meson6-ir"
+ - compatible	: depending on the platform this should be one of:
+		  - "amlogic,meson6-ir"
+		  - "amlogic,meson8b-ir"
+		  - "amlogic,meson-gxbb-ir"
  - reg		: physical base address and length of the device registers
  - interrupts	: a single specifier for the interrupt from the device
 
-- 
2.9.3
