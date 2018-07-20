From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 20 Jul 2018 10:20:30 +0200
Subject: [GIT PULL] ARM: at91: SoC for 4.19
Message-ID: <20180720082030.GA22561@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the SoC PR for 4.19. It is a cleanup of pm.c and the addition of
a new low power mode.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-soc

for you to fetch changes up to d7484f5c6b3b0565d2395aece2862f183581e1c1:

  ARM: at91: pm: configure wakeup sources for ULP1 mode (2018-07-17 15:08:12 +0200)

----------------------------------------------------------------
AT91 SoC for 4.19:

 - New low power mode for sama5d2: ULP1

----------------------------------------------------------------
Boris Brezillon (1):
      MAINTAINERS: Remove the AT91 clk driver entry

Claudiu Beznea (3):
      ARM: at91: pm: Use ULP0 naming instead of slow clock
      ARM: at91: pm: add PMC fast startup registers defines
      ARM: at91: pm: configure wakeup sources for ULP1 mode

Wenyou Yang (1):
      ARM: at91: pm: Add ULP1 mode support

 MAINTAINERS                     |   5 --
 arch/arm/mach-at91/pm.c         | 187 +++++++++++++++++++++++++++++++++-------
 arch/arm/mach-at91/pm.h         |   6 +-
 arch/arm/mach-at91/pm_suspend.S | 142 +++++++++++++++++++++++++-----
 include/linux/clk/at91_pmc.h    |  15 ++++
 5 files changed, 297 insertions(+), 58 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
