From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 May 2012 10:28:33 +0800
Subject: [GIT PULL] mxs common clk porting for v3.5
Message-ID: <20120509022830.GA2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the mxs common clk porting below for v3.5.  It depends on
the following two branches.

[1] git://git.linaro.org/people/mturquette/linux.git clk-next
[2] http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git clkdev

As the mxs device tree conversion will constantly touch clock files,
to save the conflicts, the updated mxs/dt branch coming later will
based on this pull-request.  Please abandon the existing mxs/dt branch
from arm-soc tree.

Regards,
Shawn

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs

Shawn Guo (8):
      clk: mxs: add mxs specific clocks
      clk: mxs: add clock support for imx23
      clk: mxs: add clock support for imx28
      ARM: mxs: request clock for timer
      ARM: mxs: change the lookup name for fec phy clock
      ARM: mxs: switch to common clk framework
      ARM: mxs: remove old clock support
      ARM: mxs: remove now unused timer_clk argument from mxs_timer_init

 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mxs/Makefile              |    5 +-
 arch/arm/mach-mxs/clock-mx23.c          |  536 ---------------------
 arch/arm/mach-mxs/clock-mx28.c          |  803 -------------------------------
 arch/arm/mach-mxs/clock.c               |  211 --------
 arch/arm/mach-mxs/include/mach/clock.h  |   62 ---
 arch/arm/mach-mxs/include/mach/common.h |    6 +-
 arch/arm/mach-mxs/mach-mx28evk.c        |    2 +-
 arch/arm/mach-mxs/regs-clkctrl-mx23.h   |  331 -------------
 arch/arm/mach-mxs/regs-clkctrl-mx28.h   |  486 -------------------
 arch/arm/mach-mxs/system.c              |   16 -
 arch/arm/mach-mxs/timer.c               |   11 +-
 drivers/clk/Makefile                    |    2 +
 drivers/clk/mxs/Makefile                |    8 +
 drivers/clk/mxs/clk-div.c               |  110 +++++
 drivers/clk/mxs/clk-frac.c              |  139 ++++++
 drivers/clk/mxs/clk-imx23.c             |  204 ++++++++
 drivers/clk/mxs/clk-imx28.c             |  337 +++++++++++++
 drivers/clk/mxs/clk-pll.c               |  116 +++++
 drivers/clk/mxs/clk-ref.c               |  154 ++++++
 drivers/clk/mxs/clk.c                   |   28 ++
 drivers/clk/mxs/clk.h                   |   66 +++
 22 files changed, 1178 insertions(+), 2456 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/clock-mx23.c
 delete mode 100644 arch/arm/mach-mxs/clock-mx28.c
 delete mode 100644 arch/arm/mach-mxs/clock.c
 delete mode 100644 arch/arm/mach-mxs/include/mach/clock.h
 delete mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx23.h
 delete mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx28.h
 create mode 100644 drivers/clk/mxs/Makefile
 create mode 100644 drivers/clk/mxs/clk-div.c
 create mode 100644 drivers/clk/mxs/clk-frac.c
 create mode 100644 drivers/clk/mxs/clk-imx23.c
 create mode 100644 drivers/clk/mxs/clk-imx28.c
 create mode 100644 drivers/clk/mxs/clk-pll.c
 create mode 100644 drivers/clk/mxs/clk-ref.c
 create mode 100644 drivers/clk/mxs/clk.c
 create mode 100644 drivers/clk/mxs/clk.h
