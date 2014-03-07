From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 13:28:07 -0700
Subject: [GIT PULL 4/5] ARM: tegra: device tree changes for 3.15
In-Reply-To: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
References: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394224088-28910-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables:
* host1x and eDP support on Tegra124.
* LCD panel support for a few Tegra20 devices and Venice2.
* Enables power down, SPI flash, and USB on Venice2.
* Documents which Dalmore revision is supported.
* Adds an I2C bus mux to Cardhu.

Additionally, Tegra124 is converted to use #address-cells=<2> since the
HW suports more than 32-bits of address space, and various cleanups are
included.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.15-dt

for you to fetch changes up to 97070bd44bab603fc47063952250f479e9e7321e:

  ARM: dts: tegra: add PCIe interrupt mapping properties

----------------------------------------------------------------

Bryan Wu (1):
      ARM: tegra: enable PCA9546 on Cardhu

Laxman Dewangan (1):
      ARM: tegra: add system-power-controller property for PMIC node

Lucas Stach (1):
      ARM: dts: tegra: add PCIe interrupt mapping properties

Marc Dietrich (1):
      ARM: tegra: paz00: Add LVDS support to device tree

Stephen Warren (5):
      ARM: tegra: document which Dalmore revisions are supported
      ARM: tegra: enable LCD panel on Seaboard
      ARM: tegra: enable LCD panel on Ventana
      ARM: tegra: add SPI flash to Venice2 DT
      ARM: tegra: use 2 address cells for Tegra124 DT

Thierry Reding (12):
      ARM: tegra: Properly sort clocks property
      ARM: tegra: Use "disabled" for status property
      ARM: tegra: Combine VBUS enable pins into one node
      ARM: tegra: Overhaul Venice2 regulators
      ARM: tegra: Hook up SDMMC3 power-supply on Venice2
      ARM: tegra: Add Tegra124 host1x support
      ARM: tegra: Add Tegra124 eDP support
      ARM: tegra: Enable eDP for Venice2
      ARM: tegra: Add Tegra124 USB support
      ARM: tegra: Enable USB on Venice2
      ARM: tegra: Fix whitespace around '='
      ARM: tegra: Rename as3722 node to pmic

 .../bindings/pci/nvidia,tegra20-pcie.txt        |   8 +
 arch/arm/boot/dts/tegra114-dalmore.dts          |   5 +
 arch/arm/boot/dts/tegra114.dtsi                 |   8 +-
 arch/arm/boot/dts/tegra124-venice2.dts          | 301 ++++++++++------
 arch/arm/boot/dts/tegra124.dtsi                 | 339 ++++++++++++++-----
 arch/arm/boot/dts/tegra20-paz00.dts             |  46 ++-
 arch/arm/boot/dts/tegra20-seaboard.dts          |  55 ++-
 arch/arm/boot/dts/tegra20-ventana.dts           |  39 ++-
 arch/arm/boot/dts/tegra20.dtsi                  |   4 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   7 +
 arch/arm/boot/dts/tegra30.dtsi                  |   6 +-
 11 files changed, 617 insertions(+), 201 deletions(-)
