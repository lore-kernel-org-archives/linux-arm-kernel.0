From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 26 Dec 2013 00:33:58 +0530
Subject: [GIT PULL] DaVinci GPIO updates for v3.14
Message-ID: <52BB2C1E.5010300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Here are some DaVinci GPIO driver updates and the resulting platform 
code changes. All the patches have been acked by Linus. To handle
dependencies easily, we both agreed that it will be better I send the
driver updates via ARM-SoC. There is a new DT-binding which has been
acked by Rob H.

I have made the pull request over -rc4 instead of an older -rc because 
of this work depends on some fixes merged in that -rc (even for a 
successful build).

Thanks,
Sekhar

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.14/gpio

for you to fetch changes up to 6075a8b2b6c32ddcb99b85189ae41ab2903e560f:

  gpio: davinci: don't create irq_domain in case of unbanked irqs (2013-12-26 00:02:12 +0530)

----------------------------------------------------------------
DaVinci GPIO driver updates
---------------------------

This pull request contains updates
to DaVinci GPIO driver and the
resultant platform code changes. The
updates include DT-conversion and
changes to make the driver cross-platform
ready.

----------------------------------------------------------------
Grygorii Strashko (4):
      gpio: davinci: get rid of DAVINCI_N_GPIO
      gpio: introduce GPIO_DAVINCI kconfig option
      gpio: davinci: use chained_irq_enter/chained_irq_exit API
      gpio: davinci: don't create irq_domain in case of unbanked irqs

KV Sujith (1):
      gpio: davinci: add OF support

Lad, Prabhakar (3):
      gpio: davinci: use {readl|writel}_relaxed() instead of __raw_*
      gpio: davinci: convert to use irqdomain support.
      gpio: davinci: remove unused variable intc_irq_num

 .../devicetree/bindings/gpio/gpio-davinci.txt      |   41 +++++
 arch/arm/mach-davinci/da830.c                      |    1 -
 arch/arm/mach-davinci/da850.c                      |    1 -
 arch/arm/mach-davinci/dm355.c                      |    1 -
 arch/arm/mach-davinci/dm365.c                      |    1 -
 arch/arm/mach-davinci/dm644x.c                     |    1 -
 arch/arm/mach-davinci/dm646x.c                     |    1 -
 drivers/gpio/Kconfig                               |    7 +
 drivers/gpio/Makefile                              |    2 +-
 drivers/gpio/gpio-davinci.c                        |  185 ++++++++++++++------
 include/linux/platform_data/gpio-davinci.h         |    3 +-
 11 files changed, 177 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-davinci.txt
