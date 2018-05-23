From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 May 2018 11:50:51 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.18, round 3
Message-ID: <7hmuwqqk8k.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, ARnd,

Here's final round of 64-bit DT updates for v4.18 for Amlogic.

I separated this one from round 2 because I've merged a tag from the
clock tree where the headers were added that are used by the new clock
driver nodes.

That clock dependency branch is already queued by the clock maintainers,
but included here so the arm-soc DT branch will continue to build
standalone.

Kevin

The following changes since commit ffe2f2a415a5c36c0629c0ac8ea3dda80fbfd4b6:

  ARM64: dts: meson-axg: enable i2c AO on the S400 board (2018-05-23 10:05:41 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3

for you to fetch changes up to 9adda3534faad306c3d5351c5b87d26fea9767be:

  ARM64: dts: meson: fix clock source of the pclk for UART_AO (2018-05-23 11:31:54 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates, round3
- AXG: add new clock driver

----------------------------------------------------------------
Kevin Hilman (1):
      Merge tag 'for-kevin-meson-clk-bindings-v4.18-1' of https://github.com/BayLibre/clk-meson into v4.18/dt64

Martin Blumenstingl (1):
      dt-bindings: clock: meson8b: export the NAND clock

Maxime Jourdan (1):
      clk: meson: gxbb: expose VDEC_1 and VDEC_HEVC clocks

Qiufang Dai (1):
      ARM64: dts: meson-axg: add AO clock driver

Yixun Lan (3):
      dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
      dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
      ARM64: dts: meson: fix clock source of the pclk for UART_AO

 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt |  1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                      | 16 ++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                     |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                      |  4 ++--
 include/dt-bindings/clock/axg-aoclkc.h                          | 26 ++++++++++++++++++++++++++
 include/dt-bindings/clock/gxbb-clkc.h                           |  2 ++
 include/dt-bindings/clock/meson8b-clkc.h                        |  1 +
 include/dt-bindings/reset/axg-aoclkc.h                          | 20 ++++++++++++++++++++
 8 files changed, 68 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h
