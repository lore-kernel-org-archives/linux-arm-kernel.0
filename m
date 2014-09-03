From: dianders@chromium.org (Doug Anderson)
Date: Wed,  3 Sep 2014 13:44:27 -0700
Subject: [PATCH 3/3] dt-bindings: spi/rockchip: Mark DMA as optional
In-Reply-To: <1409777067-17422-1-git-send-email-dianders@chromium.org>
References: <1409777067-17422-1-git-send-email-dianders@chromium.org>
Message-ID: <1409777067-17422-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip SPI controller works fine without DMA (aside from a few
warnings).  The DMA property even implies this, saying:

  DMA request names should include "tx" and "rx" if present.

Officially mark the properties as optional.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 7bab355..467dec4 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -16,11 +16,15 @@ Required Properties:
 - clocks: Must contain an entry for each entry in clock-names.
 - clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
 			   the peripheral clock.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Optional Properties:
+
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
+
 
 Example:
 
-- 
2.1.0.rc2.206.gedb03e5
