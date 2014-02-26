From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:03 +0100
Subject: [PATCH 00/15] ASoC: fsl-ssi: Driver cleanup
Message-ID: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a series of cleanups for the fsl-ssi driver.

It would be great if someone with PPC hardware and this fsl-ssi unit could
please test this series. I am not sure if the regmap patch works as expected on
PPC as well.

I tested this series on imx53 quick starter board and a custom board. Both with
SSI as I2S slave.

Regards,

Markus


Markus Pargmann (15):
  ASoC: fsl-ssi: Use regmap
  ASoC: fsl-ssi: Remove fsl_ssi_setup
  ASoC: fsl-ssi: Move debugging to seperate file
  ASoC: fsl-ssi: Use dev_name for DAI driver struct
  ASoC: fsl-ssi: Move imx-specific probe to seperate function
  ASoC: fsl-ssi: Remove useless DMA code
  ASoC: fsl-ssi: baud clock error handling
  ASoC: fsl-ssi: Cleanup probe function
  ASoC: fsl-ssi: Remove unnecessary variables from ssi_private
  ASoC: fsl-ssi: reorder and document fsl_ssi_private
  ASoC: fsl-ssi: Fix register values when disabling
  ASoC: fsl-ssi: Only enable baudclk when used
  ASoC: fsl-ssi: Set default dai-fmts
  ASoC: fsl-ssi: Transmit enable synchronization
  ASoC: fsl-ssi: Update binding documentation

 .../devicetree/bindings/sound/fsl,ssi.txt          |   21 +-
 sound/soc/fsl/Kconfig                              |    1 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl_ssi.c                            | 1167 ++++++++------------
 sound/soc/fsl/fsl_ssi.h                            |  112 +-
 sound/soc/fsl/fsl_ssi_dbg.c                        |  163 +++
 6 files changed, 750 insertions(+), 716 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_ssi_dbg.c

-- 
1.8.5.3
