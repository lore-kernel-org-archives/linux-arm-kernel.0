From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Mar 2015 11:34:51 -0500 (CDT)
Subject: [GIT PULL] qcom cleanup changes for 4.1
Message-ID: <alpine.DEB.2.02.1503271128420.15959@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

   Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-cleanup-for-4.1

for you to fetch changes up to 27842bb18b004a2802f4b3221c79ce638c4bf6ee:

   mmc: Remove msm_sdcc driver (2015-03-27 11:31:02 -0500)

----------------------------------------------------------------
General cleanups for MSM/QCOM for 4.1

* Removal of mach-msm and associated drivers cleanups that have been
   ack'd by associated maintainers

----------------------------------------------------------------
Stephen Boyd (3):
       ARM: Remove mach-msm and associated ARM architecture code
       gpio: Remove gpio-msm-v1 driver
       mmc: Remove msm_sdcc driver

  Documentation/arm/00-INDEX                      |    2 -
  Documentation/arm/msm/gpiomux.txt               |  176 ---
  MAINTAINERS                                     |   20 +-
  arch/arm/Kconfig                                |   14 -
  arch/arm/Kconfig.debug                          |   29 +-
  arch/arm/Makefile                               |    2 -
  arch/arm/configs/msm_defconfig                  |  121 --
  arch/arm/include/debug/msm.S                    |   14 -
  arch/arm/mach-msm/Kconfig                       |  109 --
  arch/arm/mach-msm/Makefile                      |   23 -
  arch/arm/mach-msm/Makefile.boot                 |    3 -
  arch/arm/mach-msm/board-halibut.c               |  110 --
  arch/arm/mach-msm/board-msm7x30.c               |  191 ---
  arch/arm/mach-msm/board-qsd8x50.c               |  254 ----
  arch/arm/mach-msm/board-sapphire.c              |  114 --
  arch/arm/mach-msm/board-trout-gpio.c            |  233 ----
  arch/arm/mach-msm/board-trout-mmc.c             |  185 ---
  arch/arm/mach-msm/board-trout-panel.c           |  292 -----
  arch/arm/mach-msm/board-trout.c                 |  111 --
  arch/arm/mach-msm/board-trout.h                 |  162 ---
  arch/arm/mach-msm/clock-pcom.c                  |  176 ---
  arch/arm/mach-msm/clock-pcom.h                  |  145 ---
  arch/arm/mach-msm/clock.c                       |   28 -
  arch/arm/mach-msm/clock.h                       |   43 -
  arch/arm/mach-msm/common.h                      |   41 -
  arch/arm/mach-msm/devices-msm7x00.c             |  480 --------
  arch/arm/mach-msm/devices-msm7x30.c             |  246 ----
  arch/arm/mach-msm/devices-qsd8x50.c             |  388 ------
  arch/arm/mach-msm/devices.h                     |   53 -
  arch/arm/mach-msm/dma.c                         |  298 -----
  arch/arm/mach-msm/gpiomux-8x50.c                |   51 -
  arch/arm/mach-msm/gpiomux-v1.h                  |   67 --
  arch/arm/mach-msm/gpiomux.c                     |  111 --
  arch/arm/mach-msm/gpiomux.h                     |   84 --
  arch/arm/mach-msm/include/mach/clk.h            |   31 -
  arch/arm/mach-msm/include/mach/dma.h            |  151 ---
  arch/arm/mach-msm/include/mach/entry-macro.S    |   36 -
  arch/arm/mach-msm/include/mach/hardware.h       |   18 -
  arch/arm/mach-msm/include/mach/irqs-7x00.h      |   75 --
  arch/arm/mach-msm/include/mach/irqs-7x30.h      |  153 ---
  arch/arm/mach-msm/include/mach/irqs-8x50.h      |   88 --
  arch/arm/mach-msm/include/mach/irqs.h           |   37 -
  arch/arm/mach-msm/include/mach/msm_gpiomux.h    |   38 -
  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |  108 --
  arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |  103 --
  arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |  125 --
  arch/arm/mach-msm/include/mach/msm_iomap.h      |   53 -
  arch/arm/mach-msm/include/mach/msm_smd.h        |  109 --
  arch/arm/mach-msm/include/mach/sirc.h           |   98 --
  arch/arm/mach-msm/include/mach/vreg.h           |   29 -
  arch/arm/mach-msm/io.c                          |  161 ---
  arch/arm/mach-msm/irq-vic.c                     |  363 ------
  arch/arm/mach-msm/irq.c                         |  151 ---
  arch/arm/mach-msm/last_radio_log.c              |   71 --
  arch/arm/mach-msm/proc_comm.c                   |  129 --
  arch/arm/mach-msm/proc_comm.h                   |  258 ----
  arch/arm/mach-msm/sirc.c                        |  172 ---
  arch/arm/mach-msm/smd.c                         | 1034 ----------------
  arch/arm/mach-msm/smd_debug.c                   |  311 -----
  arch/arm/mach-msm/smd_private.h                 |  403 -------
  arch/arm/mach-msm/vreg.c                        |  220 ----
  drivers/gpio/Kconfig                            |    8 -
  drivers/gpio/Makefile                           |    1 -
  drivers/gpio/gpio-msm-v1.c                      |  714 -----------
  drivers/mmc/host/Kconfig                        |    8 -
  drivers/mmc/host/Makefile                       |    1 -
  drivers/mmc/host/msm_sdcc.c                     | 1474 -----------------------
  drivers/mmc/host/msm_sdcc.h                     |  256 ----
  include/linux/platform_data/mmc-msm_sdcc.h      |   27 -
  69 files changed, 8 insertions(+), 11382 deletions(-)
  delete mode 100644 Documentation/arm/msm/gpiomux.txt
  delete mode 100644 arch/arm/configs/msm_defconfig
  delete mode 100644 arch/arm/mach-msm/Kconfig
  delete mode 100644 arch/arm/mach-msm/Makefile
  delete mode 100644 arch/arm/mach-msm/Makefile.boot
  delete mode 100644 arch/arm/mach-msm/board-halibut.c
  delete mode 100644 arch/arm/mach-msm/board-msm7x30.c
  delete mode 100644 arch/arm/mach-msm/board-qsd8x50.c
  delete mode 100644 arch/arm/mach-msm/board-sapphire.c
  delete mode 100644 arch/arm/mach-msm/board-trout-gpio.c
  delete mode 100644 arch/arm/mach-msm/board-trout-mmc.c
  delete mode 100644 arch/arm/mach-msm/board-trout-panel.c
  delete mode 100644 arch/arm/mach-msm/board-trout.c
  delete mode 100644 arch/arm/mach-msm/board-trout.h
  delete mode 100644 arch/arm/mach-msm/clock-pcom.c
  delete mode 100644 arch/arm/mach-msm/clock-pcom.h
  delete mode 100644 arch/arm/mach-msm/clock.c
  delete mode 100644 arch/arm/mach-msm/clock.h
  delete mode 100644 arch/arm/mach-msm/common.h
  delete mode 100644 arch/arm/mach-msm/devices-msm7x00.c
  delete mode 100644 arch/arm/mach-msm/devices-msm7x30.c
  delete mode 100644 arch/arm/mach-msm/devices-qsd8x50.c
  delete mode 100644 arch/arm/mach-msm/devices.h
  delete mode 100644 arch/arm/mach-msm/dma.c
  delete mode 100644 arch/arm/mach-msm/gpiomux-8x50.c
  delete mode 100644 arch/arm/mach-msm/gpiomux-v1.h
  delete mode 100644 arch/arm/mach-msm/gpiomux.c
  delete mode 100644 arch/arm/mach-msm/gpiomux.h
  delete mode 100644 arch/arm/mach-msm/include/mach/clk.h
  delete mode 100644 arch/arm/mach-msm/include/mach/dma.h
  delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro.S
  delete mode 100644 arch/arm/mach-msm/include/mach/hardware.h
  delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x00.h
  delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x30.h
  delete mode 100644 arch/arm/mach-msm/include/mach/irqs-8x50.h
  delete mode 100644 arch/arm/mach-msm/include/mach/irqs.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_gpiomux.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap.h
  delete mode 100644 arch/arm/mach-msm/include/mach/msm_smd.h
  delete mode 100644 arch/arm/mach-msm/include/mach/sirc.h
  delete mode 100644 arch/arm/mach-msm/include/mach/vreg.h
  delete mode 100644 arch/arm/mach-msm/io.c
  delete mode 100644 arch/arm/mach-msm/irq-vic.c
  delete mode 100644 arch/arm/mach-msm/irq.c
  delete mode 100644 arch/arm/mach-msm/last_radio_log.c
  delete mode 100644 arch/arm/mach-msm/proc_comm.c
  delete mode 100644 arch/arm/mach-msm/proc_comm.h
  delete mode 100644 arch/arm/mach-msm/sirc.c
  delete mode 100644 arch/arm/mach-msm/smd.c
  delete mode 100644 arch/arm/mach-msm/smd_debug.c
  delete mode 100644 arch/arm/mach-msm/smd_private.h
  delete mode 100644 arch/arm/mach-msm/vreg.c
  delete mode 100644 drivers/gpio/gpio-msm-v1.c
  delete mode 100644 drivers/mmc/host/msm_sdcc.c
  delete mode 100644 drivers/mmc/host/msm_sdcc.h
  delete mode 100644 include/linux/platform_data/mmc-msm_sdcc.h
--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
