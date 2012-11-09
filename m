From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:19 +0100
Subject: [PATCH 0/6] of: add support for imx-wm8974
Message-ID: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series adds devicetree support for the wm8974 connected via SPI/SSI to an
imx. The series was developed on an imx27 with a wm8974 connected via SPI.
That is why two patches for the SPI subsystem are also provided, which may be
also usefull without the wm8974 stuff. As they are needed, I included them in
this series and did not send them separately. If this is wrong, please let me
know.

The driver and bindings are based on the imx-sgtl5000 driver and are tested with
	* spi-imx
	* fsl_ssi
	* imx-audmux (v1)

Regards,
Steffen

Steffen Trumtrar (6):
  spi: imx: specify spi base for device tree probe
  spi/devicetree: find spi_device via device_node
  ASoC: wm8974: include MCLKDIV in pll_factors
  ASoC: wm8974: add SPI as a possible bus master
  ARM i.MX: rename ssi1 clock for imx27
  ASoC: fsl: add imx-wm8974 machine driver

 .../devicetree/bindings/sound/imx-audio-wm8974.txt |   48 ++++
 arch/arm/mach-imx/clk-imx27.c                      |    2 +-
 arch/arm/mach-imx/imx27-dt.c                       |    1 +
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi.c                                  |   20 ++
 include/linux/spi/spi.h                            |    3 +
 sound/soc/codecs/Kconfig                           |    2 +-
 sound/soc/codecs/wm8974.c                          |  101 ++++++++-
 sound/soc/fsl/Kconfig                              |   12 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/imx-wm8974.c                         |  233 ++++++++++++++++++++
 11 files changed, 419 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt
 create mode 100644 sound/soc/fsl/imx-wm8974.c

-- 
1.7.10.4
