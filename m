From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 22:48:35 +0800
Subject: [PATCH 0/4] ASoC: merge imx into fsl
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second step towards reusing fsl_ssi driver on device tree
based IMX platforms.  The series merges sound/soc/imx into sound/soc/fsl
and makes fsl_ssi driver compilable on ARM/IMX.

Compile-tested for PowerPC.

Shawn Guo (4):
      ASoC: imx: add an explicit Kconfig option for imx-ssi driver
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX

 sound/soc/Makefile                       |    1 -
 sound/soc/fsl/Kconfig                    |   99 ++++++++++++++++++++++++++++--
 sound/soc/fsl/Makefile                   |   22 ++++++-
 sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
 sound/soc/fsl/fsl_ssi.c                  |   75 ++++++++++++++---------
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0
 sound/soc/{imx => fsl}/imx-pcm-fiq.c     |    0
 sound/soc/{imx => fsl}/imx-pcm.c         |    0
 sound/soc/{imx => fsl}/imx-pcm.h         |    0
 sound/soc/{imx => fsl}/imx-ssi.c         |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h         |    0
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c |    0
 sound/soc/{imx => fsl}/phycore-ac97.c    |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c      |    0
 sound/soc/imx/Kconfig                    |   64 -------------------
 sound/soc/imx/Makefile                   |   19 ------
 17 files changed, 162 insertions(+), 123 deletions(-)
