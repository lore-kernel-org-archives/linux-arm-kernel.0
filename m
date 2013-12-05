From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 Dec 2013 16:14:05 +0530
Subject: [PATCH V3 0/4] ARM: tegra: convert dts files of all Tegra platforms
 to use pinctrl defines
Message-ID: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series convert dts files of all Tegra's platforms to use the pinctron
dt-binding macro for better readability.

Changes from V1:
- Get rid of lots of macro and converge it to TEGRA_PIN_ENABLE/DISABLE.
- Change macro name for PULL UP/DOWN/NONE.

Changes from V2:
- Add more comment on defines.
- Add two more patches for having simialr change for Tegra20 and Tegra30 platforms.

Laxman Dewangan (4):
  ARM: tegra: Add header file for pinctrl constants
  ARM: tegra: convert dts files of Tegra114 platforms to use pinctrl
    defines
  ARM: tegra: convert dts files of Tegra20 platforms to use pinctrl
    defines
  ARM: tegra: convert dts files of Tegra30 platforms to use pinctrl
    defines

 arch/arm/boot/dts/tegra114-dalmore.dts      |  548 +++++++++++++-------------
 arch/arm/boot/dts/tegra114.dtsi             |    1 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  |  104 +++---
 arch/arm/boot/dts/tegra20-harmony.dts       |   30 +-
 arch/arm/boot/dts/tegra20-iris-512.dts      |   10 +-
 arch/arm/boot/dts/tegra20-paz00.dts         |   30 +-
 arch/arm/boot/dts/tegra20-seaboard.dts      |   44 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi     |   30 +-
 arch/arm/boot/dts/tegra20-trimslice.dts     |   34 +-
 arch/arm/boot/dts/tegra20-ventana.dts       |   44 +-
 arch/arm/boot/dts/tegra20-whistler.dts      |   40 +-
 arch/arm/boot/dts/tegra20.dtsi              |    1 +
 arch/arm/boot/dts/tegra30-beaver.dts        |   34 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       |   40 +-
 arch/arm/boot/dts/tegra30.dtsi              |    1 +
 include/dt-bindings/pinctrl/pinctrl-tegra.h |   45 +++
 16 files changed, 542 insertions(+), 494 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h
