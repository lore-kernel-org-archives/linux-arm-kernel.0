From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Nov 2014 09:14:01 +0100
Subject: [GIT PULL] Nomadik updates for the v3.19 series
Message-ID: <CACRpkdapOcwzPGGqNVRBuo88N9_MFNRt-Vq0tafT-X-Lv=1KUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here is a number of Nomadik DT-related patches, refatcoring,
adding a new board variant and updating the defconfig.

I do not expect any more Nomadik changes for this kernel
cycle. Please pull this into some relevant branch for testing
in linux-next!

Yours,
Linus Walleij


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-for-v3.19

for you to fetch changes up to 640e2f13cadba313a0dd3f83136afec09ad407c4:

  ARM: nomadik: configure in STMPE support (2014-11-06 09:06:22 +0100)

----------------------------------------------------------------
Nomadik changes for the v3.19 development series:
- Rearrange the DTS files to make a pure SoC-specific file and
  a pure board file for S8815.
- Add the device tree for the NDK15 board.
- Update the defconfig and configure in the STMPE expander by
  default on the Nomadik.

----------------------------------------------------------------
Linus Walleij (8):
      ARM: nomadik: move MMC/SD card detect GPIO to board DTS
      ARM: nomadik: disable chrystals in top level board files
      ARM: nomadik: move GPIO I2C to S8815 board file
      ARM: nomadik: set up MCDATDIR2
      ARM: nomadik: push ethernet down to board
      ARM: nomadik: device tree for NHK15 board
      ARM: update Nomadik config
      ARM: nomadik: configure in STMPE support

 .../devicetree/bindings/arm/ste-nomadik.txt        |   6 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            | 151 +++++++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  56 ++++++--
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |  45 +-----
 arch/arm/configs/nhk8815_defconfig                 |  11 +-
 arch/arm/mach-nomadik/cpu-8815.c                   |   1 +
 7 files changed, 215 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-nomadik-nhk15.dts
