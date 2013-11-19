From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Nov 2013 11:07:39 +0000
Subject: [PATCH 00/10] ASoC: dma: ARM: ux500: Obtain DMA data from Device Tree
Message-ID: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At this moment in time the Ux500 ASoC driver obtains its DMA information
via AUXDATA platform data passing. To make the driver more independent
we have to start extracting it from the Device Tree.
 
If this patch-set could go through ASoC as a whole, it would drive down
the chance of a dependency mess. Vinod has already provided Acks for his
parts, so it's just between you two Linus and Mark.

 Documentation/devicetree/bindings/dma/ste-dma40.txt |   3 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                   |  15 ++++++++++
 arch/arm/mach-ux500/board-mop500-audio.c            |   8 +++---
 drivers/dma/ste_dma40.c                             |   4 +++
 include/linux/platform_data/asoc-ux500-msp.h        |   9 +-----
 sound/soc/ux500/mop500.c                            |   2 ++
 sound/soc/ux500/ux500_msp_dai.c                     | 150 +++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 sound/soc/ux500/ux500_msp_i2s.c                     |  56 +++++++++++++++++++++++++++----------
 sound/soc/ux500/ux500_msp_i2s.h                     |   2 +-
 sound/soc/ux500/ux500_pcm.c                         |  32 +++++++++++++++------
 10 files changed, 160 insertions(+), 121 deletions(-)

Cc: Mark Brown <broonie@kernel.org>
