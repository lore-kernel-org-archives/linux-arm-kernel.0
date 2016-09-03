From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 02 Sep 2016 17:27:23 -0700
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.9
Message-ID: <7h7fat25g4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The pull request below is for the DT changes for 64-bit Amlogic
platforms.

The DT additions for the new clock/reset support are dependent on DT
bindings/includes that were merged via the clock tree, so this branch
includes a merge of an immtable branch (clk/clk-gxbb-meson-ao) from the
clock tree to handle those dependencies.

Due to the dependency, it's fine with me if this goes into next/late
instead of next/dt64.

Thanks,

Kevin



The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to bfe59f92d30613398997f235dbae623583d61b38:

  ARM64: dts: amlogic: gxbb: Enable NVMEM (2016-09-01 15:27:11 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT changes for v4.9
- add watchdog, reset, IR remote, PWM
- add secure monitor and eFuse
- add always-on (AO) domain clock and reset

----------------------------------------------------------------
Carlo Caione (4):
      documentation: Add secure monitor bindings documentation
      ARM64: dts: amlogic: gxbb: Enable secure monitor
      documentation: Add nvmem bindings documentation
      ARM64: dts: amlogic: gxbb: Enable NVMEM

Kevin Hilman (4):
      ARM64: DTS: meson-gxbb: switch ethernet to real clock
      Merge branch 'clk-meson-gxbb-ao' of git://git.kernel.org/.../clk/linux into v4.8/dt64
      ARM64: dts: amlogic: add the input pin for the IR remote
      ARM64: dts: meson-gxbb: Add PWM pinctrl nodes

Martin Blumenstingl (1):
      ARM64: dts: meson-gxbb: Enable the the IR decoder on supported boards

Neil Armstrong (6):
      ARM64: dts: amlogic: meson-gxbb: Add watchdog node
      dt-bindings: clock: reset: Add GXBB AO Clock and Reset Bindings
      clk: meson: Add GXBB AO Clock and Reset controller driver
      ARM64: dts: meson-gxbb: Add GXBB AO Clock and Reset node
      dt-bindings: media: meson-ir: Add Meson8b and GXBB compatible strings
      ARM64: dts: meson-gxbb: Add Infrared Remote Controller decoder

Wei Yongjun (1):
      clk: meson: Fix invalid use of sizeof in gxbb_aoclkc_probe()

 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt |  45 +++++++++++++++++++++
 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt   |  15 +++++++
 Documentation/devicetree/bindings/media/meson-ir.txt            |   5 ++-
 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt       |  39 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts             |   5 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi                |   5 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi            |   6 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                     | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/meson/Makefile                                      |   2 +-
 drivers/clk/meson/gxbb-aoclk.c                                  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/gxbb-aoclkc.h                         |  66 ++++++++++++++++++++++++++++++
 include/dt-bindings/reset/gxbb-aoclkc.h                         |  66 ++++++++++++++++++++++++++++++
 12 files changed, 575 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
 create mode 100644 drivers/clk/meson/gxbb-aoclk.c
 create mode 100644 include/dt-bindings/clock/gxbb-aoclkc.h
 create mode 100644 include/dt-bindings/reset/gxbb-aoclkc.h
