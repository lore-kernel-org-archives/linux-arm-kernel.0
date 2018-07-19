From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 19 Jul 2018 12:28:08 +0800
Subject: [PATCH v2 1/3] dt-binding: mmc: sunxi: add H6 compatible (with A64
 fallback)
In-Reply-To: <20180719042810.6546-1-icenowy@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
Message-ID: <20180719042810.6546-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC controllers on H6 is similar to the ones on A64, but with some
new features.

Add compatible strings for them (with the A64 compatible strings as
fallback, in order to make them to work with A64 drivers).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Add A64 fallback.

 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 132e0007d7d6..e9cb3ec5e502 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -16,6 +16,8 @@ Required properties:
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-emmc"
    * "allwinner,sun50i-a64-mmc"
+   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
+   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
-- 
2.17.1
