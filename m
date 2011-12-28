From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Dec 2011 22:14:16 +0800
Subject: [GIT PULL] mxs: clk-prepare for 3.3
Message-ID: <20111228141415.GB10881@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ I really should do this in the morning.  Another resending to add
  the missing subject. ]

Hi Arnd, Olof,

Please consider to pull mxs/clk-prepare for 3.3.  I have not collected
the ack tag from every single subsystem maintainer, but I do not want
to hold this any longer, since it's close to merge window now.

Hi Sascha,

I send a couple of Richard's patch you have collected here for
completeness.

Regards,
Shawn

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/clk-prepare

Richard Zhao (2):
      clk: add helper functions clk_prepare_enable and clk_disable_unprepare
      net: fec: add clk_prepare/clk_unprepare

Shawn Guo (10):
      ARM: mxs: convert platform code to clk_prepare/clk_unprepare
      dma: mxs-dma: convert to clk_prepare/clk_unprepare
      mmc: mxs-mmc: convert to clk_prepare/clk_unprepare
      mtd: gpmi-lib: convert to clk_prepare/clk_unprepare
      net: flexcan: convert to clk_prepare/clk_unprepare
      serial: mxs-auart: convert to clk_prepare/clk_unprepare
      video: mxsfb: convert to clk_prepare/clk_unprepare
      ASoC: mxs-saif: convert to clk_prepare/clk_unprepare
      clk: add config option HAVE_CLK_PREPARE into Kconfig
      ARM: mxs: select HAVE_CLK_PREPARE for clock

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mxs/clock-mx23.c        |   10 +++++-----
 arch/arm/mach-mxs/clock-mx28.c        |   10 +++++-----
 arch/arm/mach-mxs/clock.c             |   33 +++++++++++++++++++++++----------
 arch/arm/mach-mxs/mach-mx28evk.c      |    2 +-
 arch/arm/mach-mxs/system.c            |    2 +-
 arch/arm/mach-mxs/timer.c             |    2 +-
 drivers/clk/Kconfig                   |    3 +++
 drivers/dma/mxs-dma.c                 |    8 ++++----
 drivers/mmc/host/mxs-mmc.c            |   10 +++++-----
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   12 ++++++------
 drivers/net/can/flexcan.c             |   10 +++++-----
 drivers/net/ethernet/freescale/fec.c  |   10 +++++-----
 drivers/tty/serial/mxs-auart.c        |    8 ++++----
 drivers/video/mxsfb.c                 |    8 ++++----
 include/linux/clk.h                   |   22 ++++++++++++++++++++++
 sound/soc/mxs/mxs-saif.c              |    4 ++--
 17 files changed, 97 insertions(+), 58 deletions(-)
