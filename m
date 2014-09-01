From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Sep 2014 19:38:44 +0200
Subject: [GIT PULL 1/4] at91: cleanup for 3.18 #1
Message-ID: <1409593127-24049-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Boris moved both of our AIC drivers to their new home: the drivers/irqchip
directory taking advantage of the genirc framework. For DT-enabled SoCs, we can
use these drivers (aic and aic5) as Jason merged them and they are
available in 3.17 kernel.

Thanks, best regards,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup

for you to fetch changes up to 2626063f86cdce500153e8550334b9331421dc6f:

  ARM: at91: remove old irq material (2014-08-19 20:32:49 +0200)

----------------------------------------------------------------
First batch of AT91 cleanup for 3.18:
Following the merge of AIC/AIC5 code as standard irqchip drivers during early
3.17 merge window, we can use these drivers for AT91 DT-enabled chips and
boards.

----------------------------------------------------------------
Boris BREZILLON (4):
      ARM: at91: introduce OLD_IRQ_AT91 Kconfig option
      ARM: at91: enclose at91_aic_xx calls in IS_ENABLED(CONFIG_OLD_IRQ_AT91) blocks
      ARM: at91: make use of the new AIC driver for dt enabled boards
      ARM: at91: remove old irq material

 arch/arm/mach-at91/Kconfig           |  17 +--
 arch/arm/mach-at91/Kconfig.non_dt    |   6 +
 arch/arm/mach-at91/Makefile          |   3 +-
 arch/arm/mach-at91/board-dt-rm9200.c |  13 --
 arch/arm/mach-at91/board-dt-sam9.c   |  13 --
 arch/arm/mach-at91/board-dt-sama5.c  |  13 --
 arch/arm/mach-at91/irq.c             | 270 +----------------------------------
 arch/arm/mach-at91/pm.c              |  32 +++--
 arch/arm/mach-at91/setup.c           |   3 +-
 9 files changed, 45 insertions(+), 325 deletions(-)

-- 
Nicolas Ferre
