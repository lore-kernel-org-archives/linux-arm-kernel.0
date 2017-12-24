From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 24 Dec 2017 17:38:28 +0100
Subject: [GIT PULL] pxa for v4.16
Message-ID: <878tds84jf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.16, with I2C cleanups (spanning a lot of
board files as a consequence) and other small changes described below.

Can you please consider pulling, and merry Christmas.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.16

for you to fetch changes up to 9c66638412cd2162f02f9beb12f5495bfe650d03:

  ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register (2017-12-20 21:53:27 +0100)

----------------------------------------------------------------
This is the pxa changes for v4.16 cycle.

It is :
 - the conversion to the new parser sharpslpart parser
   for the Sharp variants
 - an I2C platform data cleanup for PXA
 - a gpioreg switch of one register for lubbock

----------------------------------------------------------------
Andrea Adami (4):
      ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser

Russell King (1):
      ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register

Wolfram Sang (2):
      ARM: pxa: move declarations to proper place
      ARM: pxa: move header file out of I2C realm

 arch/arm/mach-mmp/mmp2.h                           |  2 +-
 arch/arm/mach-mmp/pxa168.h                         |  2 +-
 arch/arm/mach-mmp/pxa910.h                         |  2 +-
 arch/arm/mach-pxa/Kconfig                          |  1 +
 arch/arm/mach-pxa/balloon3.c                       |  2 +-
 arch/arm/mach-pxa/cm-x300.c                        |  2 +-
 arch/arm/mach-pxa/colibri-evalboard.c              |  2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c          |  2 +-
 arch/arm/mach-pxa/corgi.c                          | 33 ++++++--------------
 arch/arm/mach-pxa/csb726.c                         |  2 +-
 arch/arm/mach-pxa/devices.c                        |  2 +-
 arch/arm/mach-pxa/devices.h                        |  9 ++++++
 arch/arm/mach-pxa/em-x270.c                        |  2 +-
 arch/arm/mach-pxa/ezx.c                            |  2 +-
 arch/arm/mach-pxa/hx4700.c                         |  2 +-
 arch/arm/mach-pxa/littleton.c                      |  3 +-
 arch/arm/mach-pxa/lubbock.c                        | 24 ++++++++++-----
 arch/arm/mach-pxa/magician.c                       |  2 +-
 arch/arm/mach-pxa/mainstone.c                      |  2 +-
 arch/arm/mach-pxa/mioa701.c                        |  2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |  2 +-
 arch/arm/mach-pxa/palm27x.c                        |  2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |  2 +-
 arch/arm/mach-pxa/poodle.c                         | 30 ++++++------------
 arch/arm/mach-pxa/pxa27x.c                         |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  2 +-
 arch/arm/mach-pxa/raumfeld.c                       |  2 +-
 arch/arm/mach-pxa/saar.c                           |  2 +-
 arch/arm/mach-pxa/spitz.c                          | 36 ++++++----------------
 arch/arm/mach-pxa/stargate2.c                      |  2 +-
 arch/arm/mach-pxa/tosa.c                           | 30 ++++++------------
 arch/arm/mach-pxa/trizeps4.c                       |  2 +-
 arch/arm/mach-pxa/viper.c                          |  2 +-
 arch/arm/mach-pxa/vpac270.c                        |  2 +-
 arch/arm/mach-pxa/xcep.c                           |  3 +-
 arch/arm/mach-pxa/z2.c                             |  2 +-
 arch/arm/mach-pxa/zeus.c                           |  3 +-
 arch/arm/mach-pxa/zylonite_pxa300.c                |  3 +-
 drivers/i2c/busses/i2c-pxa-pci.c                   |  2 +-
 drivers/i2c/busses/i2c-pxa.c                       |  2 +-
 .../{i2c/pxa-i2c.h => platform_data/i2c-pxa.h}     | 11 -------
 41 files changed, 100 insertions(+), 144 deletions(-)
 rename include/linux/{i2c/pxa-i2c.h => platform_data/i2c-pxa.h} (90%)

-- 
Robert
