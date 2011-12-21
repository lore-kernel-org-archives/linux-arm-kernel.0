From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:14:56 -0800
Subject: [GIT PULL 2/5] Tegra devicetree updates for 3.3
Message-ID: <CAOesGMhSEbpcKXv87_cv+1b-wB7g8zmtFR2wMygByuTBv_bmvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following device tree-related updates for tegra for 3.3. Thanks!


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/dt

Marc Dietrich (1):
      arm/dt: tegra: add dts file for paz00

Olof Johansson (3):
      arm/tegra: fix variable formatting in makefile
      arm/dt: add basic usb nodes to tegra device trees
      USB: ehci-tegra: add probing through device tree

Peter De Schrijver (1):
      arm/tegra: initial device tree for tegra30

Stephen Warren (12):
      arm/dt: tegra: Clean up I2S and DAS nodes
      arm/tegra: Add device-tree support for TrimSlice board
      arm/tegra: board-dt: Fix AUXDATA typo
      arm/tegra: board-dt: Enable audio-related clocks
      arm/dt: tegra: Remove /memreserve/ from device-tree files
      arm/dt: tegra: Remove /chosen node
      arm/dt: tegra: Fix I2C nodes to match board files
      arm/dt: tegra: Fix serial nodes to match board files
      arm/dt: tegra: Fix SDHCI nodes to match board files
      arm/dt: tegra: Use new compatible value for DVC I2C controller
      arm/dt: Add ADT7461 to Seaboard
      arm/tegra: Seaboard: Add GPIO key device tree nodes

pdeschrijver at nvidia.com (1):
      arm/tegra: convert tegra20 to GIC devicetree binding

 Documentation/devicetree/bindings/arm/tegra.txt    |   14 ++
 .../devicetree/bindings/usb/tegra-usb.txt          |   13 ++
 arch/arm/boot/dts/tegra-harmony.dts                |   29 ++++-
 arch/arm/boot/dts/tegra-paz00.dts                  |   77 ++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts               |   74 +++++++++++-
 arch/arm/boot/dts/tegra-trimslice.dts              |   65 ++++++++++
 arch/arm/boot/dts/tegra-ventana.dts                |   45 ++++++-
 arch/arm/boot/dts/tegra20.dtsi                     |   71 +++++++----
 arch/arm/boot/dts/tegra30.dtsi                     |  127 ++++++++++++++++++++
 arch/arm/mach-tegra/Makefile                       |   28 +++--
 arch/arm/mach-tegra/Makefile.boot                  |    2 +
 arch/arm/mach-tegra/board-dt.c                     |   49 ++++++--
 arch/arm/mach-tegra/irq.c                          |   10 ++-
 drivers/usb/host/ehci-tegra.c                      |   71 +++++++++++
 14 files changed, 606 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/usb/tegra-usb.txt
 create mode 100644 arch/arm/boot/dts/tegra-paz00.dts
 create mode 100644 arch/arm/boot/dts/tegra-trimslice.dts
 create mode 100644 arch/arm/boot/dts/tegra30.dtsi
