From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 21:32:10 -0600
Subject: [PATCH 0/4] sparse irq fixes for pxa and sa1100
Message-ID: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Russell,

Here's fixes for sa1100 and pxa. This is based on your for-next branch.
I've built all the boards for both, but there could be some more drivers
lurking if they aren't enabled in the defconfigs. I'm running an all
defconfig build now.

I've published the branch below if you want to pull the changes. I'm going
to be offline most of the next 4 days.

Also, I found a few other unrelated things breaking builds, but haven't done
a fix:
-xip mtd is broken on pxa.
-exynos cpufreq needs to depend on exynos.

Rob

The following changes since commit 41bc99e49cc9ab74a4f1a5083d79231fd6ea2704:

  Merge branch 'devel-stable' into for-next (2012-02-16 00:34:44 +0000)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git sparse-irq-fixes

Rob Herring (4):
  ARM: sa1100: fix sa1100 after sparse irq conversion
  ARM: sa1100: fix simpad compile error
  ARM: pxa: mainstone: add missing include for IRQ_BOARD_START
  rtc: sa1100: include mach/irqs.h instead of asm/irq.h

 arch/arm/mach-pxa/include/mach/mainstone.h |    2 ++
 arch/arm/mach-sa1100/assabet.c             |    2 ++
 arch/arm/mach-sa1100/badge4.c              |    1 +
 arch/arm/mach-sa1100/cerf.c                |    2 ++
 arch/arm/mach-sa1100/collie.c              |    2 ++
 arch/arm/mach-sa1100/generic.c             |    4 +++-
 arch/arm/mach-sa1100/h3100.c               |    2 ++
 arch/arm/mach-sa1100/h3600.c               |    2 ++
 arch/arm/mach-sa1100/hackkit.c             |    5 ++++-
 arch/arm/mach-sa1100/include/mach/irqs.h   |    2 +-
 arch/arm/mach-sa1100/irq.c                 |    1 +
 arch/arm/mach-sa1100/jornada720.c          |    5 ++++-
 arch/arm/mach-sa1100/lart.c                |    2 ++
 arch/arm/mach-sa1100/nanoengine.c          |    2 ++
 arch/arm/mach-sa1100/neponset.c            |    1 +
 arch/arm/mach-sa1100/pleb.c                |    1 +
 arch/arm/mach-sa1100/shannon.c             |    2 ++
 arch/arm/mach-sa1100/simpad.c              |    4 +++-
 arch/arm/mach-sa1100/ssp.c                 |    1 +
 arch/arm/mach-sa1100/time.c                |    1 +
 drivers/gpio/gpio-sa1100.c                 |    1 +
 drivers/net/ethernet/smsc/smc91x.c         |    4 ++++
 drivers/rtc/rtc-sa1100.c                   |    2 +-
 drivers/tty/serial/sa1100.c                |    1 +
 24 files changed, 46 insertions(+), 6 deletions(-)

-- 
1.7.5.4
