From: olof@lixom.net (Olof Johansson)
Date: Sat, 30 Jun 2018 12:32:54 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180630193254.irrglaxamez7ryt2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 86676c4685f774d818f7a6c401c925bbf2a92903:

  arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards (2018-06-27 07:14:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 4ca2f0b945fad835959fa596df47817797987cd2:

  Merge tag 'davinci-fixes-for-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into fixes (2018-06-29 14:08:27 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A smaller batch for the end of the week (let's see if I can keep the
weekly cadence going for once).

All medium-grade fixes here, nothing worrisome:
 - Fixes for some fairly old bugs around SD card write-protect detection
   and GPIO interrupt assignments on Davinci.
 - Wifi module suspend fix for Hikey.
 - Minor DT tweaks to fix inaccuracies for Amlogic platforms, on of
   which solves booting with third-party u-boot.

----------------------------------------------------------------
Adam Ford (1):
      ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD

Jerome Brunet (2):
      ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
      ARM64: dts: meson-axg: fix ethernet stability issue

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kevin Hilman (2):
      ARM64: dts: meson: fix register ranges for SD/eMMC
      ARM64: dts: meson-gx: fix ATF reserved memory region

Martin Blumenstingl (1):
      ARM64: dts: meson-gxl: fix Mali GPU compatible string

Neil Armstrong (1):
      ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

Olof Johansson (3):
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'hisi-fixes-for-4.18' of git://github.com/hisilicon/linux-hisi into fixes
      Merge tag 'davinci-fixes-for-v4.18' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes

oscardagrach (2):
      arm64: dts: hikey: Define wl1835 power capabilities
      arm64: dts: hikey960: Define wl1837 power capabilities

 arch/arm/boot/dts/da850.dtsi                              |  6 +-----
 arch/arm/mach-davinci/board-da850-evm.c                   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts            | 15 ++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                 | 12 +++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi           |  2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts     |  3 ---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                |  8 --------
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts         |  2 ++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts            |  2 ++
 11 files changed, 39 insertions(+), 24 deletions(-)
