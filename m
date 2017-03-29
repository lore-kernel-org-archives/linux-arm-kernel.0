From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 29 Mar 2017 14:45:03 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12
Message-ID: <m28tnn69ls.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Below are some 64-bit DT changes for Amlogic platforms for v4.12.  Note
that this branch includes a merge of an immutable branch from the clk
tree (clk-meson) due to dependencies on new clocks added to the meson
clock driver and used in these DT updates.

Kevin


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to a1093238d6b148b46b7f3e0642681ec41baa1d0b:

  Merge branch 'clk-meson' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux into v4.12/dt64 (2017-03-28 10:47:49 -0700)

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

Jerome Brunet (9):
      clk: meson: fix SET_PARM macro
      clk: meson: add missing const qualifiers on gate arrays
      clk: meson8b: put dividers and muxes in tables
      clk: gxbb: put dividers and muxes in tables
      clk: meson: mpll: add rw operation
      clk: meson: gxbb: mpll: use rw operation
      clk: meson8b: add the mplls clocks 0, 1 and 2
      clk: meson: mpll: correct N2 maximum value
      dt-bindings: clk: gxbb: expose i2s output clock gates

Kevin Hilman (1):
      Merge branch 'clk-meson' of git://git.kernel.org/.../clk/linux into v4.12/dt64

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

Neil Armstrong (20):
      ARM64: dts: meson-gx: Add Buttons to Q200 and P230 boards
      ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
      ARM64: dts: meson-gxbb-odroidc2: Fix TFLASH VDD regulator GPIO line
      ARM64: dts: meson-gx: Finally move common nodes to GX dtsi
      ARM64: dts: meson-gx: empty line cleanup
      ARM64: dts: meson-gx: Prepend GX generic compatible like other nodes
      ARM64: dts: meson-gxl: Add missing pinctrl pins groups
      clk: meson-gxbb: Add MALI clock IDS
      clk: meson-gxbb: Add MALI clocks
      clk: meson: Add support for parameters for specific PLLs
      clk: meson-gxbb: Add GP0 PLL init parameters
      clk: meson-gxbb: Add GXL/GXM GP0 Variant
      clk: meson-gxbb: Expose GP0 dt-bindings clock id
      dt-bindings: clock: gxbb-clkc: Add GXL compatible variant
      ARM64: dts: meson-gx: Add Mali nodes for GXBB and GXL
      ARM64: dts: meson-gxbb: Add gpio-ranges properties
      ARM64: dts: meson-gxl: Add gpio-ranges properties
      ARM: dts: meson8: Add gpio-ranges properties
      ARM: dts: meson8b: Add gpio-ranges properties
      ARM64: dts: meson-gxbb: Add USB Hub GPIO hog

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
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                      |  40 +++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  17 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  75 ++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts                |  25 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts                |  11 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |   6 --
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |  21 +++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts           |  26 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts         |  26 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    | 160 ++++++++++++++++++++++------
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi                |  43 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts           |  42 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 164 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 114 ++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts           |  21 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 173 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     | 181 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |   2 +
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts                 |  42 ++++++++
 drivers/clk/meson/clk-mpll.c                                   | 152 +++++++++++++++++++++++++-
 drivers/clk/meson/clk-pll.c                                    |  53 +++++++++-
 drivers/clk/meson/clkc.h                                       |  29 ++++-
 drivers/clk/meson/gxbb.c                                       | 505 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/clk/meson/gxbb.h                                       |  23 ++--
 drivers/clk/meson/meson8b.c                                    | 127 +++++++++++++++++++++-
 drivers/clk/meson/meson8b.h                                    |  20 +++-
 include/dt-bindings/clock/gxbb-clkc.h                          |  11 ++
 35 files changed, 2011 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
