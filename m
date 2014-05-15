From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:41 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
Message-ID: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an RFC patchset which removes mach-kirkwood, now that kirkwood
support has been converted to DT and lives in mach-mvebu.

It is an RFC because some of the final conversion patches have not yet
been accepted by maintainers, in particular:

http://www.spinics.net/lists/arm-kernel/msg328068.html

which needs to be accepted by the Sound/ASoC maintainer.

Once the real patchset is posted, without the RFC status, we would
prefer that each subsystem maintainer takes the relevent patches,
rather than try to take them all through arm-soc.

Thanks
	Andrew

Cc: Mark Brown <broonie@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Wim Van Sebroeck <wim@iguana.be>

Andrew Lunn (11):
  ARM: Kirkwood: Remove mach-kirkwood
  sound: ASoC: kirkwood: Remove unused drivers
  sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD dependency
  cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
  ata: Remove ARCH_KIRKWOOD dependency
  thermal: Remove ARCH_KIRKWOOD dependency
  leds: Remove ARCH_KIRKWOOD dependency
  PCI: Remove ARCH_KIRKWOOD dependency
  phy: Remove ARCH_KIRKWOOD dependency
  rtc: Remove ARCH_KIRKWOOD dependency
  watchdog: Remove ARCH_KIRKWOOD dependency

 arch/arm/Kconfig                                  |  18 -
 arch/arm/Kconfig.debug                            |   6 +-
 arch/arm/Makefile                                 |   1 -
 arch/arm/boot/dts/Makefile                        |   5 +-
 arch/arm/configs/kirkwood_defconfig               | 181 ------
 arch/arm/mach-kirkwood/Kconfig                    | 111 ----
 arch/arm/mach-kirkwood/Makefile                   |  14 -
 arch/arm/mach-kirkwood/Makefile.boot              |   3 -
 arch/arm/mach-kirkwood/board-dt.c                 | 223 -------
 arch/arm/mach-kirkwood/common.c                   | 746 ----------------------
 arch/arm/mach-kirkwood/common.h                   |  74 ---
 arch/arm/mach-kirkwood/d2net_v2-setup.c           | 231 -------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  86 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S |  34 -
 arch/arm/mach-kirkwood/include/mach/hardware.h    |  14 -
 arch/arm/mach-kirkwood/include/mach/irqs.h        |  65 --
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    | 142 ----
 arch/arm/mach-kirkwood/include/mach/uncompress.h  |  46 --
 arch/arm/mach-kirkwood/irq.c                      |  82 ---
 arch/arm/mach-kirkwood/lacie_v2-common.c          | 114 ----
 arch/arm/mach-kirkwood/lacie_v2-common.h          |  16 -
 arch/arm/mach-kirkwood/mpp.c                      |  43 --
 arch/arm/mach-kirkwood/mpp.h                      | 348 ----------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         | 422 ------------
 arch/arm/mach-kirkwood/openrd-setup.c             | 255 --------
 arch/arm/mach-kirkwood/pcie.c                     | 296 ---------
 arch/arm/mach-kirkwood/pm.c                       |  76 ---
 arch/arm/mach-kirkwood/pm.h                       |  26 -
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |  89 ---
 arch/arm/mach-kirkwood/rd88f6281-setup.c          | 128 ----
 arch/arm/mach-kirkwood/t5325-setup.c              | 216 -------
 arch/arm/mach-kirkwood/ts219-setup.c              | 142 ----
 arch/arm/mach-kirkwood/ts41x-setup.c              | 186 ------
 arch/arm/mach-kirkwood/tsx1x-common.c             | 113 ----
 arch/arm/mach-kirkwood/tsx1x-common.h             |   7 -
 arch/arm/mm/Kconfig                               |   2 +-
 drivers/ata/Kconfig                               |   2 +-
 drivers/cpuidle/Kconfig.arm                       |   2 +-
 drivers/leds/Kconfig                              |   4 +-
 drivers/pci/host/Kconfig                          |   2 +-
 drivers/phy/Kconfig                               |   2 +-
 drivers/rtc/Kconfig                               |   2 +-
 drivers/thermal/Kconfig                           |   2 +-
 drivers/watchdog/Kconfig                          |   2 +-
 sound/soc/kirkwood/Kconfig                        |  19 +-
 sound/soc/kirkwood/Makefile                       |   4 -
 sound/soc/kirkwood/kirkwood-openrd.c              | 109 ----
 sound/soc/kirkwood/kirkwood-t5325.c               | 129 ----
 48 files changed, 14 insertions(+), 4826 deletions(-)
 delete mode 100644 arch/arm/configs/kirkwood_defconfig
 delete mode 100644 arch/arm/mach-kirkwood/Kconfig
 delete mode 100644 arch/arm/mach-kirkwood/Makefile
 delete mode 100644 arch/arm/mach-kirkwood/Makefile.boot
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
 delete mode 100644 arch/arm/mach-kirkwood/common.c
 delete mode 100644 arch/arm/mach-kirkwood/common.h
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/kirkwood.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-kirkwood/irq.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mpp.c
 delete mode 100644 arch/arm/mach-kirkwood/mpp.h
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/openrd-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/pcie.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.h
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6281-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/t5325-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts219-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts41x-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.h
 delete mode 100644 sound/soc/kirkwood/kirkwood-openrd.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-t5325.c

-- 
2.0.0.rc2
