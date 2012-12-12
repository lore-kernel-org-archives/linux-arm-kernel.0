From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 12 Dec 2012 12:54:49 +0100
Subject: [PATCH 4/4 v2] devicetree: Add Renesas SH Mobile MSIOF spi controller
 binding doc
In-Reply-To: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1355313289-29769-4-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Add binding documentation for Renesas' MSIOF SPI controller.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2:
        - renamed property "chip_select" to "num-cs"
        - renamed property "tx_fifo_size" to "renesas,tx-fifo-size"
        - renamed property "rx_fifo_size" to "renesas,rx-fifo-size"

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
new file mode 100644
index 0000000..e622210
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -0,0 +1,12 @@
+Renesas MSIOF spi controller
+
+Required properties:
+- compatible : 	"renesas,sh-msiof" for SuperH or
+		"renesas,sh-mobile-msiof" for SH Mobile series
+- reg : Offset and length of the register set for the device
+- interrupts : interrupt line used by MSIOF
+
+Optional properties:
+- num-cs		: total number of chip-selects
+- renesas,tx-fifo-size	: Overrides the default tx fifo size given in words
+- renesas,rx-fifo-size	: Overrides the default rx fifo size given in words
-- 
1.7.9.5
