From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 14 Apr 2014 18:42:39 -0700
Subject: [PATCH 0/4] Tegra SD/MMC fixes
Message-ID: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix a couple of issues which prevented Venice2
boards from booting via eMMC and SD card reliably.  Note that this
includes disabling UHS support since SDR50 and above require a
Tegra-specific tuning procedure which is not supported yet (and still
seems to have issues even in downstream kernels).

Tested on Tegra124-based Venice2 and Norrin boards.

Andrew Bresticker (4):
  mmc: tegra: disable UHS modes
  mmc: tegra: fix reporting of base clock frequency
  mmc: sdhci: defer probing on regulator_get_optional() failures
  ARM: tegra: fix Venice2 VQMMC regulators

 arch/arm/boot/dts/tegra124-venice2.dts |  3 ++-
 drivers/mmc/host/sdhci-tegra.c         | 40 +++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.c               | 19 +++++++++++++---
 3 files changed, 48 insertions(+), 14 deletions(-)

-- 
1.9.1.423.g4596e3a
