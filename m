From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Sep 2016 15:59:54 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.9, round 2 (for next/late)
Message-ID: <7h37l0kbv9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is round 2 of the 64-bit DT changes for v4.9.

Based on my drivers pull (round 2), this is targetted at next/late also
since the DT patches here are using clock IDs that come from my 2nd
drivers pull (which itself has merged an immtable branch from the clock
tree.)

Please pull,

Kevin


The following changes since commit dfdd7d4af6ebee027be7bf2636b2314937948da6:

  clk: gxbb: expose i2c clocks (2016-09-14 11:24:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to e1e4a1a4fad203f8a02b887149809966e128a3d8:

  Merge branch 'v4.8/dt64' into v4.8/dt64-2 (2016-09-15 15:35:50 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT changes for v4.9, round 2

Primarily adding support for newly added drivers

- USB host
- I2C
- SPI flash controller
- PWM
- mailbox, MHU
- pinctrl: add pins for SPI, I2C, SDIO

and then enabling these drivers on various boards.

----------------------------------------------------------------
Carlo Caione (4):
      documentation: Add secure monitor bindings documentation
      ARM64: dts: amlogic: gxbb: Enable secure monitor
      documentation: Add nvmem bindings documentation
      ARM64: dts: amlogic: gxbb: Enable NVMEM

Jerome Brunet (4):
      ARM64: dts: amlogic: add spi nor pins
      ARM64: dts: meson-gxbb: add pins for I2C
      ARM64: dts: gxbb: add i2c bus
      ARM64: dts: meson-gxbb-p20x: Enable USB Nodes

Kevin Hilman (6):
      ARM64: DTS: meson-gxbb: switch ethernet to real clock
      Merge branch 'clk-meson-gxbb-ao' of git://git.kernel.org/.../clk/linux into v4.8/dt64
      ARM64: dts: amlogic: add the input pin for the IR remote
      ARM64: dts: meson-gxbb: Add PWM pinctrl nodes
      Merge tag 'amlogic-drivers-2' into v4.8/dt64-2
      Merge branch 'v4.8/dt64' into v4.8/dt64-2

Martin Blumenstingl (5):
      ARM64: dts: meson-gxbb: Enable the the IR decoder on supported boards
      ARM64: dts: amlogic: enable ethernet on all Tronsmart Vega S95 devices
      ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue driver
      ARM64: dts: meson-gxbb: add USB Nodes
      ARM64: dts: meson-gxbb-vega-s95: Enable USB Nodes

Neil Armstrong (9):
      ARM64: dts: amlogic: meson-gxbb: Add watchdog node
      ARM64: dts: meson-gxbb: Add GXBB AO Clock and Reset node
      dt-bindings: media: meson-ir: Add Meson8b and GXBB compatible strings
      ARM64: dts: meson-gxbb: Add Infrared Remote Controller decoder
      ARM64: dts: meson-gxbb: Add Meson MHU Node
      ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
      ARM64: dts: meson-gxbb: add the SDIO pins
      ARM64: dts: meson-gxbb: Add SPIFC node
      ARM64: dts: meson-gxbb: add I2C nodes

 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt |  15 ++++
 Documentation/devicetree/bindings/media/meson-ir.txt          |   5 +-
 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt     |  39 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts           |  11 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts               |   6 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi              |  35 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi          |  42 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                   | 329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 478 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
