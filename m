From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 27 May 2014 10:24:17 +0200
Subject: [PATCH v5 0/8] ASoC: fsl-ssi: Driver cleanup
Message-ID: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are the remaining patches of this fsl-ssi cleanup series.

v5 adds the possibility to set the bitclock frequency using .set_dai_sysclk as
suggested. If it is not explicitly set, the bitclock is calculated using the
hw_params. I also added the missing signed-off-by tags to the patches.

Best Regards,

Markus


Markus Pargmann (4):
  ASoC: fsl-ssi: make fsl,mode property optional
  ASoC: fsl-ssi: Fix baudclock handling
  ASoC: fsl-ssi: reorder and document fsl_ssi_private
  ASoC: fsl-ssi: Use regmap

Sascha Hauer (4):
  ASoC: fsl-ssi: introduce SoC specific data
  ASoC: fsl-ssi: set bitclock in master mode from hw_params
  ASoC: fsl-ssi: remove unnecessary spinlock
  ASoC: fsl-ssi: Set framerate divider correctly for i2s master mode

 sound/soc/fsl/Kconfig   |   1 +
 sound/soc/fsl/fsl_ssi.c | 574 ++++++++++++++++++++++++++++--------------------
 sound/soc/fsl/fsl_ssi.h |  50 ++---
 3 files changed, 360 insertions(+), 265 deletions(-)

-- 
2.0.0.rc2
