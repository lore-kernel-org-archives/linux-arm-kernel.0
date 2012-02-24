From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:35 +0800
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third series towards reusing fsl_ssi driver on device tree
based IMX platforms.  It makes a few cleanups on existing PowerPC code
to ease the later addition of an IMX machine driver that works on
fsl_ssi.

Shawn Guo (6):
      ASoC: fsl: correct get_dma_channel parameter name
      ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting codec node
      ASoC: Remove unnecessary -codec from cs4270 driver name
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: use platform_device_id table to match p1022_ds device
      ASoC: fsl: check property 'compatible' for the machine name

 sound/soc/codecs/cs4270.c    |    2 +-
 sound/soc/fsl/Kconfig        |    5 +
 sound/soc/fsl/Makefile       |    2 +
 sound/soc/fsl/fsl_ssi.c      |    6 +-
 sound/soc/fsl/fsl_utils.c    |  153 ++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h    |   29 +++++++
 sound/soc/fsl/mpc8610_hpcd.c |  167 +++----------------------------------
 sound/soc/fsl/p1022_ds.c     |  185 ++++-------------------------------------
 sound/soc/pxa/raumfeld.c     |    2 +-
 9 files changed, 226 insertions(+), 325 deletions(-)
