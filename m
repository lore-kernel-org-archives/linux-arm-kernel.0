From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 14 Oct 2010 17:49:05 +0300
Subject: [PATCH v3 0/3] ASoC AC97 audio support for ep93xx
Message-ID: <cover.1287066937.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds AC97 audio support for Cirrus Logic EP93xx family SoCs. Example
machine driver is for Simplemachines Sim.One (which is the only hardware that I
have which has AC97 codec).

Changes the previous version:
	- rebased against latest ASoC tree (added support for
	  multicomponent ASoC)
	- fixed according comments by Mark Brown
	- patch 1/4 (DMA fix) is now in ARM tree so dropped from
	  this series.

Thanks,
MW

Mika Westerberg (3):
  ASoC: add ep93xx AC97 audio driver
  ARM: ep93xx: add AC97 platform support
  ASoC: ep93xx: add Simplemachines Sim.One AC97 audio support

 arch/arm/mach-ep93xx/core.c                     |   34 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    1 +
 sound/soc/ep93xx/Kconfig                        |   16 +-
 sound/soc/ep93xx/Makefile                       |    4 +
 sound/soc/ep93xx/ep93xx-ac97.c                  |  468 +++++++++++++++++++++++
 sound/soc/ep93xx/simone.c                       |   89 +++++
 8 files changed, 613 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.c
 create mode 100644 sound/soc/ep93xx/simone.c
