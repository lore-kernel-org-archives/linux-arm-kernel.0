From: robherring2@gmail.com (Rob Herring)
Date: Fri, 06 Apr 2012 12:45:44 -0500
Subject: [GIT PULL] ixp2xxx platform removal for 3.5
Message-ID: <4F7F2BC8.9040101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull the ixp23xx and ixp2000 platform removal for 3.5. I've only
included the arch/arm/* portion here. David Miller already picked up the
net driver for net-next, and I'm assuming other subsystem maintainers
will pick up i2c, mtd and watchdog patches. In any case, there aren't
any ordering dependencies with the other patches.

Rob

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git ixp2xxx-removal

Rob Herring (1):
      ARM: remove ixp23xx and ixp2000 platforms

 Documentation/arm/00-INDEX                        |    2 -
 Documentation/arm/IXP2000                         |   69 ---
 MAINTAINERS                                       |   17 -
 arch/arm/Kconfig                                  |   26 -
 arch/arm/Makefile                                 |    2 -
 arch/arm/boot/compressed/head-xscale.S            |    7 -
 arch/arm/common/Makefile                          |    2 -
 arch/arm/common/uengine.c                         |  507
--------------------
 arch/arm/configs/ixp2000_defconfig                |   99 ----
 arch/arm/configs/ixp23xx_defconfig                |  105 -----
 arch/arm/include/asm/hardware/uengine.h           |   62 ---
 arch/arm/mach-ixp2000/Kconfig                     |   72 ---
 arch/arm/mach-ixp2000/Makefile                    |   14 -
 arch/arm/mach-ixp2000/Makefile.boot               |    3 -
 arch/arm/mach-ixp2000/core.c                      |  520
---------------------
 arch/arm/mach-ixp2000/enp2611.c                   |  265 -----------
 arch/arm/mach-ixp2000/include/mach/debug-macro.S  |   25 -
 arch/arm/mach-ixp2000/include/mach/enp2611.h      |   46 --
 arch/arm/mach-ixp2000/include/mach/entry-macro.S  |   54 ---
 arch/arm/mach-ixp2000/include/mach/gpio-ixp2000.h |   48 --
 arch/arm/mach-ixp2000/include/mach/hardware.h     |   36 --
 arch/arm/mach-ixp2000/include/mach/io.h           |  133 ------
 arch/arm/mach-ixp2000/include/mach/irqs.h         |  207 --------
 arch/arm/mach-ixp2000/include/mach/ixdp2x00.h     |   92 ----
 arch/arm/mach-ixp2000/include/mach/ixdp2x01.h     |   57 ---
 arch/arm/mach-ixp2000/include/mach/ixp2000-regs.h |  451 ------------------
 arch/arm/mach-ixp2000/include/mach/memory.h       |   31 --
 arch/arm/mach-ixp2000/include/mach/platform.h     |  153 ------
 arch/arm/mach-ixp2000/include/mach/timex.h        |   13 -
 arch/arm/mach-ixp2000/include/mach/uncompress.h   |   47 --
 arch/arm/mach-ixp2000/ixdp2400.c                  |  180 -------
 arch/arm/mach-ixp2000/ixdp2800.c                  |  295 ------------
 arch/arm/mach-ixp2000/ixdp2x00.c                  |  306 ------------
 arch/arm/mach-ixp2000/ixdp2x01.c                  |  483
-------------------
 arch/arm/mach-ixp2000/pci.c                       |  252 ----------
 arch/arm/mach-ixp23xx/Kconfig                     |   25 -
 arch/arm/mach-ixp23xx/Makefile                    |   11 -
 arch/arm/mach-ixp23xx/Makefile.boot               |    2 -
 arch/arm/mach-ixp23xx/core.c                      |  455 ------------------
 arch/arm/mach-ixp23xx/espresso.c                  |   93 ----
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S  |   25 -
 arch/arm/mach-ixp23xx/include/mach/entry-macro.S  |   31 --
 arch/arm/mach-ixp23xx/include/mach/hardware.h     |   32 --
 arch/arm/mach-ixp23xx/include/mach/io.h           |   22 -
 arch/arm/mach-ixp23xx/include/mach/irqs.h         |  223 ---------
 arch/arm/mach-ixp23xx/include/mach/ixdp2351.h     |   89 ----
 arch/arm/mach-ixp23xx/include/mach/ixp23xx.h      |  298 ------------
 arch/arm/mach-ixp23xx/include/mach/memory.h       |   34 --
 arch/arm/mach-ixp23xx/include/mach/platform.h     |   58 ---
 arch/arm/mach-ixp23xx/include/mach/time.h         |    3 -
 arch/arm/mach-ixp23xx/include/mach/timex.h        |    7 -
 arch/arm/mach-ixp23xx/include/mach/uncompress.h   |   40 --
 arch/arm/mach-ixp23xx/ixdp2351.c                  |  347 --------------
 arch/arm/mach-ixp23xx/pci.c                       |  294 ------------
 arch/arm/mach-ixp23xx/roadrunner.c                |  180 -------
 55 files changed, 0 insertions(+), 6950 deletions(-)
 delete mode 100644 Documentation/arm/IXP2000
 delete mode 100644 arch/arm/common/uengine.c
 delete mode 100644 arch/arm/configs/ixp2000_defconfig
 delete mode 100644 arch/arm/configs/ixp23xx_defconfig
 delete mode 100644 arch/arm/include/asm/hardware/uengine.h
 delete mode 100644 arch/arm/mach-ixp2000/Kconfig
 delete mode 100644 arch/arm/mach-ixp2000/Makefile
 delete mode 100644 arch/arm/mach-ixp2000/Makefile.boot
 delete mode 100644 arch/arm/mach-ixp2000/core.c
 delete mode 100644 arch/arm/mach-ixp2000/enp2611.c
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/enp2611.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/gpio-ixp2000.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/io.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/ixdp2x00.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/ixdp2x01.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/ixp2000-regs.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/memory.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/platform.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ixp2000/ixdp2400.c
 delete mode 100644 arch/arm/mach-ixp2000/ixdp2800.c
 delete mode 100644 arch/arm/mach-ixp2000/ixdp2x00.c
 delete mode 100644 arch/arm/mach-ixp2000/ixdp2x01.c
 delete mode 100644 arch/arm/mach-ixp2000/pci.c
 delete mode 100644 arch/arm/mach-ixp23xx/Kconfig
 delete mode 100644 arch/arm/mach-ixp23xx/Makefile
 delete mode 100644 arch/arm/mach-ixp23xx/Makefile.boot
 delete mode 100644 arch/arm/mach-ixp23xx/core.c
 delete mode 100644 arch/arm/mach-ixp23xx/espresso.c
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/ixdp2351.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/ixp23xx.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/memory.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/platform.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/time.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ixp23xx/ixdp2351.c
 delete mode 100644 arch/arm/mach-ixp23xx/pci.c
 delete mode 100644 arch/arm/mach-ixp23xx/roadrunner.c
