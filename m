From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Sep 2011 20:45:14 -0500
Subject: [PATCH 2/2] devicetree: Add ARM pl022 spi controller binding doc
In-Reply-To: <1317174314-16122-1-git-send-email-robherring2@gmail.com>
References: <1317174314-16122-1-git-send-email-robherring2@gmail.com>
Message-ID: <1317174314-16122-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add binding documentation for ARM's Primecell PL022 SPI controller.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/spi/spi_pl022.txt          |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_pl022.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
new file mode 100644
index 0000000..306ec3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -0,0 +1,12 @@
+ARM PL022 SPI controller
+
+Required properties:
+- compatible : "arm,pl022", "arm,primecell"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain SPI controller interrupt
+
+Optional properties:
+- cs-gpios : should specify GPIOs used for chipselects.
+  The gpios will be referred to as reg = <index> in the SPI child nodes.
+  If unspecified, a single SPI device without a chip select can be used.
+
-- 
1.7.5.4
