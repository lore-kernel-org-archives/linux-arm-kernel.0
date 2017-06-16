From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Jun 2017 10:13:05 +0200
Subject: [GIT PULL 3/4] ARM: tegra: Device tree changes for v4.13-rc1
In-Reply-To: <20170616081306.11505-1-thierry.reding@gmail.com>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
Message-ID: <20170616081306.11505-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-arm-dt

for you to fetch changes up to 508d690e94218d306ab2092d6ee95ca75f9fa98b:

  ARM: dts: tegra: fix PCI bus dtc warnings (2017-06-13 16:49:57 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.13-rc1

This removes support for the Whistler board, which only a handful of
people ever had access to and which doesn't provide any features over
other Tegra20 devices that we support.

Also this cleans up some PCI related device tree content in preparation
for a future DTC release that has additional checks for the PCI bus.

----------------------------------------------------------------
Rob Herring (1):
      ARM: dts: tegra: fix PCI bus dtc warnings

Stephen Warren (1):
      ARM: tegra: remove Whistler support

 Documentation/devicetree/bindings/arm/tegra.txt |   1 -
 arch/arm/boot/dts/Makefile                      |   3 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |   2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi          |   2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |   2 +-
 arch/arm/boot/dts/tegra124.dtsi                 |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |   2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |   2 +-
 arch/arm/boot/dts/tegra20-tec.dts               |   2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts         |   2 +-
 arch/arm/boot/dts/tegra20-whistler.dts          | 636 ------------------------
 arch/arm/boot/dts/tegra20.dtsi                  |   4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts       |   2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           |   2 +-
 arch/arm/boot/dts/tegra30-beaver.dts            |   2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   2 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   5 +-
 17 files changed, 22 insertions(+), 653 deletions(-)
 delete mode 100644 arch/arm/boot/dts/tegra20-whistler.dts
