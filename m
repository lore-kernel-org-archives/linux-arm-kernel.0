From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 May 2018 15:33:01 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.18
Message-ID: <7hd0xwtuqq.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to c51fb2d458a6d62215c1ff6bbca8e5c876370e71:

  dt-bindings: arm: amlogic: add support for the Tronsmart MXIII Plus (2018-05-09 15:25:20 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.18
- AXG family: support more peripherals (wifi, eMMC, clocks)
- GX family: add/enable USB host support

----------------------------------------------------------------
Jerome Brunet (6):
      dt-bindings: clock: meson: update documentation with hhi syscon
      ARM64: dts: meson-gx: sysctrl is the parent of the clock controller
      ARM64: dts: meson-axg: use hhi syscon for the clock controller
      ARM64: dts: meson-gx: fix gxl clock controller compatible
      ARM64: dts: meson-axg: add tdm pins
      ARM64: dts: meson: add MMC resets

Martin Blumenstingl (9):
      ARM64: dts: meson-gxl: add USB host support
      ARM64: dts: meson-gxm: add GXM specific USB host configuration
      ARM64: dts: meson-gxl-s905x-p212: enable the USB controller
      ARM64: dts: meson-gx-p23x-q20x: enable the USB controller
      ARM64: dts: meson-gxl-s905x-libretech-cc: enable the USB controller
      ARM64: dts: meson-gxl-nexbox-a95x: enable the USB controller
      ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller
      dt-bindings: arm: amlogic: add support for the Meson8m2 SoC
      dt-bindings: arm: amlogic: add support for the Tronsmart MXIII Plus

Nan Li (1):
      ARM64: dts: meson-axg: enable the eMMC controller

Yixun Lan (3):
      ARM64: dts: meson-axg: add GPIO interrupt controller support
      ARM64: dts: meson-axg: add an 32K alt aoclk
      ARM64: dts: meson-axg: enable AP6255 wifi module

 Documentation/devicetree/bindings/arm/amlogic.txt             |   6 ++
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt |  16 +++-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                | 100 ++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                    | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi           |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                   |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts  |  12 +++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts   |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi         |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                    |  73 ++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts         |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                    |  17 ++++
 12 files changed, 589 insertions(+), 17 deletions(-)
