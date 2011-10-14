From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Oct 2011 17:21:40 -0700
Subject: [GIT PULL] Please pull tegra feature branch for 3.2
Message-ID: <CAOesGMipZUkZG8oHSwK-8xw5Y0u6Ymfjmumq7=ijsztUwdGeDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.2/features

Olof Johansson (1):
      ARM: tegra: update defconfig

Peter De Schrijver (4):
      arm/tegra: prepare Seaboard pinmux code for derived boards
      arm/tegra: add support for ventana pinmuxing
      arm/tegra: device tree support for ventana board
      arm/tegra: select AUTO_ZRELADDR by default

Stephen Warren (6):
      arm/tegra: Prep boards for gpio/pinmux conversion to pdevs
      arm/dt: Tegra: Add pinmux node to tegra20.dtsi
      arm/tegra: Convert pinmux driver to a platform device
      gpio/tegra: Convert to a platform device
      arm/tegra: pinmux: ioremap registers
      arm/tegra: Harmony: Configure PMC for low-level interrupts

 .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |    5 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/tegra-ventana.dts                |   32 ++++
 arch/arm/boot/dts/tegra20.dtsi                     |    8 +
 arch/arm/configs/tegra_defconfig                   |   39 ++++-
 arch/arm/mach-tegra/Kconfig                        |    6 +
 arch/arm/mach-tegra/Makefile                       |    1 +
 arch/arm/mach-tegra/Makefile.boot                  |    1 +
 arch/arm/mach-tegra/board-dt.c                     |   26 +++-
 arch/arm/mach-tegra/board-harmony-pinmux.c         |    8 +
 arch/arm/mach-tegra/board-harmony-power.c          |   13 ++-
 arch/arm/mach-tegra/board-paz00-pinmux.c           |    8 +
 arch/arm/mach-tegra/board-seaboard-pinmux.c        |   69 ++++++++-
 arch/arm/mach-tegra/board-trimslice-pinmux.c       |    7 +
 arch/arm/mach-tegra/devices.c                      |   84 ++++++++++
 arch/arm/mach-tegra/devices.h                      |    2 +
 arch/arm/mach-tegra/include/mach/pinmux.h          |    4 +
 arch/arm/mach-tegra/pinmux-t2-tables.c             |   76 ++--------
 arch/arm/mach-tegra/pinmux.c                       |  163 ++++++++++++++++----
 drivers/gpio/gpio-tegra.c                          |  143 ++++++++++++------
 20 files changed, 536 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
 create mode 100644 arch/arm/boot/dts/tegra-ventana.dts
