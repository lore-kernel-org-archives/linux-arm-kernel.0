From: pkunapuli@nvidia.com (Pavan Kunapuli)
Date: Tue, 23 Oct 2012 12:48:58 +0530
Subject: [PATCH 0/2] mmc: sdhci: Defer probe if regulators are not registered
Message-ID: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator driver registration may sometimes be done after
mmc driver registration. In such cases, defer mmc probe
to obtain vmmc and vmmcq regulators.
Added vmmc and vmmcq supplies to tegra dt files.

Pavan Kunapuli (2):
  ARM: dt: tegra: Add sdhci regulators
  mmc: sdhci: Defer probe if regulator_get fails

 arch/arm/boot/dts/tegra20-harmony.dts    |   27 ++++++++++++++++++++-
 arch/arm/boot/dts/tegra20-paz00.dts      |   24 +++++++++++++++++++-
 arch/arm/boot/dts/tegra20-seaboard.dts   |   35 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/tegra20-tamonten.dtsi  |   10 ++++++++
 arch/arm/boot/dts/tegra20-ventana.dts    |   36 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/tegra20-whistler.dts   |    9 +++++-
 arch/arm/boot/dts/tegra30-cardhu-a02.dts |    2 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts |    2 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi    |   19 ++++++++++++++-
 drivers/mmc/host/sdhci.c                 |   25 ++++++++++++++++++--
 10 files changed, 176 insertions(+), 13 deletions(-)
