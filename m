From: olof@lixom.net (Olof Johansson)
Date: Fri, 22 Jan 2016 14:23:23 -0800
Subject: [GIT PULL 2/2] ARM: SoC updates for Nvidia Tegra for v4.5 merge window
Message-ID: <20160122222323.GA14865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit e324654294907a420ab3773efe8849a935f37bf0:

  ARM: use "depends on" for SoC configs instead of "if" after prompt (2015-12-01 22:44:51 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-tegra

for you to fetch changes up to 5f4900bd8e2528ff783e329b193bfe8ce5638a98:

  Merge tag 'tegra-for-4.5-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into late/tegra (2016-01-12 10:15:01 -0800)

----------------------------------------------------------------
ARM: SoC support for Tegra platforms for v4.5

Here's a single-SoC topic branch that we've staged separately. Mainly
because it was hard to sort the branch contents in a way that fit our
existing branches due to some refactorings.

The code has been in -next for quite a while, but we staged it in arm-soc
a bit late, which is why we've kept it separate from the other updates
and are sending it separately here.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: tegra: select USB_ULPI from EHCI rather than platform

Jon Hunter (1):
      ARM: tegra: Ensure entire dcache is flushed on entering LP0/1

Olof Johansson (3):
      Merge branch 'treewide/cleanup' into late/tegra
      Merge tag 'tegra-for-4.5-soc' of git://git.kernel.org/.../tegra/linux into late/tegra
      Merge tag 'tegra-for-4.5-dt' of git://git.kernel.org/.../tegra/linux into late/tegra

Thierry Reding (15):
      soc/tegra: Provide per-SoC Kconfig symbols
      soc/tegra: Add Tegra210 support
      amba: Hide TEGRA_AHB symbol
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
 arch/arm/mach-tegra/Kconfig                        |   52 -
 arch/arm/mach-tegra/sleep-tegra20.S                |    3 +
 arch/arm/mach-tegra/sleep-tegra30.S                |    3 +
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
 drivers/amba/Kconfig                               |    2 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/tegra/Kconfig                          |   83 ++
 drivers/usb/host/Kconfig                           |    2 +
 include/dt-bindings/clock/tegra210-car.h           |  401 ++++++
 22 files changed, 7440 insertions(+), 65 deletions(-)
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
