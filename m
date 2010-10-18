From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 18 Oct 2010 16:16:43 -0700
Subject: [GIT PULL] MSM changes for v2.6.37
Message-ID: <1287443803.5588.128.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here is your pull request Russell. This has the patch which was part of
the conflict in MSM, "msm: allow uart to be conditionally disabled"..

It's on top of v2.6.36-rc5, and it has one patch that is already in your
tree. It's "GIC: Dont disable INT in ack callback" .

This pull request is exactly what I would send to Linus is the merge
window was open.

Daniel

---------------

The following changes since commit 846afbd1fe015e082c89d56dd42c484d896ef58e:

  GIC: Dont disable INT in ack callback (2010-10-06 08:39:53 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git msm-core

Abhijeet Dharmapurikar (2):
      msm: irqs-8x60: interrupt map
      msm: 8x60: setup correct handlers for private interrupts

Daniel Walker (2):
      msm: dma: add stub functions for dma features not yet present on 8x60
      msm: allow uart to be conditionally disabled

Gregory Bean (10):
      msm: add gpiomux api for gpio multiplex & configuration.
      msm: documentation: add gpiomux documentation.
      msm: convert 8x50 to gpiomux.
      msm: convert 7x30 to gpiomux.
      msm: gpio: Remove tlmm routines obsoleted by gpiomux.
      msm: Featurize gpiomux.
      msm: add gpio driver for single-core SoCs.
      msm: gpio: Add gpiomux calls to request and free.
      msm: qsd8x50: enable ethernet.
      msm: add MSM8x60 FFA support

Jeff Ohlstein (4):
      msm: timer: support 8x60 timers
      msm: clock: add dummy clock driver
      msm: add build support for msm8x60 target
      msm: physical offset for MSM8X60

Niranjana Vishwanathapura (2):
      msm: smd: enable smd on msm7x30 target
      msm: smd: enable smd on qsd8x50 target

Stepan Moskovchenko (3):
      msm: Add MSM IOMMU support
      msm: Platform initialization for the IOMMU driver
      msm: Platform data for msm8x60 IOMMUs

Steve Muckle (8):
      msm: create config option for proc-comm
      msm: io: MSM8X60 io support
      msm: initial irq definitions for MSM8X60
      msm: MSM8X60 RUMI3 board support
      msm: irq: rename existing entry-macro to entry-macro-vic
      msm: 8x60: gic initialization fixup for RUMI
      msm: add msm8x60_surf machine
      msm: MSM8X60 simulator board support

 Documentation/arm/00-INDEX                        |    2 +
 Documentation/arm/msm/gpiomux.txt                 |  176 ++
 arch/arm/mach-msm/Kconfig                         |   55 +
 arch/arm/mach-msm/Makefile                        |   21 +-
 arch/arm/mach-msm/board-msm7x30.c                 |   22 +-
 arch/arm/mach-msm/board-msm8x60.c                 |  100 ++
 arch/arm/mach-msm/board-qsd8x50.c                 |   46 +-
 arch/arm/mach-msm/clock-dummy.c                   |   54 +
 arch/arm/mach-msm/devices-msm7x30.c               |    5 +
 arch/arm/mach-msm/devices-msm8x60-iommu.c         |  883 ++++++++++
 arch/arm/mach-msm/devices-qsd8x50.c               |    5 +
 arch/arm/mach-msm/gpio.c                          |  409 ++++-
 arch/arm/mach-msm/gpio_hw.h                       |  278 +++
 arch/arm/mach-msm/gpiomux-7x30.c                  |   38 +
 arch/arm/mach-msm/gpiomux-8x50.c                  |   28 +
 arch/arm/mach-msm/gpiomux-8x60.c                  |   19 +
 arch/arm/mach-msm/gpiomux-v1.c                    |   33 +
 arch/arm/mach-msm/gpiomux-v1.h                    |   67 +
 arch/arm/mach-msm/gpiomux-v2.c                    |   25 +
 arch/arm/mach-msm/gpiomux-v2.h                    |   61 +
 arch/arm/mach-msm/gpiomux.c                       |   96 ++
 arch/arm/mach-msm/gpiomux.h                       |  114 ++
 arch/arm/mach-msm/include/mach/board.h            |    2 +
 arch/arm/mach-msm/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-msm/include/mach/dma.h              |   10 +-
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   88 +
 arch/arm/mach-msm/include/mach/entry-macro-vic.S  |   37 +
 arch/arm/mach-msm/include/mach/entry-macro.S      |   43 +-
 arch/arm/mach-msm/include/mach/gpio.h             |  123 --
 arch/arm/mach-msm/include/mach/io.h               |    1 +
 arch/arm/mach-msm/include/mach/iommu.h            |  103 ++
 arch/arm/mach-msm/include/mach/iommu_hw-8xxx.h    | 1871 +++++++++++++++++++++
 arch/arm/mach-msm/include/mach/irqs-8x60.h        |  253 +++
 arch/arm/mach-msm/include/mach/irqs.h             |    2 +
 arch/arm/mach-msm/include/mach/memory.h           |    2 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h   |  101 ++
 arch/arm/mach-msm/include/mach/msm_iomap.h        |    4 +
 arch/arm/mach-msm/include/mach/smp.h              |   39 +
 arch/arm/mach-msm/io.c                            |   15 +
 arch/arm/mach-msm/iommu.c                         |  597 +++++++
 arch/arm/mach-msm/iommu_dev.c                     |  374 ++++
 arch/arm/mach-msm/timer.c                         |   23 +-
 42 files changed, 5977 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/arm/msm/gpiomux.txt
 create mode 100644 arch/arm/mach-msm/board-msm8x60.c
 create mode 100644 arch/arm/mach-msm/clock-dummy.c
 create mode 100644 arch/arm/mach-msm/devices-msm8x60-iommu.c
 create mode 100644 arch/arm/mach-msm/gpio_hw.h
 create mode 100644 arch/arm/mach-msm/gpiomux-7x30.c
 create mode 100644 arch/arm/mach-msm/gpiomux-8x50.c
 create mode 100644 arch/arm/mach-msm/gpiomux-8x60.c
 create mode 100644 arch/arm/mach-msm/gpiomux-v1.c
 create mode 100644 arch/arm/mach-msm/gpiomux-v1.h
 create mode 100644 arch/arm/mach-msm/gpiomux-v2.c
 create mode 100644 arch/arm/mach-msm/gpiomux-v2.h
 create mode 100644 arch/arm/mach-msm/gpiomux.c
 create mode 100644 arch/arm/mach-msm/gpiomux.h
 create mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 create mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S
 create mode 100644 arch/arm/mach-msm/include/mach/iommu.h
 create mode 100644 arch/arm/mach-msm/include/mach/iommu_hw-8xxx.h
 create mode 100644 arch/arm/mach-msm/include/mach/irqs-8x60.h
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
 create mode 100644 arch/arm/mach-msm/include/mach/smp.h
 create mode 100644 arch/arm/mach-msm/iommu.c
 create mode 100644 arch/arm/mach-msm/iommu_dev.c

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
