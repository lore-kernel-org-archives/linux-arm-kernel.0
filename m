From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Nov 2018 18:34:56 +0000 (GMT)
Subject: Applied "spi: pxa2xx: dt-bindings: Add ready GPIO signal" to the spi
 tree
In-Reply-To: <20181113102228.820214-5-lkundrak@v3.sk>
Message-ID: <20181113183456.EF1D144007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: dt-bindings: Add ready GPIO signal

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8ae13d0b0d4bb4af99bec8c50152f0c8f5cbcc06 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Tue, 13 Nov 2018 11:22:26 +0100
Subject: [PATCH] spi: pxa2xx: dt-bindings: Add ready GPIO signal

This this is used to let the SPI master know that our FIFO is filled and
we're ready to service a transfer. Only useful in slave mode.

A signal like this is used by an embedded controller on a OLPC XO 1.75
machine, that happens to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
