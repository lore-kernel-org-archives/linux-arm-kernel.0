From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 22:59:42 +0200
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-1-thierry.reding@gmail.com>
References: <20180927205942.30878-1-thierry.reding@gmail.com>
Message-ID: <20180927205942.30878-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-arm64-dt

for you to fetch changes up to d9fd22447ba59a9b53a202fade977e82bfba8d8d:

  arm64: tegra: I2C on Tegra194 is not compatible with Tegra114 (2018-09-26 15:50:59 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.20-rc1

This contains mostly device tree changes to support faster SDHCI modes
on Tegra210 and Tegra186.

----------------------------------------------------------------
Aapo Vienamo (16):
      dt-bindings: Add Tegra PMC pad configuration bindings
      arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
      arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
      arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
      arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
      arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
      arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
      arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
      arm64: dts: tegra210: Add SDHCI tap and trim values
      arm64: dts: tegra186: Add SDHCI tap and trim values
      arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
      arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
      arm64: dts: tegra210: Add SDMMC4 DQS trim value
      arm64: dts: tegra186: Add SDMMC4 DQS trim value
      arm64: dts: tegra210: Enable HS400
      arm64: dts: tegra186: Enable HS400

Thierry Reding (2):
      Merge branch 'for-4.20/dt-bindings' into for-4.20/arm64/dt
      arm64: tegra: I2C on Tegra194 is not compatible with Tegra114

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 +++++++++++++++++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  76 +++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  16 ++--
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +--
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  57 ++++++++++++
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
 8 files changed, 357 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
