From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 10:46:47 -0600
Subject: [GIT PULL 6/7] ARM: tegra: for-3.6/common-clk branch
In-Reply-To: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
References: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341593208-17914-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains numerous changes required as a baseline in order to
convert Tegra to the common clock framework. The intention was to also
include patches to actually convert Tegra to the common clock framework.
However, those patches appeared late in the kernel cycle and currently cause
regressions on some boards, so were dropped for now.

This branch depends only on v3.5-rc2.

This branch is NOT included in a later pull request.

----------------------------------------------------------------

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/common-clk

for you to fetch changes up to 094479915618c526a1409dd6704bcb4ff2c5c1c2:

  ARM: tegra: Provide clock for only one PWM controller

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: dma: rename driver name for clock to "tegra-apbdma"

Prashant Gaikwad (10):
      ARM: tegra: add clk_prepare/clk_unprepare
      i2c: tegra: Add clk_prepare/clk_unprepare
      mmc: tegra: add clk_prepare/clk_unprepare
      USB: ehci-tegra: add clk_prepare/clk_unprepare
      Input: tegra-kbc - add clk_prepare/clk_unprepare
      spi/tegra: add clk_prepare/clk_unprepare
      staging: nvec: add clk_prepare/clk_unprepare
      ASoC: tegra: add clk_prepare/clk_unprepare
      crypto: add clk_prepare/clk_unprepare
      ARM: tegra: Remove second instance of uart clk

Simon Que (1):
      ARM: tegra: Fix PWM clock programming

Thierry Reding (1):
      ARM: tegra: Provide clock for only one PWM controller

 arch/arm/mach-tegra/cpu-tegra.c      |    6 +-
 arch/arm/mach-tegra/dma.c            |    4 +-
 arch/arm/mach-tegra/pcie.c           |    6 +-
 arch/arm/mach-tegra/powergate.c      |    4 +-
 arch/arm/mach-tegra/tegra2_clocks.c  |   58 +++++++++++++++++++---------
 arch/arm/mach-tegra/tegra30_clocks.c |   28 ++++++--------
 arch/arm/mach-tegra/timer.c          |    4 +-
 arch/arm/mach-tegra/usb_phy.c        |   16 ++++----
 drivers/crypto/tegra-aes.c           |   12 +++---
 drivers/i2c/busses/i2c-tegra.c       |   10 ++--
 drivers/input/keyboard/tegra-kbc.c   |    4 +-
 drivers/mmc/host/sdhci-tegra.c       |    6 +-
 drivers/spi/spi-tegra.c              |    4 +-
 drivers/staging/nvec/nvec.c          |    8 ++--
 drivers/usb/host/ehci-tegra.c        |   20 +++++-----
 sound/soc/tegra/tegra20_i2s.c        |    4 +-
 sound/soc/tegra/tegra20_spdif.c      |    4 +-
 sound/soc/tegra/tegra30_ahub.c       |    8 ++--
 sound/soc/tegra/tegra30_i2s.c        |    4 +-
 sound/soc/tegra/tegra_asoc_utils.c   |   12 +++---
 20 files changed, 119 insertions(+), 103 deletions(-)
