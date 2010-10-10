From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 10 Oct 2010 20:10:39 +0300
Subject: [PATCHv2 0/4] ASoC AC97 audio support for ep93xx
Message-ID: <cover.1286729843.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds AC97 audio support for Cirrus Logic EP93xx family SoCs. Example
machine driver is for Simplemachines Sim.One (which is the only hardware that I
have which has AC97 codec).

The first patch is a bugfix for the DMA code. Without the patch audio DMA
transfers may corrupt if playing application is killed while playing. This
results weird noise playback when application is started again. I would like
Ryan Mallon to confirm that this is indeed correct fix and if possible to check
that I2S transfers still work after this patch is applied.

Please review.

Changes to previous revision:
	- patches are taken from the correct branch so they should apply on top
	  of latest mainline
	- increased cold reset sleep time

Thanks,
MW

Mika Westerberg (4):
  ARM: ep93xx: DMA: fix channel_disable
  ASoC: add ep93xx AC97 audio driver
  ARM: ep93xx: add AC97 platform support
  ASoC: ep93xx: add Simplemachines Sim.One AC97 audio support

 arch/arm/mach-ep93xx/core.c                     |   32 ++
 arch/arm/mach-ep93xx/dma-m2p.c                  |    2 +-
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    1 +
 sound/soc/ep93xx/Kconfig                        |   17 +-
 sound/soc/ep93xx/Makefile                       |    4 +
 sound/soc/ep93xx/ep93xx-ac97.c                  |  476 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-ac97.h                  |   17 +
 sound/soc/ep93xx/simone.c                       |   80 ++++
 10 files changed, 629 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.c
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.h
 create mode 100644 sound/soc/ep93xx/simone.c
