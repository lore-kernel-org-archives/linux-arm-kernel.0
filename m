From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 03 Feb 2012 14:26:05 +0100
Subject: [GIT PULL] at91: base for 3.4 development (aka CAP9 removal)
Message-ID: <4F2BE06D.10909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have made a branch that will be the base for our 3.4 development. In fact, the removal of CAP9 SoC family is impacting a few files in the mach-at91 directory so we would like it to be taken into account early so that it will ease merge actions in arm-soc later...

I have added the "CAP9 removal" patch on top of a merge between Linus' 3.3-rc2 and depends/rmk/for-armsoc. The conflict resolved here is resolved in linux-next as-well.

The following diffstat is just for the "CAP9 removal" patch, not the "merge" mentioned above.

The following changes since commit 57225b76864210d667b935c54babf22b6c31336b:

  Merge remote-tracking branch 'armsoc/depends/rmk/for-armsoc' into at91-3.4-base (2012-02-03 12:32:26 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git at91-3.4-base

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: code removal of CAP9 SoC

 Documentation/feature-removal-schedule.txt        |   14 -
 arch/arm/Kconfig                                  |    2 +-
 arch/arm/Kconfig.debug                            |    2 +-
 arch/arm/configs/at91cap9_defconfig               |  108 --
 arch/arm/mach-at91/Kconfig                        |   26 +-
 arch/arm/mach-at91/Makefile                       |    4 -
 arch/arm/mach-at91/Makefile.boot                  |    6 +-
 arch/arm/mach-at91/at91cap9.c                     |  404 -------
 arch/arm/mach-at91/at91cap9_devices.c             | 1273 ---------------------
 arch/arm/mach-at91/board-cap9adk.c                |  396 -------
 arch/arm/mach-at91/clock.c                        |    5 +-
 arch/arm/mach-at91/generic.h                      |    1 -
 arch/arm/mach-at91/include/mach/at91_pmc.h        |   14 +-
 arch/arm/mach-at91/include/mach/at91cap9.h        |  122 --
 arch/arm/mach-at91/include/mach/at91cap9_matrix.h |  137 ---
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |   10 -
 arch/arm/mach-at91/include/mach/cpu.h             |   21 -
 arch/arm/mach-at91/include/mach/hardware.h        |    4 +-
 arch/arm/mach-at91/pm.c                           |    5 -
 arch/arm/mach-at91/pm.h                           |   18 -
 arch/arm/mach-at91/pm_slowclock.S                 |   12 +-
 arch/arm/mach-at91/setup.c                        |   17 -
 arch/arm/mach-at91/soc.h                          |    5 -
 arch/avr32/mach-at32ap/include/mach/cpu.h         |    3 -
 drivers/mmc/host/at91_mci.c                       |    1 -
 drivers/usb/gadget/Kconfig                        |    4 +-
 26 files changed, 17 insertions(+), 2597 deletions(-)
 delete mode 100644 arch/arm/configs/at91cap9_defconfig
 delete mode 100644 arch/arm/mach-at91/at91cap9.c
 delete mode 100644 arch/arm/mach-at91/at91cap9_devices.c
 delete mode 100644 arch/arm/mach-at91/board-cap9adk.c
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9_matrix.h

Thanks, best regards,
-- 
Nicolas Ferre
