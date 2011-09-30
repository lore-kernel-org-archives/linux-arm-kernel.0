From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 30 Sep 2011 16:41:35 +0530
Subject: [PATCH 0/2]: Add a common macro for creating struct clk_lookup entries
Message-ID: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset consolidates the macro that creates 'struct clk_lookup'
entries by introducing a common macro 'CLKDEV_INIT' as suggested by
Russell King. Few of the platforms have been modified to use this new macro.

For Davinci, the last entry in the clk_lookup array is modified such
that the NULL entry is created without using the macro in order to
avoid a compilation issue when passing NULL as the third parameter
to CLKDEV_INIT macro.

I have done the replacement by using python script. I have only build tested
for below platforms with existing defconfigs.


Padmavathi Venna (2):
  ARM: CLKDEV: Add Common Macro for clk_lookup
  ARM: Switch to using CLKDEV_INIT macro for creating clk_lookup instance

 arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
 arch/arm/mach-davinci/clock.h            |    7 --
 arch/arm/mach-davinci/da830.c            |  101 +++++++++++----------
 arch/arm/mach-davinci/da850.c            |   95 ++++++++++----------
 arch/arm/mach-davinci/dm355.c            |   86 +++++++++---------
 arch/arm/mach-davinci/dm365.c            |  112 ++++++++++++------------
 arch/arm/mach-davinci/dm644x.c           |   77 ++++++++--------
 arch/arm/mach-davinci/dm646x.c           |   81 +++++++++--------
 arch/arm/mach-davinci/tnetv107x.c        |  134 ++++++++++++++--------------
 arch/arm/mach-ep93xx/clock.c             |   61 ++++++-------
 arch/arm/mach-imx/clock-imx1.c           |   38 ++++-----
 arch/arm/mach-imx/clock-imx21.c          |   91 +++++++++----------
 arch/arm/mach-imx/clock-imx25.c          |   77 +++++++---------
 arch/arm/mach-imx/clock-imx27.c          |  111 +++++++++++------------
 arch/arm/mach-imx/clock-imx31.c          |  103 ++++++++++-----------
 arch/arm/mach-imx/clock-imx35.c          |  117 +++++++++++-------------
 arch/arm/mach-lpc32xx/clock.c            |   75 +++++++---------
 arch/arm/mach-mx5/clock-mx51-mx53.c      |  145 ++++++++++++++----------------
 arch/arm/mach-mxs/clock-mx23.c           |   39 ++++-----
 arch/arm/mach-mxs/clock-mx28.c           |   67 ++++++--------
 arch/arm/mach-tcc8k/clock.c              |  107 ++++++++++------------
 include/linux/clkdev.h                   |    7 ++
 22 files changed, 832 insertions(+), 904 deletions(-)

-- 
1.7.4.4
