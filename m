From: wni@nvidia.com (Wei Ni)
Date: Mon, 27 Aug 2012 18:25:08 +0800
Subject: [PATCH 0/6] ARM: tegra: enable wlan for t20 and t30
Message-ID: <1346063114-30361-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wlan for following tegra board:
Tegra30: Cardhu.
Tegra20: Seaboard, Ventana.

Wei Ni (6):
  ARM: tegra: set up wlan clocks for tegra dt
  brcmfmac: Handling the interrupt in ISR directly for non-OOB
  ARM: dt: t20 seaboard: turn on the power for wlan
  ARM: dt: t20 ventana: set pinmux and power for wlan
  ARM: dt: t30 cardhu: set pinmux and power for wlan
  ARM: tegra: enable wireless in defconfig

 arch/arm/boot/dts/tegra20-seaboard.dts             |    5 +++
 arch/arm/boot/dts/tegra20-ventana.dts              |   15 +++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   32 ++++++++++++++++++++
 arch/arm/configs/tegra_defconfig                   |    4 ++
 arch/arm/mach-tegra/board-dt-tegra20.c             |    4 ++
 arch/arm/mach-tegra/board-dt-tegra30.c             |    4 ++
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c   |    2 +
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |    8 ++++-
 8 files changed, 73 insertions(+), 1 deletions(-)
