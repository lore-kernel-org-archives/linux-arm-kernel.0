From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Sep 2014 11:51:31 -0600
Subject: [GIT PULL 2/3] ARM: tegra: device tree changes for 3.18
In-Reply-To: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
References: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1411062692-22338-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main highlights are:
* SATA and PCIe support added to Tegra124, and enabled on Jetson TK1.
* Touchpad enabled on Venice2 (although the driver still has a few issues
  to be worked out).
* NVIDIA reference boards rely on the bootloader to program the pinmux.
* Support added for the Acer Chromebook 13 (CB5).
* DT nodes added for the Tegra flow controller HW module. This will
  help reduce use of iomap.h in a future code cleanup.

----------------------------------------------------------------

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.18-dt

for you to fetch changes up to 8e2b9e4df655f3708fb8b712f0e66e6ea700995e:

  ARM: tegra: enable PCIe in Jetson TK1 DT

----------------------------------------------------------------

Dylan Reid (2):
      ARM: tegra: Move pwm and dpaux labels to tegra124.dtsi
      ARM: tegra: add Acer Chromebook 13 device tree

Mikko Perttunen (2):
      ARM: tegra: Add SATA controller to Tegra124 device tree
      ARM: tegra: Add SATA and SATA power to Jetson TK1 device tree

Stephen Warren (3):
      ARM: tegra: add PCIe-related pins to the Jetson TK1 pinmux tables
      ARM: tegra: add touchpad to Venice2 DT
      ARM: tegra: rely on bootloader pinmux programming on Tegra124

Thierry Reding (3):
      ARM: tegra: Add device tree nodes for flow controller
      ARM: tegra: add PCIe to Tegra124 DT
      ARM: tegra: enable PCIe in Jetson TK1 DT

 arch/arm/boot/dts/Makefile                |    1 +
 arch/arm/boot/dts/tegra114.dtsi           |    5 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts |   98 +-
 arch/arm/boot/dts/tegra124-nyan-big.dts   | 1136 ++++++++++++++++++++++++
 arch/arm/boot/dts/tegra124-venice2.dts    |   18 +-
 arch/arm/boot/dts/tegra124.dtsi           |  100 ++-
 arch/arm/boot/dts/tegra20.dtsi            |    5 +
 arch/arm/boot/dts/tegra30.dtsi            |    5 +
 8 files changed, 1357 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big.dts
