From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:04 +0200
Subject: [PATCH 0/6] ARM: randconfig bugs
Message-ID: <1345648390-4234-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here are some more patches for bugs I found using
'make randconfig' in v3.6-rc+multiplatform. I can
to merge them through the arm-soc tree, but please
have a look and provide Acks.

	Arnd

---
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Eric Miao <eric.miao@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Yong Shen <yong.shen@linaro.org>


Arnd Bergmann (6):
  ARM: ux500: don't select LEDS_GPIO for snowball
  ARM: omap: allow building omap44xx without SMP
  ARM: imx: build pm-imx5 code only when PM is enabled
  ARM: imx: fix ksz9021rn_phy_fixup
  ARM: imx: select CPU_FREQ_TABLE when needed
  ARM: imx: select ARM_CPU_SUSPEND when necessary

 arch/arm/Kconfig                  |    1 +
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/Makefile        |    3 ++-
 arch/arm/mach-imx/mach-imx6q.c    |    4 ++--
 arch/arm/mach-omap2/Kconfig       |    2 +-
 arch/arm/mach-omap2/cpuidle44xx.c |    3 ++-
 arch/arm/mach-ux500/Kconfig       |    1 -
 include/linux/cpuidle.h           |    4 ++++
 8 files changed, 13 insertions(+), 6 deletions(-)

-- 
1.7.10
