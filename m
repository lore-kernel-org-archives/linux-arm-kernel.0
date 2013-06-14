From: davidb@codeaurora.org (David Brown)
Date: Fri, 14 Jun 2013 10:56:53 -0700
Subject: [GIT PULL 1/3] msm cleanups for 3.11
In-Reply-To: <1371232615-30731-1-git-send-email-davidb@codeaurora.org>
References: <1371232615-30731-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1371232615-30731-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-cleanup-for-3.11

for you to fetch changes up to 1aa3d1a3c7d235c47e30c7c8c6b5ef02fb1536b3:

  mfd: ssbi: Use devm_* and simplify code (2013-06-12 14:50:12 -0700)

----------------------------------------------------------------
Cleanups for MSM for 3.11

These are a handful of cleanups to the MSM tree.  The gpio cleanups
get us closer to having proper pinmux and gpio support.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: msm: Remove init_irq declaration in machine description

Rohit Vaswani (4):
      msm: Remove unused file core.h
      msm: iomap: Remove unused bases and mappings
      ARM: msm: Remove gpiomux-v2 and re-organize MSM_GPIOMUX configs
      gpio: msm: Add device tree and irqdomain support for gpio-msm-v2

Stephen Boyd (1):
      mfd: ssbi: Use devm_* and simplify code

 .../devicetree/bindings/gpio/gpio-msm.txt          |  26 +++
 arch/arm/boot/dts/msm8660-surf.dts                 |  11 ++
 arch/arm/boot/dts/msm8960-cdp.dts                  |  11 ++
 arch/arm/mach-msm/Kconfig                          |  13 +-
 arch/arm/mach-msm/Makefile                         |   6 +-
 arch/arm/mach-msm/board-dt-8660.c                  |   2 -
 arch/arm/mach-msm/board-dt-8960.c                  |   2 -
 arch/arm/mach-msm/core.h                           |   2 -
 arch/arm/mach-msm/gpiomux-8x60.c                   |  19 --
 arch/arm/mach-msm/gpiomux-v2.c                     |  25 ---
 arch/arm/mach-msm/gpiomux-v2.h                     |  61 -------
 arch/arm/mach-msm/gpiomux.c                        |  15 ++
 arch/arm/mach-msm/gpiomux.h                        |   5 -
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h    |   7 -
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |   6 -
 arch/arm/mach-msm/include/mach/msm_iomap.h         |   2 -
 arch/arm/mach-msm/io.c                             |   4 -
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-msm-v2.c                         | 195 ++++++++++++---------
 drivers/ssbi/ssbi.c                                |  69 ++------
 20 files changed, 197 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-msm.txt
 delete mode 100644 arch/arm/mach-msm/core.h
 delete mode 100644 arch/arm/mach-msm/gpiomux-8x60.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-v2.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-v2.h
