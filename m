From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 24 Aug 2012 13:26:01 +0200
Subject: [PATCH 0/4] clk: Convert ARM ux500 to common clock
Message-ID: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This converts the ux500 machine specific clocks to the common
clock framework. Old clock code are then removed from the ux500
machine directory.

This first version contains PRCMU and PRCC clock implementation.
Additional clock types shall be implemented as the next step,
although the u8500 platform is able to boot without having to
manage these.

Clock definitions are setup for u8500 and are prepared to be
setup for u9540 and as well for u8540.

This patchseries is based upon Linux 3.6 rc.2.

Compile wise a cross dependency exist to the arm-soc-tree for
the last patch (PATCH 4) affecting the ux500 machine code files.
Hopefully Arnd Bergmann can assist in getting those patches, pushed
by Linus Walleij merged prior to these onces.

Ulf Hansson (4):
  clk: ux500: Adapt PRCMU and PRCC clocks for common clk
  clk: ux500: First version of clock definitions for ux500
  clk: ux500: Clock definitions for u8500
  ARM: ux500: Switch to use common clock framework

 arch/arm/mach-ux500/Kconfig             |    1 +
 arch/arm/mach-ux500/Makefile            |    2 +-
 arch/arm/mach-ux500/clock.c             |  715 -------------------------------
 arch/arm/mach-ux500/clock.h             |  164 -------
 arch/arm/mach-ux500/cpu.c               |   14 +-
 drivers/clk/Makefile                    |    1 +
 drivers/clk/ux500/Makefile              |   12 +
 drivers/clk/ux500/clk-prcc.c            |  162 +++++++
 drivers/clk/ux500/clk-prcmu.c           |  238 ++++++++++
 drivers/clk/ux500/clk.h                 |   43 ++
 drivers/clk/ux500/u8500_clk.c           |  473 ++++++++++++++++++++
 drivers/clk/ux500/u8540_clk.c           |   21 +
 drivers/clk/ux500/u9540_clk.c           |   21 +
 include/linux/platform_data/clk-ux500.h |   17 +
 14 files changed, 998 insertions(+), 886 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/clock.c
 delete mode 100644 arch/arm/mach-ux500/clock.h
 create mode 100644 drivers/clk/ux500/Makefile
 create mode 100644 drivers/clk/ux500/clk-prcc.c
 create mode 100644 drivers/clk/ux500/clk-prcmu.c
 create mode 100644 drivers/clk/ux500/clk.h
 create mode 100644 drivers/clk/ux500/u8500_clk.c
 create mode 100644 drivers/clk/ux500/u8540_clk.c
 create mode 100644 drivers/clk/ux500/u9540_clk.c
 create mode 100644 include/linux/platform_data/clk-ux500.h

-- 
1.7.10
