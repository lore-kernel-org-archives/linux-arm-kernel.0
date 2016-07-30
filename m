From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 30 Jul 2016 17:56:37 +0200
Subject: [PATCH v2 1/2] ASoC: sunxi: Add bindings for sun6i to SPDIF
In-Reply-To: <20160730155638.24455-1-codekipper@gmail.com>
References: <20160730155638.24455-1-codekipper@gmail.com>
Message-ID: <20160730155638.24455-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
reset is controlled via a separate reset controller.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 13503aa..0230c4d 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -9,6 +9,7 @@ Required properties:
 
   - compatible		: should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
 
   - reg			: Offset and length of the register set for the device.
 
@@ -25,6 +26,8 @@ Required properties:
 	"apb"		  clock for the spdif bus.
 	"spdif"		  clock for spdif controller.
 
+  - resets		: reset specifier for the ahb reset (A31 and newer only)
+
 Example:
 
 spdif: spdif at 01c21000 {
-- 
2.9.2
