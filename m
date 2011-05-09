From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 May 2011 19:09:38 +0200
Subject: Thomas' IRQ patches for Samsung
Message-ID: <20110509170938.GA5851@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that when Thomas sent his IRQ patches to Russell he didn't
include any of the arch patches, and since none have been sent to
Russell he just dropped the core changes until such time as they are
merged.  In order to try to help get the changes in for Samsung I've
created the branch below - it's based off Thomas' core changes in
irq/for-arm in the tip tree so I've sent it as a pull request rather
than resending the patches as I'd normally do.  Hope this is OK with
people.

The following changes since commit cfefd21e693dca791bf9ecfc9dd3794facad533c:

  genirq: Add chip suspend and resume callbacks (2011-04-23 15:56:24 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc-2.6.git samsung-irq

Thomas Gleixner (3):
      ARM: SAMSUNG: S5P: Convert irq-gpioint to generic irq chip
      ARM: SAMSUNG: Convert irq-vic-timer to generic irq chip
      ARM: SAMSUNG: Convert irq-uart to generic irq chip

 arch/arm/mach-s3c64xx/irq.c                        |    7 +-
 arch/arm/plat-s5p/irq-gpioint.c                    |  116 +++++---------------
 arch/arm/plat-s5p/irq.c                            |    6 +-
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |    2 +-
 arch/arm/plat-samsung/irq-uart.c                   |   83 ++------------
 arch/arm/plat-samsung/irq-vic-timer.c              |   69 +++++-------
 6 files changed, 68 insertions(+), 215 deletions(-)
