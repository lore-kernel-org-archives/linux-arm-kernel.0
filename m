From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:26 +0100
Subject: [PATCH 0/5] cns3xxx multiplatform support
Message-ID: <1363299271-8283-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've looked at all the platforms recently to see what their
state is. cns3xxx seems quite clean but not very actively
maintained. Since it is really easy to convert to multiplatform,
that's what I did here. I'd like to apply this for linux-3.9
unless there are objections or other comments.

Arnd Bergmann (5):
  ARM: cns3xxx: make mach header files local
  ARM: cns3xxx: enable sparse IRQ support
  ARM: cns3xxx: move debug_ll code to include/debug/
  ARM: cns3xxx: enable multiplatform support
  ARM: cns3xxx: initial DT support

 arch/arm/Kconfig                                   |  11 --
 arch/arm/Kconfig.debug                             |   8 ++
 arch/arm/configs/cns3420vb_defconfig               |   3 +
 .../mach/debug-macro.S => include/debug/cns3xxx.S} |   0
 arch/arm/mach-cns3xxx/Kconfig                      |  12 ++
 arch/arm/mach-cns3xxx/Makefile                     |   8 +-
 arch/arm/mach-cns3xxx/cns3420vb.c                  |   6 +-
 arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h |   7 +-
 arch/arm/mach-cns3xxx/core.c                       | 121 ++++++++++++++++++++-
 arch/arm/mach-cns3xxx/devices.c                    |   5 +-
 arch/arm/mach-cns3xxx/include/mach/irqs.h          |  24 ----
 arch/arm/mach-cns3xxx/include/mach/timex.h         |  12 --
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |  53 ---------
 arch/arm/mach-cns3xxx/pcie.c                       |   2 +-
 arch/arm/mach-cns3xxx/pm.c                         |   4 +-
 arch/arm/mach-cns3xxx/{include/mach => }/pm.h      |   0
 drivers/mmc/host/sdhci-cns3xxx.c                   |   1 -
 17 files changed, 158 insertions(+), 119 deletions(-)
 rename arch/arm/{mach-cns3xxx/include/mach/debug-macro.S => include/debug/cns3xxx.S} (100%)
 rename arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h (99%)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/uncompress.h
 rename arch/arm/mach-cns3xxx/{include/mach => }/pm.h (100%)

-- 
1.8.1.2
