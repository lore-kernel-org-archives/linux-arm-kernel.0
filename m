From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri,  4 Jun 2010 17:11:22 +1200
Subject: [RFC PATCH v3 0/3] ep93xx i2s audio
Message-ID: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series adds support for i2s audio on the ep93xx,
with the Snapper CL15 used as an example implementation.

This version fixes a number of things from the previous round:
 - Removed unused #defines
 - Set symmetric rates for the cpu dai
 - Fixed the sdiv/lrdiv calculation loop
 - Moved the cpu dai registration
 - Removed empty ep93xx_pcm_prepare callback
 - Fixed enable/disable when both capture and playback are running
 
Capture still does not work. The dma is running, but the captured data
is all zeros (tested used arecord and loopback). I have a 2.6.20
kernel with ep93xx i2s audio working an capture works there on the
same hardware. I have spent sometime looking into this, but can't see
the problem. Would appreciate if someone can lend some insight as to
what I have done wrong.

Ryan Mallon (3):
  ep93xx i2s core support
  ep93xx i2s audio driver
  Snapper cl15 audio support

 arch/arm/mach-ep93xx/clock.c                    |   69 ++++-
 arch/arm/mach-ep93xx/core.c                     |   31 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/snappercl15.c              |    1 +
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/ep93xx/Kconfig                        |   18 +
 sound/soc/ep93xx/Makefile                       |   11 +
 sound/soc/ep93xx/ep93xx-i2s.c                   |  487 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-i2s.h                   |   18 +
 sound/soc/ep93xx/ep93xx-pcm.c                   |  319 +++++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h                   |   22 +
 sound/soc/ep93xx/snappercl15.c                  |  143 +++++++
 14 files changed, 1131 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
 create mode 100644 sound/soc/ep93xx/snappercl15.c
