From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 13 May 2013 14:06:59 +0300
Subject: [PATCH 0/6] CLK: tegra: convert device tree files to use CLK defines
Message-ID: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts device tree files to use CLK defines.

This is against Stephen Warren's linux-next_common branch in:

  git://nv-tegra.nvidia.com/user/swarren/linux-2.6

If this is ok, I'll also convert enum variables to use CLK defines in
drivers/clk/tegra/clk-tegra{20,30,114}.c

Hiroshi Doyu (6):
  ARM: tegra20: create a DT header defining CLK IDs
  ARM: tegra20: convert device tree files to use CLK defines
  ARM: tegra30: create a DT header defining CLK IDs
  ARM: tegra30: convert device tree files to use CLK defines
  ARM: tegra114: create a DT header defining CLK IDs
  ARM: tegra114: convert device tree files to use CLK defines

 .../bindings/clock/nvidia,tegra114-car.txt         | 250 +--------------
 .../bindings/clock/nvidia,tegra20-car.txt          | 152 +--------
 .../bindings/clock/nvidia,tegra30-car.txt          | 209 +------------
 arch/arm/boot/dts/tegra114-dalmore.dts             |   4 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  79 ++---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |   4 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |   4 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |   7 +-
 arch/arm/boot/dts/tegra20-plutux.dts               |   4 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |   4 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |   4 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   4 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |   4 +-
 arch/arm/boot/dts/tegra20-whistler.dts             |   4 +-
 arch/arm/boot/dts/tegra20.dtsi                     | 103 ++++---
 arch/arm/boot/dts/tegra30-beaver.dts               |   4 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   4 +-
 arch/arm/boot/dts/tegra30.dtsi                     | 110 ++++---
 include/dt-bindings/clk/tegra114-car.h             | 342 +++++++++++++++++++++
 include/dt-bindings/clk/tegra20-car.h              | 158 ++++++++++
 include/dt-bindings/clk/tegra30-car.h              | 265 ++++++++++++++++
 22 files changed, 979 insertions(+), 744 deletions(-)
 create mode 100644 include/dt-bindings/clk/tegra114-car.h
 create mode 100644 include/dt-bindings/clk/tegra20-car.h
 create mode 100644 include/dt-bindings/clk/tegra30-car.h

-- 
1.8.1.5
