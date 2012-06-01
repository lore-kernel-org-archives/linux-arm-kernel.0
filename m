From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 1 Jun 2012 14:42:39 +0530
Subject: [PATCH 0/9] Add clk_prepare/clk_unprepare
Message-ID: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds use of clk_prepare/clk_unprepare as
required by generic clock framework.

Tested on Ventana and Cardhu.

Prashant Gaikwad (9):
  ARM: tegra: add clk_prepare/clk_unprepare
  i2c: tegra: Add clk_prepare/clk_unprepare
  mmc: tegra: add clk_prepare/clk_unprepare
  USB: ehci-tegra: add clk_prepare/clk_unprepare
  Input: tegra-kbc - add clk_prepare/clk_unprepare
  spi/tegra: add clk_prepare/clk_unprepare
  staging: nvec: add clk_prepare/clk_unprepare
  ASoC: tegra: add clk_prepare/clk_unprepare
  crypto: add clk_prepare/clk_unprepare

 arch/arm/mach-tegra/cpu-tegra.c    |    6 +++---
 arch/arm/mach-tegra/dma.c          |    2 +-
 arch/arm/mach-tegra/pcie.c         |    6 +++---
 arch/arm/mach-tegra/powergate.c    |    4 ++--
 arch/arm/mach-tegra/timer.c        |    4 ++--
 arch/arm/mach-tegra/usb_phy.c      |   16 ++++++++--------
 drivers/crypto/tegra-aes.c         |   12 ++++++------
 drivers/i2c/busses/i2c-tegra.c     |   10 +++++-----
 drivers/input/keyboard/tegra-kbc.c |    4 ++--
 drivers/mmc/host/sdhci-tegra.c     |    6 +++---
 drivers/spi/spi-tegra.c            |    4 ++--
 drivers/staging/nvec/nvec.c        |    8 ++++----
 drivers/usb/host/ehci-tegra.c      |   20 ++++++++++----------
 sound/soc/tegra/tegra20_i2s.c      |    4 ++--
 sound/soc/tegra/tegra20_spdif.c    |    4 ++--
 sound/soc/tegra/tegra30_ahub.c     |    8 ++++----
 sound/soc/tegra/tegra30_i2s.c      |    4 ++--
 sound/soc/tegra/tegra_asoc_utils.c |   12 ++++++------
 18 files changed, 67 insertions(+), 67 deletions(-)

-- 
1.7.4.1
