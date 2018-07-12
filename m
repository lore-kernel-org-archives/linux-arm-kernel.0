From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jul 2018 17:41:27 +0200
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <20180712154128.22705-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-arm-dt

for you to fetch changes up to 5def854e370ff5c52172fb185932fdbffbf15692:

  ARM: dts: tegra: enable NAND flash on Colibri T20 (2018-07-09 18:51:01 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.19-rc1

This set of changes adds support for the memory client resets on Tegra20
and Tegra30, fixes a couple of issues on Cardhu and Tegra30 Apalis as
well as adds a unit-address to the memory node to avoid warnings from
DTC. To round things of, the NAND flash controller is enabled on the
Tegra20 Colibri.

----------------------------------------------------------------
Dmitry Osipenko (2):
      ARM: dts: tegra20: Add Memory Client reset to VDE
      ARM: dts: tegra30: Add Memory Client reset to VDE

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Krzysztof Kozlowski (4):
      ARM: tegra: Remove usage of deprecated skeleton.dtsi
      ARM: tegra: Fix unit_address_vs_reg DTC warnings for /memory
      ARM: tegra: Fix unit_address_vs_reg and avoid_unnecessary_addr_size DTC warnings
      ARM: tegra: Work safely with 256 MB Colibri-T20 modules

Lucas Stach (1):
      ARM: dts: tegra: add Tegra20 NAND flash controller node

Marcel Ziswiler (1):
      ARM: tegra: Fix can2 on Tegra30 Apalis

Stefan Agner (1):
      ARM: dts: tegra: enable NAND flash on Colibri T20

 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
 arch/arm/boot/dts/tegra114-roth.dts                |  2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |  2 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  9 +++++--
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        |  2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  2 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  2 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  7 +++--
 ...gra20-iris-512.dts => tegra20-colibri-iris.dts} |  4 +--
 ...gra20-colibri-512.dtsi => tegra20-colibri.dtsi} | 27 ++++++++++++++++---
 arch/arm/boot/dts/tegra20-harmony.dts              |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |  2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |  2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |  2 +-
 arch/arm/boot/dts/tegra20.dtsi                     | 31 +++++++++++++++++++---
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  9 ++++---
 arch/arm/boot/dts/tegra30-beaver.dts               |  5 +---
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  3 ++-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |  4 +--
 arch/arm/boot/dts/tegra30.dtsi                     | 13 ++++++---
 25 files changed, 100 insertions(+), 42 deletions(-)
 rename arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-colibri-iris.dts} (95%)
 rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (96%)
