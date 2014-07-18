From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:45:39 +0200
Subject: [GIT PULL 6/7] ARM: tegra: device tree changes for 3.17
In-Reply-To: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405694740-4090-6-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69c018268b3bbebbd0d9013a1b72831a8ae9e790:

  Merge branch 'for-3.17/xusb-padctl' into for-3.17/dt (2014-07-17 15:01:57 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-dt

for you to fetch changes up to 2236927d9820199bb6f29f2a89b1783c4513d34f:

  ARM: tegra: roth: add display DT node (2014-07-17 15:02:14 +0200)

----------------------------------------------------------------
ARM: tegra: device tree changes for 3.17

- New board support:
  - Apalis T30
- HDA support for Tegra124 and Venice2
- Display on Medcom Wide and Roth
- GK20A support on Tegra124
- XUSB pad controller for Tegra124 and Jetson TK1
- Various cleanups

This pulls in the for-3.17/fuse-move, for-3.17/dt-cros-ec-kbd and
for-3.17/xusb-padctl branches to resolve dependencies.

Note that the Apalis T30 support has a runtime dependency on the
for-3.17/pcie-regulators branch, so they should preferably be applied
in that order. I didn't merge that branch into this because Apalis T30
support is new, therefore can't regress, and because the dependency
exists only at runtime.

----------------------------------------------------------------
Alban Bedel (2):
      ARM: tegra: tamonten: add the base board regulators
      ARM: tegra: tamonten: add the display to the Medcom Wide

Alexandre Courbot (4):
      ARM: tegra: roth: fix unsupported pinmux properties
      ARM: tegra: roth: enable input on mmc clock pins
      ARM: tegra: of: add GK20A device tree binding
      ARM: tegra: roth: add display DT node

Doug Anderson (1):
      ARM: tegra: Add the EC i2c tunnel to tegra124-venice2

Dylan Reid (2):
      ARM: tegra: Add Tegra124 HDA support
      ARM: tegra: venice2 - Enable HDA

Lucas Stach (1):
      ARM: tegra: jetson-tk1: mark eMMC as non-removable

Marcel Ziswiler (2):
      ARM: tegra: initial support for apalis t30
      ARM: tegra: Migrate Apalis T30 PCIe power supply scheme

Thierry Reding (3):
      ARM: tegra: add GK20A GPU to Tegra124 DT
      ARM: tegra: tegra124: Add XUSB pad controller
      ARM: tegra: jetson-tk1: Add XUSB pad controller

Tuomas Tynkkynen (1):
      ARM: tegra: Fix typoed ams,ext-control properties

 Documentation/devicetree/bindings/arm/tegra.txt    |   2 +
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       |  43 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/tegra114-roth.dts                |  32 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  33 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  36 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  40 ++
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |  61 +-
 arch/arm/boot/dts/tegra20-plutux.dts               |  41 ++
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |  10 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |  41 ++
 arch/arm/boot/dts/tegra30-apalis-eval.dts          | 260 ++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi              | 678 +++++++++++++++++++++
 13 files changed, 1252 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis.dtsi
