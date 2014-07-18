From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:45:36 +0200
Subject: [GIT PULL 3/7] ARM: tegra: rework PCIe regulators
In-Reply-To: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405694740-4090-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-pcie-regulators

for you to fetch changes up to 122ee17dc2adb5c4a63d3a29af9f4e6e331087e5:

  ARM: tegra: Remove legacy PCIe power supply properties (2014-07-18 11:20:10 +0200)

----------------------------------------------------------------
ARM: tegra: rework PCIe regulators

This branch reworks the set of regulators that the Tegra PCIe driver
uses, so that the driver and DT bindings more correctly model what's
really going on in HW. For backwards-compatibility the driver will
fallback to using the old set of regulators if the new ones can't be
found.

I've made this a separate branch in case it needs to be pulled into the
PCIe tree to resolve any conflicts.

----------------------------------------------------------------
Thierry Reding (5):
      PCI: tegra: Overhaul regulator usage
      ARM: tegra: Add new PCIe regulator properties
      PCI: tegra: Implement accurate power supply scheme
      PCI: tegra: Remove deprecated power supply properties
      ARM: tegra: Remove legacy PCIe power supply properties

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  30 ++-
 arch/arm/boot/dts/tegra20-harmony.dts              |   8 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   7 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   8 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |  12 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  11 +-
 drivers/pci/host/pci-tegra.c                       | 222 +++++++++++++++------
 7 files changed, 222 insertions(+), 76 deletions(-)
