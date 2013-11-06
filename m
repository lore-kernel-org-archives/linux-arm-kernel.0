From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:16:12 +0000
Subject: [PATCH 00/13] ASoC: dma: ARM: ux500: Obtain DMA data from Device Tree
Message-ID: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At this moment in time the Ux500 ASoC driver obtains its DMA information
via AUXDATA platform data passing. To make the driver more independent
we have to start extracting it from the Device Tree.

Ideally this patch-set should stay together, so can you guys either
agree to take it through a single tree, or create a non-disputable
branch that you can all pull from after the Acks have been collected
please? In fact, I can do that for you if that makes things easier.

Kind regards,
Lee

Lee Jones (13):
  dma: ste_dma40: Expand DT binding to accept 'high-priority channel' flag
  dma: ste_dma40: Parse flags property for new 'high priority channel' request
  ARM: ux500: Don't use enums for MSP IDs - for easy DT conversion
  ARM: ux500: Add DMA config bindings for MSP devices
  ARM: ux500: Add ID properties to 'simply' differentiate between MSPs
  ASoC: ux500_pcm: Extend ux500 MSP binding for enumeration
  ASoC: ux500_pcm: Extract MSP IDs from Device Tree
  ASoC: generic-dmaengine-pcm: Clear slave_config memory
  ASoC: Ux500: Match platform by device node when booting Device Tree
  ASoC: ux500_pcm: Extend Device Tree support to deal with DMA data
  ASoC: ux500: Store DMA data in the DAI differently in the pdata and DT case
  ASoC: ux500_pcm: Differentiate between pdata and DT initialisation
  ASoC: ux500_pcm: Take out pointless dev_dbg() call

 .../devicetree/bindings/dma/ste-dma40.txt          |  3 ++
 .../devicetree/bindings/sound/ux500-msp.txt        |  3 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 23 ++++++++
 arch/arm/mach-ux500/board-mop500-audio.c           |  8 +--
 drivers/dma/ste_dma40.c                            |  4 ++
 include/linux/platform_data/asoc-ux500-msp.h       |  9 +---
 sound/soc/soc-generic-dmaengine-pcm.c              |  2 +
 sound/soc/ux500/mop500.c                           |  2 +
 sound/soc/ux500/ux500_msp_dai.c                    | 41 ++++++++++++++-
 sound/soc/ux500/ux500_msp_i2s.c                    | 61 +++++++++++++++++-----
 sound/soc/ux500/ux500_msp_i2s.h                    |  2 +-
 sound/soc/ux500/ux500_pcm.c                        | 32 ++++++++----
 12 files changed, 152 insertions(+), 38 deletions(-)

-- 
1.8.1.2
