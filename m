From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Mar 2010 08:52:37 -0700
Subject: [PATCH 0/6] davinci fixes for 2.6.34-rc
Message-ID: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of davinci fixes is targeted for the next 2.6.34-rc,
and are also available in the 'davinci-fixes' branch of:

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git

Kevin


Brian Niebuhr (1):
  davinci: edma: clear events in edma_start()

Kevin Hilman (4):
  davinci: timers: don't enable timer until clocksource is initialized
  davinci: DM365: fix duplicate default IRQ priorities
  davinci: misc cleanups from sparse
  davinci: sparse: gpio: void casting

Sekhar Nori (1):
  davinci: da8xx/omap-l1: fix build error when CONFIG_DAVINCI_MUX is
    undefined

 arch/arm/mach-davinci/board-dm644x-evm.c   |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c  |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c       |    2 +-
 arch/arm/mach-davinci/cdce949.c            |    1 +
 arch/arm/mach-davinci/clock.c              |    1 +
 arch/arm/mach-davinci/devices.c            |    2 +
 arch/arm/mach-davinci/dm355.c              |    2 +-
 arch/arm/mach-davinci/dm365.c              |    3 +-
 arch/arm/mach-davinci/dm644x.c             |    4 +-
 arch/arm/mach-davinci/dm646x.c             |    6 ++--
 arch/arm/mach-davinci/dma.c                |    3 +-
 arch/arm/mach-davinci/gpio.c               |   41 +++++++++++++++++-----------
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 +++
 arch/arm/mach-davinci/include/mach/gpio.h  |    8 +++---
 arch/arm/mach-davinci/mux.c                |    1 +
 arch/arm/mach-davinci/time.c               |    6 +++-
 16 files changed, 54 insertions(+), 34 deletions(-)
