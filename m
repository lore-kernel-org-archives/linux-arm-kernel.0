From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:52 +0200
Subject: [PATCH 6/6] dt-bindings: clk: oxnas,stdclk: Add OX820 bindings
In-Reply-To: <20161005150752.22618-1-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
Message-ID: <20161005150752.22618-7-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OX820 bindings and remove clock indices from bindings since they are present
in the dt-bindings headers files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/clock/oxnas,stdclk.txt        | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt b/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
index 208cca6..b652f3f 100644
--- a/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
+++ b/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
@@ -5,22 +5,15 @@ Please also refer to clock-bindings.txt in this directory for common clock
 bindings usage.
 
 Required properties:
-- compatible: Should be "oxsemi,ox810se-stdclk"
+- compatible: For OX810SE, should be "oxsemi,ox810se-stdclk"
+	      For OX820, should be "oxsemi,ox820-stdclk"
 - #clock-cells: 1, see below
 
 Parent node should have the following properties :
-- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
-
-For OX810SE, the clock indices are :
- - 0: LEON
- - 1: DMA_SGDMA
- - 2: CIPHER
- - 3: SATA
- - 4: AUDIO
- - 5: USBMPH
- - 6: ETHA
- - 7: PCIA
- - 8: NAND
+- compatible: For OX810SE, should be
+		"oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
+	      For OX820, should be
+		"oxsemi,ox820-sys-ctrl", "syscon", "simple-mfd"
 
 example:
 
-- 
2.7.0
