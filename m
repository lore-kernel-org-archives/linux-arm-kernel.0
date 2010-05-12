From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:29 -0700
Subject: [PATCH 00/25] *** SUBJECT HERE ***
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This modifys MSM to allow multiple SoC's instead of just
MSM7x00. It also adds very basic support for QSD8x50 and
MSM7x30.

Daniel Walker (18):
  msm: generalize clock support.
  msm: irqs: add irqs-8x50.h for QSD8x50 support
  msm: add msm_iomap-8x50.h for QSD8x50 support
  msm: update basic board layout for QSD8x50
  msm: add devices-qsd8x50.c
  msm: add extern for 8x50 clock list.
  msm: io: add io support for 8x50
  msm: physical offset for QSD8x50
  msm: 8x50 Kconfig changes
  msm: irqs: add irqs-7x30.h for MSM7x30 support
  msm: add msm_iomap-7x30.h for MSM7x30 support
  msm: add devices-msm7x30.c
  msm: update basic board layout for MSM7x30
  msm: dma: add 7x30 security domain abstraction
  msm: Add extern for 7x30 clock list.
  msm: io: add io support for 7x30
  msm: physical offset for MSM7X30
  msm: 7x30 Kconfig and makefile changes

Gregory Bean (7):
  msm: generalization to support multiple SOCs.
  msm: generialize IRQ to support multiple SOCs.
  msm: generialize iomap to support multiple SOCs.
  msm: add sirc interrupt controller driver.
  msm: add tlmm support for gpio.
  msm: add Qualcomm 7x30 interrupt controller driver.
  msm: clock support for the MSM7x30 CPU.

 arch/arm/mach-msm/Kconfig                       |   74 ++++-
 arch/arm/mach-msm/Makefile                      |   20 +-
 arch/arm/mach-msm/board-halibut.c               |    2 +-
 arch/arm/mach-msm/board-msm7x30.c               |  116 ++------
 arch/arm/mach-msm/board-qsd8x50.c               |  120 ++------
 arch/arm/mach-msm/board-trout.c                 |    2 +-
 arch/arm/mach-msm/clock-7x01a.c                 |  126 --------
 arch/arm/mach-msm/clock-7x30.h                  |  168 ++++++++++
 arch/arm/mach-msm/clock-pcom.c                  |  131 ++++++++
 arch/arm/mach-msm/clock-pcom.h                  |  153 +++++++++
 arch/arm/mach-msm/clock.c                       |  258 +++++++++++----
 arch/arm/mach-msm/clock.h                       |   71 ++++-
 arch/arm/mach-msm/devices-msm7x00.c             |  393 +++++++++++++++++++++++
 arch/arm/mach-msm/devices-msm7x30.c             |  128 ++++++++
 arch/arm/mach-msm/devices-qsd8x50.c             |   92 ++++++
 arch/arm/mach-msm/devices.c                     |  346 --------------------
 arch/arm/mach-msm/devices.h                     |   11 +
 arch/arm/mach-msm/gpio.c                        |   85 +++++
 arch/arm/mach-msm/include/mach/board.h          |    5 +-
 arch/arm/mach-msm/include/mach/clk.h            |   57 ++++
 arch/arm/mach-msm/include/mach/dma.h            |   32 +-
 arch/arm/mach-msm/include/mach/gpio.h           |  142 ++++++++
 arch/arm/mach-msm/include/mach/io.h             |    5 +
 arch/arm/mach-msm/include/mach/irqs-7x00.h      |   75 +++++
 arch/arm/mach-msm/include/mach/irqs-7x30.h      |  170 ++++++++++
 arch/arm/mach-msm/include/mach/irqs-8x50.h      |  105 ++++++
 arch/arm/mach-msm/include/mach/irqs.h           |   81 +----
 arch/arm/mach-msm/include/mach/memory.h         |    8 +
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |  139 ++++++++
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |  122 +++++++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |  147 +++++++++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   99 +------
 arch/arm/mach-msm/include/mach/sirc.h           |  115 +++++++
 arch/arm/mach-msm/io.c                          |   72 ++++-
 arch/arm/mach-msm/irq-vic.c                     |  365 +++++++++++++++++++++
 arch/arm/mach-msm/sirc.c                        |  177 ++++++++++
 36 files changed, 3266 insertions(+), 946 deletions(-)
 delete mode 100644 arch/arm/mach-msm/clock-7x01a.c
 create mode 100644 arch/arm/mach-msm/clock-7x30.h
 create mode 100644 arch/arm/mach-msm/clock-pcom.c
 create mode 100644 arch/arm/mach-msm/clock-pcom.h
 create mode 100644 arch/arm/mach-msm/devices-msm7x00.c
 create mode 100644 arch/arm/mach-msm/devices-msm7x30.c
 create mode 100644 arch/arm/mach-msm/devices-qsd8x50.c
 delete mode 100644 arch/arm/mach-msm/devices.c
 create mode 100644 arch/arm/mach-msm/gpio.c
 create mode 100644 arch/arm/mach-msm/include/mach/clk.h
 create mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 create mode 100644 arch/arm/mach-msm/include/mach/irqs-7x00.h
 create mode 100644 arch/arm/mach-msm/include/mach/irqs-7x30.h
 create mode 100644 arch/arm/mach-msm/include/mach/irqs-8x50.h
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
 create mode 100644 arch/arm/mach-msm/include/mach/sirc.h
 create mode 100644 arch/arm/mach-msm/irq-vic.c
 create mode 100644 arch/arm/mach-msm/sirc.c
