From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:08 +0900
Subject: [GIT PULL] Renesas ARM and SH based SoC pinmux updates for v3.10 #2
Message-ID: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 809609a5d8427b0025304dbb69a84a692d11c4f9:

  Merge branch 'soc' into pinmux-base (2013-04-02 11:08:34 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux2-for-v3.10

for you to fetch changes up to bae8c3e07e37c7a8106435fbfe62bd3d7ec2212a:

  sh-pfc: r8a73a4: Remove unused GPIO bias data (2013-04-02 11:11:16 +0900)

----------------------------------------------------------------
Second round of Renesas ARM and SH based SoC pinmux updates for v3.10

Highlights:

* Compilation fixes for sh7269 and for when CONFIG_BUG is not set
* sh-pfc Support for r8a73a4 SoC
* Move GPIOs handling from the PFC device to separate GPIO devices
  on the r8a7779 SoC

This pull request is based on a merge of:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-pinmux-for-v3.10
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-soc2-for-v3.10

----------------------------------------------------------------
Laurent Pinchart (14):
      sh-pfc: Fix compiler warning when BUG()
      sh: sh7269: Fix compilation by adding missing includes
      sh-pfc: r8a7779: Remove function GPIOs
      sh-pfc: r8a7779: Don't use GPIO enum entries
      ARM: shmobile: r8a7779: Remove all GPIOs
      gpio-rcar: Add pinctrl support
      ARM: shmobile: marzen: Add GPIO LEDs
      sh-pfc: Make function GPIOs support optional
      sh-pfc: Make GPIO support optional
      sh-pfc: Skip gpiochip registration when no GPIO resource is found
      sh-pfc: Configure pins as GPIOs at request time when handled externally
      ARM: shmobile: r8a7779: Register GPIO devices
      sh-pfc: r8a7779: Remove GPIO data
      sh-pfc: r8a7779: Split DU input and output pixel clocks

Magnus Damm (14):
      gpio: Renesas R-Car GPIO driver V3
      sh-pfc: Add r8a73a4 pinmux support
      sh-pfc: r8a73a4: Support sparse GPIO numbers
      sh-pfc: r8a73a4: GPIO IRQ support
      sh-pfc: r8a73a4: Add bias (pull-up/down) pinconf support
      sh-pfc: r8a73a4: Add SCIF pin groups and functions
      sh-pfc: r8a73a4: Add IRQC pin groups and functions
      sh-pfc: r8a73a4: Remove SCIF function GPIOS
      sh-pfc: r8a73a4: Remove IRQC function GPIOS
      ARM: shmobile: r8a73a4: Remove SCIF function GPIOs
      ARM: shmobile: r8a73a4: Remove IRQC function GPIOs
      sh-pfc: r8a73a4: Remove function GPIOs
      ARM: shmobile: r8a73a4: Remove all GPIO enums
      sh-pfc: r8a73a4: Remove unused GPIO bias data

 arch/arm/mach-shmobile/board-marzen.c         |   32 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  317 ---
 arch/arm/mach-shmobile/setup-r8a7779.c        |   58 +-
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c       |    2 +
 drivers/gpio/Kconfig                          |    6 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-rcar.c                      |  396 ++++
 drivers/pinctrl/sh-pfc/Kconfig                |    5 +
 drivers/pinctrl/sh-pfc/Makefile               |    1 +
 drivers/pinctrl/sh-pfc/core.c                 |   41 +-
 drivers/pinctrl/sh-pfc/core.h                 |    1 +
 drivers/pinctrl/sh-pfc/gpio.c                 |   45 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 2587 +++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c          |  479 +----
 drivers/pinctrl/sh-pfc/pinctrl.c              |   11 +
 include/linux/platform_data/gpio-rcar.h       |   26 +
 16 files changed, 3274 insertions(+), 734 deletions(-)
 create mode 100644 drivers/gpio/gpio-rcar.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
 create mode 100644 include/linux/platform_data/gpio-rcar.h
