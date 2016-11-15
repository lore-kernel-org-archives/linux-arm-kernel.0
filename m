From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 15:28:06 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.10
Message-ID: <7hpolw2uih.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are the arm64 DT changes for Amlogic family SoCs.

Please pull,

Thanks,

Kevin


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to ab5b24fdd2d551ea729e8e19e47811a646260331:

  ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes (2016-11-15 12:05:54 -0800)

----------------------------------------------------------------
Amlogic DT changes for 64-bit platforms for v4.10

Support for new drivers:
- USB
- i2c
- SPI
- mailbox/MHU
- PWM
- ethernet MAC, PHY
- secure monitor
- IR
- watchdog

----------------------------------------------------------------
Andreas F?rber (1):
      ARM64: dts: amlogic: Reorder copyrights for meson-gx

Brian Kim (1):
      ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes

Carlo Caione (1):
      ARM64: dts: amlogic: Add basic support for Amlogic S905X

Kevin Hilman (1):
      ARM64: dts: meson-gxbb: add MMC support

Martin Blumenstingl (1):
      ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes

Neil Armstrong (22):
      ARM64: dts: amlogic: Add Meson GX dtsi from GXBB
      ARM64: dts: amlogic: Add basic support for Amlogic S905D
      devicetree: Add vendor prefix for Nexbox
      ARM64: dts: meson-gxbb: Add support for the Nexbox A95X Board
      ARM64: dts: meson-gx: Add missing L2 cache node
      ARM64: dts: meson-gxbb: Add rmii pinctrl node and rename rgmii node
      ARM64: dts: meson-gxbb: Add Wifi 32K clock for p20x boards
      ARM64: dts: meson-gxbb: Add P20x Wifi SDIO support
      ARM64: dts: meson-gxbb: Add MMC nodes to Nexbox A95x
      ARM64: dts: meson-gxbb: Add SRAM node
      ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
      ARM64: dts: meson-gxbb: Move common nodes to meson-gx
      ARM64: dts: meson-gxl: Add pinctrl nodes
      ARM64: dts: meson-gxl: Add clock nodes
      ARM64: dts: meson-gxl: Add i2c nodes
      ARM64: dts: meson-gxl: Add MMC/SD/SDIO nodes
      ARM64: dts: meson-gxl-p23x: Add uart pinctrl
      ARM64: dts: meson-gxl-p23x: Add SD/SDIO/MMC and PWM nodes
      ARM64: dts: meson-gxl-p23x: Enable IR receiver
      ARM64: dts: meson-gxl: Add ethernet nodes with internal PHY
      ARM64: dts: meson-gxl-p23x: Enable ethernet
      ARM64: dts: meson-gxl-s905x: Enable internal ethernet PHY

 Documentation/devicetree/bindings/arm/amlogic.txt      |  11 ++
 Documentation/devicetree/bindings/vendor-prefixes.txt  |   1 +
 arch/arm64/boot/dts/amlogic/Makefile                   |   4 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi              | 360 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 231 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts    | 119 +++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi       | 129 +++++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   | 106 ++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi            | 900 +++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts   |  76 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts   |  57 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi  | 188 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi       |  48 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts   |  69 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi       |  54 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi             | 301 ++++++++++++++++++++++++++++++++++++++++
 16 files changed, 2120 insertions(+), 534 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
