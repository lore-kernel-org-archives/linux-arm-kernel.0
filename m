From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:47:34 +0100
Subject: Applied "spi: spi-davinci: Update binding for 66AK2Gx pwr dm
 property" to the spi tree
In-Reply-To: <20170908204638.13149-2-fcooper@ti.com>
Message-ID: <E1duIsA-0008VG-Dn@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-davinci: Update binding for 66AK2Gx pwr dm property

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 32c30f73687a7ea5fe6add62b7bc3b520115d0d9 Mon Sep 17 00:00:00 2001
From: Franklin Cooper <fcooper@ti.com>
Date: Fri, 8 Sep 2017 15:46:36 -0500
Subject: [PATCH] spi: spi-davinci: Update binding for 66AK2Gx pwr dm property

Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
unique clocks property usage.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-davinci.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f5916c92fe91..1925277bfc1e 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -24,6 +24,16 @@ Required properties:
 	based on a specific SoC configuration.
 - interrupts: interrupt number mapped to CPU.
 - clocks: spi clk phandle
+          For 66AK2G this property should be set per binding,
+          Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+
+SoC-specific Required Properties:
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the SPI device id
+			value. This property is as per the binding,
 
 Optional:
 - cs-gpios: gpio chip selects
-- 
2.14.1
