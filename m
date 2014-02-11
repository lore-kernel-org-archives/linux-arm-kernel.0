From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:08 +0000
Subject: [PATCH 3/7] Documentation: devicetree: fix up pl022 clocks
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the pl022 driver expects clocks, and dts provide them, yet the
binding does not mention clocks at all.

This patch adds a description of the clocks, "apb_pclk" (as required by
the primecell binding) and "sspclk" for the pl022 itself. The "sspclk"
name was chosen to match the official documentation, as currently a
variety of names are used in its place; it is expected that any
operating system supporting these can continue to do so in the absence
of an "sspclk" entry.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/spi/spi_pl022.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
index 22ed679..326e8e2 100644
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -21,6 +21,8 @@ Optional properties:
 - dma-names: Names for the dma channels, if present. There must be at
 	     least one channel named "tx" for transmit and named "rx" for
              receive.
+- clocks: phandle + clock-specifiers, one for each entry in clock-names.
+- clock-names: should contain "apb_pclk" and "sspclk".
 
 
 SPI slave nodes must be children of the SPI master node and can
-- 
1.8.1.1
