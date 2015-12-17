From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Dec 2015 13:50:38 +0100
Subject: [GIT PULL 4/5] ARM: tegra: Devicetree changes for v4.5-rc1
In-Reply-To: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
References: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1450356639-7758-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-dt

for you to fetch changes up to 336f79c7b6d7d04f7dad0361b9f4c8995107c062:

  arm64: tegra: Add NVIDIA Jetson TX1 Developer Kit support (2015-11-24 16:52:25 +0100)

Note that this pulls in the device tree bindings for the Tegra210 clock
and reset controller. A separate pull request is sent to the clock tree
maintainers including this commit. I've included this patch in the diff
stat below.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Devicetree changes for v4.5-rc1

This adds support for the Tegra132 Norrin and various Tegra210-based
reference designs. There is also an initial device tree for the Jetson
TX1 development kit.

----------------------------------------------------------------
Thierry Reding (15):
      clk: tegra: Add Tegra210 device tree binding
      soc/tegra: Provide per-SoC Kconfig symbols
      soc/tegra: Add Tegra210 support
      Merge branch 'for-4.5/clk' into for-4.5/dt
      Merge branch 'for-4.5/soc' into for-4.5/dt
      arm64: tegra: Add Tegra132 support
      arm64: tegra: Add NVIDIA Tegra132 Norrin support
      arm64: tegra: Add Tegra210 support
      arm64: tegra: Add NVIDIA P2530 main board support
      arm64: tegra: Add NVIDIA P2595 I/O board support
      arm64: tegra: Add NVIDIA P2371 board support
      arm64: tegra: Add NVIDIA P2571 board support
      arm64: tegra: Add NVIDIA Jetson TX1 support
      arm64: tegra: Add NVIDIA P2597 I/O board support
      arm64: tegra: Add NVIDIA Jetson TX1 Developer Kit support

 .../bindings/clock/nvidia,tegra210-car.txt         |   56 +
 arch/arm/mach-tegra/Kconfig                        |   52 +-
 arch/arm64/Kconfig.platforms                       |   12 -
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/nvidia/Makefile                |    7 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts     | 1130 +++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |  990 +++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   45 +
 arch/arm64/boot/dts/nvidia/tegra210-p2371-0000.dts |    9 +
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |    9 +
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi     |   50 +
 arch/arm64/boot/dts/nvidia/tegra210-p2571.dts      | 1302 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2595.dtsi     | 1272 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 1270 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  805 ++++++++++++
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/tegra/Kconfig                          |   87 ++
 include/dt-bindings/clock/tegra210-car.h           |  401 ++++++
 18 files changed, 7436 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra210-car.txt
 create mode 100644 arch/arm64/boot/dts/nvidia/Makefile
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra132.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2371-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2571.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2595.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210.dtsi
 create mode 100644 drivers/soc/tegra/Kconfig
 create mode 100644 include/dt-bindings/clock/tegra210-car.h
