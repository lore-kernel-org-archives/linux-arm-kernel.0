From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Dec 2017 20:19:00 +0100
Subject: [GIT PULL 5/5] arm64: tegra: Changes for v4.16-rc1
In-Reply-To: <20171220191900.757-1-thierry.reding@gmail.com>
References: <20171220191900.757-1-thierry.reding@gmail.com>
Message-ID: <20171220191900.757-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-arm64-dt

for you to fetch changes up to 50f5b841ba06f4dfb739e7a5ab9b87e8173d5915:

  arm64: tegra: Use sor1_out clock (2017-12-15 10:14:17 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Changes for v4.16-rc1

This set of patches enables a bunch of new features on Jetson TX2 that
were finally unblocked by the GPIO driver getting merged for v4.15.

----------------------------------------------------------------
Jon Hunter (1):
      arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210 platforms

Thierry Reding (12):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      dt-bindings: memory: Add Tegra186 support
      arm64: tegra: Add MISC registers on Tegra186
      arm64: tegra: Add FUSE block on Tegra186
      arm64: tegra: Add memory controller on Tegra186
      arm64: tegra: Enable memory controller on P3310
      arm64: tegra: Add SMMU node for Tegra186
      arm64: tegra: Add display nodes on Tegra186
      arm64: tegra: Mark I2C4 as DDC on P3310
      arm64: tegra: Enable HDMI on Jetson TX2
      arm64: tegra: Fix SD write-protect polarity on Jetson TX2
      arm64: tegra: Use sor1_out clock

 .../memory-controllers/nvidia,tegra30-mc.txt       |   2 +
 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  51 +++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |  10 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 351 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  23 ++
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi     |  23 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   4 +-
 include/dt-bindings/memory/tegra186-mc.h           | 111 +++++++
 9 files changed, 582 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 include/dt-bindings/memory/tegra186-mc.h
