From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:33:44 +0900
Subject: [GIT 0/4] Second round of Renesas ARM based SoC fixes for v3.11
Message-ID: <cover.1375234088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following Renesas ARM based SoC fixes for v3.11.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v3.11

for you to fetch changes up to a601469386b543df2a4d97ad7d524716945278a3:

  ARM: shmobile: lager: do not annotate gpio_buttons as __initdata (2013-07-31 10:11:17 +0900)

----------------------------------------------------------------
Second round of Renesas ARM based SoC fixes for v3.11

* Lager board: do not annotate gpio_buttons as __initdata
  - This avoids accessing uninitialised memory if keys are pressed
    after kernel initialisation completes.
  - Bug introduced in gpio-keys were enabled in v3.11-rc1

* Bock-W board: fix SDHI0 PFC settings
  - Allow detection of SD card
  - Bug introduced in SDHI support was added in v3.11-rc1

* shdma: fixup sh_dmae_get_partial() calculation error
  - Bug introduced in 2.6.34-rc1.

* armadillo800eva board: Don't request GPIO 166 in board code
  - Allow use of touchscreen
  - Bug introduced in v3.11-rc1

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: armadillo800eva: Don't request GPIO 166 in board code
      shdma: fixup sh_dmae_get_partial() calculation error

Sergei Shtylyov (1):
      ARM: shmobile: BOCK-W: fix SDHI0 PFC settings

Simon Horman (1):
      ARM: shmobile: lager: do not annotate gpio_buttons as __initdata

 arch/arm/mach-shmobile/board-armadillo800eva.c | 3 ---
 arch/arm/mach-shmobile/board-bockw.c           | 8 +++++++-
 arch/arm/mach-shmobile/board-lager.c           | 2 +-
 drivers/dma/sh/shdma.c                         | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)
