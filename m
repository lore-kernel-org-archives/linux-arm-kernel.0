From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:49 +0200
Subject: [PATCH 0/9] arm-soc: randconfig fixes
Message-ID: <1367528578-518090-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi platform maintainers,

These patches are all fallout from randconfig testing, and I've
applied them directly to the arm-soc tree since I don't expect
them to be controversial. They will be part of the next set
of patch submissions to Linus.

Please have a look anyway.

Arnd Bergmann (9):
  ARM: tegra: Tegra114 needs CPU_FREQ_TABLE
  ARM: OMAP: build SMP code only for OMAP4/5
  ARM: imx: build CPU suspend code only when needed
  ARM: SPEAr: conditionalize l2x0 support
  ARM: imx: reset_controller may be disabled
  ARM: SPEAr: conditionalize SMP code
  ARM: OMAP: don't select SERIAL_OMAP unconditionally
  ARM: SIRF: select SMP_ON_UP only on SMP builds
  ARM: ux500: always select ABX500_CORE

 arch/arm/mach-imx/headsmp.S     | 2 +-
 arch/arm/mach-imx/src.c         | 3 ++-
 arch/arm/mach-omap2/Kconfig     | 4 ++--
 arch/arm/mach-omap2/Makefile    | 8 ++++----
 arch/arm/mach-prima2/Kconfig    | 2 +-
 arch/arm/mach-spear/Makefile    | 6 +++---
 arch/arm/mach-spear/spear13xx.c | 2 ++
 arch/arm/mach-tegra/Kconfig     | 1 +
 arch/arm/mach-ux500/Kconfig     | 2 ++
 9 files changed, 18 insertions(+), 12 deletions(-)

-- 
1.8.1.2

Cc: Barry Song <baohua.song@csr.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
