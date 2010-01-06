From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:42 -0800
Subject: [PATCH 00/35] davinci updates queued for 2.6.34
Message-ID: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a set of DaVinci updates for review.

Apologies for the large series, I've been meaning to send these in
smaller batches, but hd lots to queue up from over the holidays.

Pending any review comments, these will be submitted to Linus during
the next merge window.

Kevin

Chaithrika U S (1):
  davinci: clock: Check CLK_PSC flag before disabling PSC

Nageswari Srinivasan (2):
  davinci: add support for CDCE949 clock synthesizer
  davinci: add CDCE949 support on DM6467 EVM

Sandeep Paulraj (1):
  DaVinci: DM365: Changing default queue for DM365.

Sekhar Nori (17):
  davinci: da8xx/omapl1: add support for the second sysconfig module
  davinci: move PLL wait time values to clock.h
  davinci: move DDR2 controller defines to memory.h
  davinci: move PSC register definitions from psc.c to psc.h
  davinci: make it possible to include clock.h and psc.h in assembly
    code
  davinci: cpuidle: move mapping of DDR2 controller registers out of
    driver
  davinci: da850/omap-l138: unlock PLL registers during init
  davinci: da850/omap-l138: create static map for SRAM
  davinci: explain CLOCK_TICK_RATE of 27MHz in include/mach/timex.h
  davinci: board-dm646x-evm.c: arrange related code together
  davinci: add support for DM6467T EVM
  davinci: clock framework: remove spinlock usage
  davinci: make /proc/davinci_clocks display multi-rooted clock tree
  davinci: move /proc/davinci_clocks to debugfs
  davinci: add power management support
  davinci: da850/omap-l138: add support for SoC suspend
  davinci: da850/omap-l138 EVM: register for suspend support

Sriramakrishnan (3):
  TI Davinci EMAC : Re-use driver for other platforms.
  TI Davinci EMAC : add platform specific interrupt enable/disable
    logic.
  TI Davinci EMAC : Abstract Buffer address translation logic.

Sudhakar Rajashekhara (11):
  davinci: da850/omap-l138: Modify NOR partition info
  davinci: da850/omap-l138: Enable 4-bit ecc
  davinci: Correct return value of edma_alloc_channel api
  davinci: Keep count of channel controllers on a platform
  davinci: Fix edma_alloc_channel api for EDMA_CHANNEL_ANY case
  davinci: build list of unused EDMA events dynamically
  davinci: support for EDMA resource sharing
  davinci: da8xx/omap-l1xx: Add EDMA platform data for da850/omap-l138
  davinci: da830/omapl137: Specify reserved channels/slots
  davinci: da850/omapl138: Specify reserved channels/slots
  davinci: dm646x: Specify reserved EDMA channel/slots for DM646x

 arch/arm/mach-davinci/Kconfig                |    4 +
 arch/arm/mach-davinci/Makefile               |    3 +-
 arch/arm/mach-davinci/board-da830-evm.c      |    4 +-
 arch/arm/mach-davinci/board-da850-evm.c      |   34 +++-
 arch/arm/mach-davinci/board-dm646x-evm.c     |  143 +++++++++----
 arch/arm/mach-davinci/cdce949.c              |  289 ++++++++++++++++++++++++++
 arch/arm/mach-davinci/clock.c                |  143 +++++--------
 arch/arm/mach-davinci/clock.h                |   29 ++-
 arch/arm/mach-davinci/common.c               |    2 +-
 arch/arm/mach-davinci/cpuidle.c              |   38 +---
 arch/arm/mach-davinci/da830.c                |   10 +-
 arch/arm/mach-davinci/da850.c                |   86 +++++++--
 arch/arm/mach-davinci/devices-da8xx.c        |  210 +++++++++++++++++--
 arch/arm/mach-davinci/dm355.c                |   12 +-
 arch/arm/mach-davinci/dm365.c                |    6 +-
 arch/arm/mach-davinci/dm644x.c               |   18 +--
 arch/arm/mach-davinci/dm646x.c               |   44 +++--
 arch/arm/mach-davinci/dma.c                  |  101 ++++++++--
 arch/arm/mach-davinci/include/mach/cdce949.h |   19 ++
 arch/arm/mach-davinci/include/mach/cpuidle.h |    1 +
 arch/arm/mach-davinci/include/mach/da8xx.h   |   18 ++-
 arch/arm/mach-davinci/include/mach/dm365.h   |    2 +-
 arch/arm/mach-davinci/include/mach/dm644x.h  |    2 +-
 arch/arm/mach-davinci/include/mach/dm646x.h  |    4 +-
 arch/arm/mach-davinci/include/mach/edma.h    |    4 +-
 arch/arm/mach-davinci/include/mach/emac.h    |   36 ----
 arch/arm/mach-davinci/include/mach/memory.h  |    5 +
 arch/arm/mach-davinci/include/mach/mux.h     |    1 +
 arch/arm/mach-davinci/include/mach/pm.h      |   54 +++++
 arch/arm/mach-davinci/include/mach/psc.h     |   15 ++
 arch/arm/mach-davinci/include/mach/timex.h   |    7 +-
 arch/arm/mach-davinci/pm.c                   |  158 ++++++++++++++
 arch/arm/mach-davinci/psc.c                  |   17 +-
 arch/arm/mach-davinci/sleep.S                |  224 ++++++++++++++++++++
 drivers/net/Kconfig                          |    2 +-
 drivers/net/davinci_emac.c                   |   55 ++++--
 include/linux/davinci_emac.h                 |   39 ++++
 37 files changed, 1494 insertions(+), 345 deletions(-)
 create mode 100644 arch/arm/mach-davinci/cdce949.c
 create mode 100644 arch/arm/mach-davinci/include/mach/cdce949.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/emac.h
 create mode 100644 arch/arm/mach-davinci/include/mach/pm.h
 create mode 100644 arch/arm/mach-davinci/pm.c
 create mode 100644 arch/arm/mach-davinci/sleep.S
 create mode 100644 include/linux/davinci_emac.h
