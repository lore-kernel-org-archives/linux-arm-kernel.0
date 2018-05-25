From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Fri, 25 May 2018 15:34:21 +0300
Subject: [PATCH v4 0/7] ASoC: add driver for Atmel I2S controller
Message-ID: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rework of Cyrille's patches named:
[PATCH v3 0/2] ASoC: add driver for Atmel I2S controller
https://lkml.org/lkml/2015/9/29/454

This is the version 4 of the series, and addresses the received feedback
on the mailing lists.

This series applies on top of asoc-next branch of broonie/sound.git.

Based on received feedback, I created a mux clock driver to select the I2S
clock source, that also includes proper devicetree bindings and nodes.
Also, I added the I2S nodes in sama5d2's devicetree, with the missing
pin muxing for the second I2S controller.

This series of patches adds support to the new Atmel I2S controller
embedded on sama5d2 SoCs.

ChangeLog

v3 -> v4
 - as suggested by Rob Herring:
   - added a clock mux driver for I2S's clock control bit;
   - more precise description of I2S's devicetree bindings;
   - removed SoC and internal detalls from bindings;
 - addressed comments from Mark Brown;
 - added devicetree nodes and pin muxing for I2S;

v2 -> v3
- fix the coding style, add some more comments and add a section dedicated
  to sama5d2 SoCs in the DT binding documentation as suggested by Mark
  Brown.

v1 -> v2
- initialize dev->dev before calling dev->caps->mck_init()


Codrin Ciubotariu (3):
  dt-bindings: clk: at91: add an I2S mux clock
  clk: at91: add I2S clock mux driver
  ARM: dts: at91: sama5d2: add I2S clock muxing nodes

Cyrille Pitchen (4):
  ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller
  ASoC: atmel-i2s: add driver for the new Atmel I2S controller
  ARM: dts: at91: sama5d2: add nodes for I2S controllers
  ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 .../devicetree/bindings/clock/at91-clock.txt       |  34 +
 .../devicetree/bindings/sound/atmel-i2s.txt        |  47 ++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  28 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  52 ++
 arch/arm/mach-at91/Kconfig                         |   4 +
 drivers/clk/at91/Makefile                          |   1 +
 drivers/clk/at91/clk-i2s-mux.c                     | 117 ++++
 sound/soc/atmel/Kconfig                            |   9 +
 sound/soc/atmel/Makefile                           |   2 +
 sound/soc/atmel/atmel-i2s.c                        | 765 +++++++++++++++++++++
 10 files changed, 1059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
 create mode 100644 drivers/clk/at91/clk-i2s-mux.c
 create mode 100644 sound/soc/atmel/atmel-i2s.c

-- 
2.7.4
