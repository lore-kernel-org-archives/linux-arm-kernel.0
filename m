From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  8 Jun 2010 22:01:09 +1200
Subject: [PATCH 0/3] EP93xx: Add i2s audio support
Message-ID: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Repost of the i2s audio series for ep93xx. Patch 2/3 is unchanged. The
core support has been modified to move setting of the SPOL and ORIDE
bits of the i2sclkdiv register, as well as the i2s pin strapping
configuration, to a new function called ep93xx_i2s_acquire which is
called from the audio board drivers.

Ryan Mallon (3):
  EP93xx: Add i2s core support
  EP93xx: Add i2s audio driver
  EP93xx: Add Snapper CL15 i2s audio support

 arch/arm/mach-ep93xx/clock.c                    |   67 +++-
 arch/arm/mach-ep93xx/core.c                     |   67 +++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    3 +
 arch/arm/mach-ep93xx/snappercl15.c              |    1 +
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/ep93xx/Kconfig                        |   18 +
 sound/soc/ep93xx/Makefile                       |   11 +
 sound/soc/ep93xx/ep93xx-i2s.c                   |  487 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-i2s.h                   |   18 +
 sound/soc/ep93xx/ep93xx-pcm.c                   |  319 +++++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h                   |   22 +
 sound/soc/ep93xx/snappercl15.c                  |  150 +++++++
 14 files changed, 1174 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
 create mode 100644 sound/soc/ep93xx/snappercl15.c
