From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 16 Apr 2014 16:08:36 -0700
Subject: [PATCH v2 0/3] Tegra SD/MMC fixes
In-Reply-To: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Message-ID: <1397689719-28882-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix a couple of issues which prevented Venice2
boards from booting via eMMC and SD card reliably.  Note that this
includes disabling UHS support since SDR50 and above require a
Tegra-specific tuning procedure which is not supported yet (and still
seems to have issues even in downstream kernels).

This depends on the following patches which fix an issue where the
eMMC's power supply gets toggled, causing eMMC failures:
  http://patchwork.ozlabs.org/patch/339386/
  http://patchwork.ozlabs.org/patch/339710/

Tested on Tegra124-based Venice2 and Norrin boards.

Andrew Bresticker (3):
  mmc: tegra: disable UHS modes
  mmc: tegra: fix reporting of base clock frequency
  ARM: tegra: fix Venice2 SD card VQMMC supply

 arch/arm/boot/dts/tegra124-venice2.dts |  2 +-
 drivers/mmc/host/sdhci-tegra.c         | 40 +++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
1.9.1.423.g4596e3a
