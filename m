From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 22 Oct 2017 03:41:25 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.15
Message-ID: <7hefpvqxbe.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Note that this PR is against v4.14-rc4 because of dependencies on some
Amlogic DT64 changes that missed next/late and ended up going in as
fixes and landed in -rc4.

Kevin


The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to 9d59b708500fcb62d28e15b8c6333be620984d8b:

  arm64: dts: meson-axg: add initial A113D SoC DT support (2017-10-19 03:17:07 -0700)

----------------------------------------------------------------
Amlogic 64-bit platforms: DT updates for v4.15
- new SoC support: A113D
- new boards: Tronsmart Vega S96, Khadas vim2
- reserved memory fixups
- gpio-names cleanups
- MMC cleanups, enable high-speed modes
- misc cleanups

----------------------------------------------------------------
Jerome Brunet (10):
      ARM64: dts: meson-gxl-libretech-cc: enable saradc
      ARM64: dts: meson-gxl-libretech-cc: enable internal phy leds
      ARM: dts: meson8: remove gpio offset
      ARM64: dts: meson-gx: remove gpio offset
      ARM64: dts: meson-gx: adjust gpio-ranges for TEST_N
      ARM64: dts: meson-gxbb: adjust nanopi-k2 gpio-line-names
      ARM64: dts: meson-gxbb: adjust odroid-c2 gpio-line-names
      ARM64: dts: meson-gxl: adjust kvim gpio-line-names
      ARM64: dts: meson-gxl: adjust libretech-cc gpio-line-names
      ARM64: dts: meson-gxm: enable HS400 on the vim2

Neil Armstrong (7):
      ARM64: dts: meson-gxl: Take eMMC data strobe out of eMMC pins
      ARM64: dts: meson-gxm: Add support for Khadas VIM2
      ARM64: dts: meson-gxm: Add Vega S96 board
      dt-bindings: arm: amlogic: Add Tronsmart Vega S96 binding
      ARM64: dts: meson-gxl: Add alternate ARM Trusted Firmware reserved memory zone
      ARM64: dts: meson-gx: remove unnecessary clocks properties
      ARM64: dts: meson-gx: remove unnecessary uart compatible

Peter Korsgaard (1):
      ARM64: dts: meson-gxbb-nexbox-a95x: Enable USB Nodes

Yixun Lan (2):
      dt-bindings: arm: amlogic: Add Meson AXG binding
      arm64: dts: meson-axg: add initial A113D SoC DT support

 Documentation/devicetree/bindings/arm/amlogic.txt              |   8 ++
 arch/arm/boot/dts/meson8.dtsi                                  |   2 +-
 arch/arm/boot/dts/meson8b.dtsi                                 |   2 +-
 arch/arm64/boot/dts/amlogic/Makefile                           |   3 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                 |  22 ++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                     | 204 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                      |  13 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           |  12 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  31 +++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  12 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    |  12 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  27 +++++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     |  20 ++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 400 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts             |  38 ++++++++++
 24 files changed, 784 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
