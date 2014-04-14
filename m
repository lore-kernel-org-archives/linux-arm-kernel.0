From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:30 +0200
Subject: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
Message-ID: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is a cleanup of the fsl-ssi driver.

There is no DT binding for regmap yet, as this should be solved in the regmap
framework first. The current configuration should at least work on the same
SoCs it was previously used. As soon as we have a common DT binding to set the
endianess we replace it in this driver.

Best regards,

Markus


Changes in v3:
 - Some new patches to improve/fix i2s master mode by Sascha
 - baudclock is enabled/disabled in startup/shutdown now
 - bitclock setup moved to a seperate function (not set_dai_sysclk)
 - Regmap config changed to NATIVE now.

Markus Pargmann (11):
  ASoC: fsl-ssi: Fix register values when disabling
  ASoC: fsl-ssi: Move debugging to seperate file
  ASoC: fsl-ssi: Use dev_name for DAI driver struct
  ASoC: fsl-ssi: Move imx-specific probe to seperate function
  ASoC: fsl-ssi: Remove useless DMA code
  ASoC: fsl-ssi: Cleanup probe function
  ASoC: fsl-ssi: Remove unnecessary variables from ssi_private
  ASoC: fsl-ssi: make fsl,mode property optional
  ASoC: fsl-ssi: Transmit enable synchronization
  ASoC: fsl-ssi: reorder and document fsl_ssi_private
  ASoC: fsl-ssi: Use regmap

Sascha Hauer (7):
  ASoC: fsl-ssi: introduce SoC specific data
  ASoC: fsl-ssi: Only enable baudclk when used
  ASoC: fsl-ssi: Move fsl_ssi_set_dai_sysclk above fsl_ssi_hw_params
  ASoC: fsl-ssi: set bitclock in master mode from hw_params
  ASoC: fsl-ssi: remove unnecessary spinlock
  ASoC: fsl-ssi: Allow first stream to set the bitclock
  ASoC: fsl-ssi: Set framerate divider correctly for i2s master mode

 sound/soc/fsl/Kconfig       |    1 +
 sound/soc/fsl/Makefile      |    3 +-
 sound/soc/fsl/fsl_ssi.c     | 1249 +++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  112 +++-
 sound/soc/fsl/fsl_ssi_dbg.c |  163 ++++++
 5 files changed, 807 insertions(+), 721 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_ssi_dbg.c

-- 
1.9.1
