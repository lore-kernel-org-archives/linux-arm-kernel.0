From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 04 Apr 2017 17:31:59 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12 (redo)
Message-ID: <m24ly37kzk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here's a redo of the Amlogic 64-bit DT updates for v4.12.

This DT branch includes all our DT updates, plus merges in a clock
branch that includes only clock header and binding updates which are
dependencies.  This shared branch/tag is immutable and shared with the
clock tree.

I hope this iteration passes muster,

Kevin


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-redo

for you to fetch changes up to b2121170143bf4708c657461740c922ce24bc94e:

  Merge tag 'amlogic-clk-headers' into v4.12/dt64 (2017-04-04 16:16:52 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.12
- pinctrl: new pins for audio
- clocks: more clocks exposed for GFX, audio
- new board: Khadas Vim (S905X)
- new board: HwaCom AmazeTV (S905X)
- ethernet phy: add GPIO resets

----------------------------------------------------------------
Carlo Caione (3):
      dt-bindings: Add vendor prefix for Hwacom Systems Inc.
      dt-bindings: amlogic: Add HwaCom board
      ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV

Heiner Kallweit (1):
      ARM64: dts: meson-gxbb-odroidc2: Enable SARADC node

Jerome Brunet (1):
      dt-bindings: clk: gxbb: expose i2s output clock gates

Kevin Hilman (1):
      Merge tag 'amlogic-clk-headers' into v4.12/dt64

Martin Blumenstingl (14):
      ARM64: dts: meson-gxbb-odroidc2: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-p200: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-vega-s95: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-nexbox-a95x: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-wetek-hub: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-wetek-play2: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-p201: fix ethernet support
      ARM64: dts: amlogic: add the ethernet TX delay configuration
      ARM64: dts: meson-gx: remove the phy-mode property from meson-gx
      ARM64: dts: meson-gxl: improve support for the P212 reference design
      ARM64: dts: amlogic: meson-gxl: add the missing PWM pins
      devicetree: add vendor prefix for Khadas
      dt-bindings: amlogic: add the Khadas VIM
      ARM64: dts: meson-gxl: add support for the Khadas VIM board

Neil Armstrong (18):
      ARM64: dts: meson-gx: Add Buttons to Q200 and P230 boards
      ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
      ARM64: dts: meson-gxbb-odroidc2: Fix TFLASH VDD regulator GPIO line
      ARM64: dts: meson-gx: Finally move common nodes to GX dtsi
      ARM64: dts: meson-gx: empty line cleanup
      ARM64: dts: meson-gx: Prepend GX generic compatible like other nodes
      ARM64: dts: meson-gxl: Add missing pinctrl pins groups
      ARM64: dts: meson-gx: Add Mali nodes for GXBB and GXL
      ARM64: dts: meson-gxbb: Add gpio-ranges properties
      ARM64: dts: meson-gxl: Add gpio-ranges properties
      ARM: dts: meson8: Add gpio-ranges properties
      ARM: dts: meson8b: Add gpio-ranges properties
      ARM64: dts: meson-gxbb: Add USB Hub GPIO hog
      clk: meson-gxbb: Add MALI clock IDS
      clk: meson-gxbb: Expose GP0 dt-bindings clock id
      dt-bindings: clock: gxbb-clkc: Add GXL compatible variant
      ARM64: dts: meson-gx: Add shared CMA dma memory pool
      ARM64: dts: meson-gx: Add support for HDMI output

jbrunet (4):
      ARM64: dts: meson-gxbb: add i2s output pins
      ARM64: dts: meson-gxbb: add spdif output pins
      ARM64: dts: meson-gxl: add i2s output pins
      ARM64: dts: meson-gxl: add spdif output pins

 Documentation/devicetree/bindings/arm/amlogic.txt              |   3 +
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt  |   3 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt          |   2 +
 arch/arm/boot/dts/meson8.dtsi                                  |   2 +
 arch/arm/boot/dts/meson8b.dtsi                                 |   2 +
 arch/arm64/boot/dts/amlogic/Makefile                           |   2 +
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            |  39 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                      |  80 +++++++++++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  40 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  80 +++++++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts                |  25 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts                |  11 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |  29 ++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |  21 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts           |  26 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts         |  26 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    | 172 +++++++++++++++++++++++++++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi                |  43 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts           |  42 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 164 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 114 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  23 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts           |  21 +++---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 173 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     | 194 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |  25 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts                 |  42 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                     |   3 +
 drivers/clk/meson/gxbb.h                                       |  21 ++++--
 include/dt-bindings/clock/gxbb-clkc.h                          |  11 +++
 32 files changed, 1375 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
