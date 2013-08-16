From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 11:43:01 +0200
Subject: [GIT PULL] ux500 devicetree base for v3.12
Message-ID: <CACRpkdYtyyQhXbvikg_iQVhuocwy0bERLMXDkbGH0k+DV_jUKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this pull request is mostly described in the signed tag, it basically consists
of leftovers and cleanups from the previous kernel cycle and some real
nice houskeeping from Lee Jones.

Please pull it into a suitable branch in the ARM SoC tree for v3.12.

Yours,
Linus Walleij


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-devicetree-for-v3.12-1

for you to fetch changes up to 2ce05a14bb379bd81ba3ad12cc08b2c4bda83480:

  ARM: ux500: fix devicetree builds (2013-08-14 22:32:07 +0200)

----------------------------------------------------------------
Ux500 device tree enablement base for the v3.12
development cycle:
- Various cleanups like remove non-existant hardware from
  the Snowball device tree, prefix all files with "ste-*"
- External regulators
- Documentation updates
- Delete some minor dangling platform data
- Pin control settings for U8540 through DT

----------------------------------------------------------------
Gabriel Fernandez (2):
      ARM: u8540: Add Pinctrl Device Tree settings for uart0, uart2
      ARM: u8540: DT: Set pinctrl mapping to i2c0,1,2,4 & 5

Lee Jones (19):
      ARM: ux500: Fix trivial whitespace/tabbing issue
      ARM: ux500: Add Device Tree nodes for AB8500 External regulators
      ARM: ux500: Provide a supply name for the AB8500 AUX regulators to use
      ARM: ux500: Supply external regulator names for Snowball's DT
      Documentation: Update binding for Nomadik and DBx5x based platforms
      ARM: ux500: Stop passing MMC's platform data for Device Tree boots
      ARM: ux500: Remove Toshiba TC35892 I/O Expander's DT entry from
Snowball's DTS
      ARM: ux500: Remove Snowball DTS entry for National Semiconductor
LP5521 LED chip
      ARM: ux500: Remove Snowball DTS entry for TPS61052 chip
      ARM: ux500: Remove Snowball DTS entry for ROHM BH1780GLI ambient
light sensor
      ARM: ux500: Apply a ste-* prefix onto snowball.dts
      ARM: ux500: Apply a ste-* prefix onto ccu8540.dts
      ARM: ux500: Apply a ste-* prefix onto ccu9540.dts
      ARM: ux500: Apply a ste-* prefix onto href.dtsi
      ARM: ux500: Apply a ste-* prefix onto hrefprev60.dts
Signed-off-by: Lee Jones <lee.jones@linaro.org>
      ARM: ux500: Apply a ste-* prefix onto hrefv60plus.dts
      ARM: ux500: Apply a ste-* prefix onto stuib.dtsi
      ARM: ux500: Apply a ste-* prefix onto dbx5x0.dtsi
      ARM: ux500: Remove u9540.dts as it's been replaced

Linus Walleij (1):
      ARM: ux500: fix devicetree builds

 .../devicetree/bindings/pinctrl/ste,nomadik.txt    |   6 +-
 arch/arm/boot/dts/Makefile                         |  10 +-
 arch/arm/boot/dts/ccu8540.dts                      |  41 -----
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi         | 196 +++++++++++++++++++++
 arch/arm/boot/dts/ste-ccu8540.dts                  |  86 +++++++++
 arch/arm/boot/dts/{ccu9540.dts => ste-ccu9540.dts} |   2 +-
 arch/arm/boot/dts/{dbx5x0.dtsi => ste-dbx5x0.dtsi} |  30 +++-
 arch/arm/boot/dts/{href.dtsi => ste-href.dtsi}     |   2 +-
 .../dts/{hrefprev60.dts => ste-hrefprev60.dts}     |   6 +-
 .../dts/{hrefv60plus.dts => ste-hrefv60plus.dts}   |   6 +-
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi         |  95 ++++++++++
 .../boot/dts/{snowball.dts => ste-snowball.dts}    |  44 ++---
 arch/arm/boot/dts/{stuib.dtsi => ste-stuib.dtsi}   |   0
 arch/arm/boot/dts/u9540.dts                        |  72 --------
 arch/arm/mach-ux500/cpu-db8500.c                   |   8 +-
 include/dt-bindings/pinctrl/nomadik.h              |  36 ++++
 16 files changed, 477 insertions(+), 163 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ccu8540.dts
 create mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/ste-ccu8540.dts
 rename arch/arm/boot/dts/{ccu9540.dts => ste-ccu9540.dts} (98%)
 rename arch/arm/boot/dts/{dbx5x0.dtsi => ste-dbx5x0.dtsi} (96%)
 rename arch/arm/boot/dts/{href.dtsi => ste-href.dtsi} (99%)
 rename arch/arm/boot/dts/{hrefprev60.dts => ste-hrefprev60.dts} (92%)
 rename arch/arm/boot/dts/{hrefv60plus.dts => ste-hrefv60plus.dts} (98%)
 create mode 100644 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
 rename arch/arm/boot/dts/{snowball.dts => ste-snowball.dts} (93%)
 rename arch/arm/boot/dts/{stuib.dtsi => ste-stuib.dtsi} (100%)
 delete mode 100644 arch/arm/boot/dts/u9540.dts
 create mode 100644 include/dt-bindings/pinctrl/nomadik.h
