From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Mar 2018 15:18:48 +0100
Subject: [GIT PULL 5/7] ARM: tegra: Device tree changes for v4.17-rc1
In-Reply-To: <20180316141850.4876-1-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
Message-ID: <20180316141850.4876-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-arm-dt

for you to fetch changes up to 4957a2f1f2205214b2ca325872a7508fa91e1096:

  ARM: tegra: apalis-tk1: Support v1.2 hardware revision (2018-03-08 16:18:38 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.17-rc1

Support for the VDE is added on Tegra30 along with some general cleanup
and some improvements to the various Toradex boards.

----------------------------------------------------------------
Dmitry Osipenko (2):
      ARM: tegra: Add IRAM node on Tegra30
      ARM: tegra: Add video decoder node on Tegra30

Marcel Ziswiler (13):
      ARM: tegra: Fix ULPI regression on Tegra20
      ARM: tegra: Use proper IRQ type definitions
      ARM: tegra: beaver: Remove invalid uses of rsvd1
      ARM: tegra: venice2: Remove duplicate pcie-1 node
      ARM: tegra: Fix I2C bus frequencies on Apalis/Colibri
      ARM: tegra: apalis/colibri: Use correct compatible for RTC
      ARM: tegra: apalis/colibri: Remove unneeded reg property
      ARM: tegra: apalis-tk1: Set critical trips
      ARM: tegra: apalis-tk1: Activate PWM pin muxing for pwm3
      ARM: tegra: apalis-tk1: Add missing as3722 gpio0 configuration
      ARM: tegra: apalis-tk1: Hog group for ethernet, PCIe, reset GPIOs
      ARM: tegra: apalis-tk1: Copyright period, spurious newlines
      ARM: tegra: apalis-tk1: Support v1.2 hardware revision

Thierry Reding (1):
      ARM: tegra: Add unit address to VDE IRAM area

 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/tegra114-dalmore.dts          |    2 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |   23 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  250 +++
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 2052 +++++++++++++++++++++++
 arch/arm/boot/dts/tegra124-apalis.dtsi          |   72 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |    2 +-
 arch/arm/boot/dts/tegra124-venice2.dts          |    9 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |   16 +-
 arch/arm/boot/dts/tegra20.dtsi                  |    4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts       |    4 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           |    7 +-
 arch/arm/boot/dts/tegra30-beaver.dts            |   32 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts   |    6 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          |    3 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   35 +
 16 files changed, 2425 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
