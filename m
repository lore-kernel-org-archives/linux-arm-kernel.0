From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:26 +0100
Subject: [PATCH v3 4/6] spi: pxa2xx: dt-bindings: Add ready GPIO signal
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-5-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This this is used to let the SPI master know that our FIFO is filled and
we're ready to service a transfer. Only useful in slave mode.

A signal like this is used by an embedded controller on a OLPC XO 1.75
machine, that happens to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- s/ready-gpio/ready-gpios/
- Updated the subject line to conform with subsystem customs

 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
index 89b2832283e3..e30e0c2a4bce 100644
--- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -12,6 +12,8 @@ Optional properties:
 - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
   Documentation/devicetree/bindings/spi/spi-bus.txt
 - spi-slave: Empty property indicating the SPI controller is used in slave mode.
+- ready-gpios: GPIO used to signal a SPI master that the FIFO is filled
+  and we're ready to service a transfer. Only useful in slave mode.
 
 Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
-- 
2.19.1
