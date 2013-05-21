From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 21 May 2013 12:10:44 +0300
Subject: [v2 0/6] CLK: tegra: convert device tree files to use CLK defines
Message-ID: <1369127450-15203-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts device tree files to use CLK defines. This
version was updated along with the latest DT changes.

The following changes since commit 7479d8bb5650f43053d0e82fa44db668cf968f11:

  TESTING: Build Tegra USB as a module (2013-05-20 13:11:19 -0600)

are available in the git repository at:

  git://nv-tegra.nvidia.com/user/hdoyu/linux.git dt-replace-clkid

for you to fetch changes up to cfafa8272866ecc3e8baad7f3066921b279890fe:

  ARM: tegra114: convert device tree files to use CLK defines (2013-05-21 11:16:47 +0300)

----------------------------------------------------------------
Hiroshi Doyu (6):
      ARM: tegra20: create a DT header defining CLK IDs
      ARM: tegra20: convert device tree files to use CLK defines
      ARM: tegra30: create a DT header defining CLK IDs
      ARM: tegra30: convert device tree files to use CLK defines
      ARM: tegra114: create a DT header defining CLK IDs
      ARM: tegra114: convert device tree files to use CLK defines

 .../bindings/clock/nvidia,tegra114-car.txt         | 252 +--------------
 .../bindings/clock/nvidia,tegra20-car.txt          | 154 +---------
 .../bindings/clock/nvidia,tegra30-car.txt          | 211 +------------
 arch/arm/boot/dts/tegra114-dalmore.dts             |   4 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  79 ++---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |   4 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |   4 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |   4 +-
 arch/arm/boot/dts/tegra20-plutux.dts               |   4 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |   4 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |   4 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   4 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |   4 +-
 arch/arm/boot/dts/tegra20-whistler.dts             |   4 +-
 arch/arm/boot/dts/tegra20.dtsi                     | 116 +++----
 arch/arm/boot/dts/tegra30-beaver.dts               |   4 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   4 +-
 arch/arm/boot/dts/tegra30.dtsi                     | 110 ++++---
 include/dt-bindings/clk/tegra114-car.h             | 342 +++++++++++++++++++++
 include/dt-bindings/clk/tegra20-car.h              | 158 ++++++++++
 include/dt-bindings/clk/tegra30-car.h              | 265 ++++++++++++++++
 22 files changed, 984 insertions(+), 755 deletions(-)
 create mode 100644 include/dt-bindings/clk/tegra114-car.h
 create mode 100644 include/dt-bindings/clk/tegra20-car.h
 create mode 100644 include/dt-bindings/clk/tegra30-car.h
