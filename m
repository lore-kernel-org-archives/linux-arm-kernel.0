From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 22 Jun 2017 14:49:22 -0700
Subject: [GIT PULL] Amlogic 64-bit DT changes for v3.14 (round 2)
Message-ID: <7h60fnae1p.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Here's a small, second round of 64-bit DT changes for v4.13.  This ws
waiting for the clock dependencies finalize and  arrive in clk-next,
which they are now.

The clock header dependencies are also merged into this branch.

Kevin


The following changes since commit 27f87bd2900b1a95d9c8e25deeb9768cf3fdcc4e:

  ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes (2017-06-09 11:38:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to cd84aff1d981bc34ed3166f3071916ca9ceefadf:

  ARM64: dts: meson-gxl: Add Libre Technology CC support (2017-06-22 12:02:05 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT changes for v4.13 (round 2)
- support new SPI controller driver
- several more leaf clocks exposed to DT
- New board: S905x LibreTech CC board

----------------------------------------------------------------
Helmut Klein (1):
      clk: meson-gxbb: expose UART clocks

Jerome Brunet (6):
      clk: meson-gxbb: expose spdif clock gates
      clk: meson-gxbb: expose i2s master clock
      clk: meson-gxbb: expose spdif master clock
      dt-bindings: add Libre Technology vendor prefix
      dt-bindings: arm: amlogic: Add Libre Technology CC board
      ARM64: dts: meson-gxl: Add Libre Technology CC support

Kevin Hilman (1):
      Merge tag 'meson-clk-headers-for-4.13' of git://github.com/BayLibre/clk-meson into v4.13/dt64

Martin Blumenstingl (1):
      clk: meson-gxbb: un-export the CPU clock

Neil Armstrong (2):
      clk: meson-gxbb: expose SPICC gate
      ARM64: dts: meson-gx: Add SPICC nodes

 Documentation/devicetree/bindings/arm/amlogic.txt            |  1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/amlogic/Makefile                         |  1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |  9 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  |  7 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   |  7 ++++
 drivers/clk/meson/gxbb.h                                     | 20 ++++++------
 include/dt-bindings/clock/gxbb-clkc.h                        | 10 +++++-
 9 files changed, 137 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
