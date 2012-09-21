From: wni@nvidia.com (Wei Ni)
Date: Fri, 21 Sep 2012 16:54:55 +0800
Subject: [PATCH v2 0/5] ARM: tegra: enable wlan for t20 and t30
Message-ID: <1348217700-12309-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wlan for following tegra board:
Tegra30: Cardhu.
Tegra20: Seaboard, Ventana.

Note that this series depends on specific brcmfmac patches:
http://thread.gmane.org/gmane.linux.kernel.wireless.general/97337.

V2: -Since Broadcom restructure the dpc routine with above link,
     it can fix non-OOB issue, so we remove the patches for brcmfmac driver.
    -Support Cardhu a02 and a04 board.
    -Remove the config WLAN and WIRELESS in the patch,
     because they are default=y
    -Add bus-width for sdhci in the dts file

Wei Ni (5):
  ARM: tegra: set up wlan clocks for tegra dt
  ARM: dt: t20 seaboard: turn on the power for wlan
  ARM: dt: t20 ventana: set pinmux and power for wlan
  ARM: dt: t30 cardhu: set pinmux and power for wlan
  ARM: tegra: enable brcmfmac in defconfig

 arch/arm/boot/dts/tegra20-seaboard.dts   |    6 ++++++
 arch/arm/boot/dts/tegra20-ventana.dts    |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts |    6 ++++++
 arch/arm/boot/dts/tegra30-cardhu-a04.dts |    6 ++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi    |   27 +++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig         |    2 ++
 arch/arm/mach-tegra/board-dt-tegra20.c   |    4 ++++
 arch/arm/mach-tegra/board-dt-tegra30.c   |    4 ++++
 8 files changed, 71 insertions(+), 0 deletions(-)
