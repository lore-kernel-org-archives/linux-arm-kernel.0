From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 22 Jun 2017 14:46:34 -0700
Subject: [GIT PULL] Amlogic 32-bit DT changes for v4.13 (round 2)
Message-ID: <7hfuerae6d.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's a small round 2 of 32-bit DT changes for Amlogic SoCs.  This was
waiting for the clock dependencies to be merged, and they are now in
clk-next.

The dependencies on clock headers were generously separated out by the
clock maintainers (thanks Neil & Jerome)

Kevin

The following changes since commit 2c323c43a3d619d67bffa57dc7480cfae4c53300:

  ARM: dts: meson8: add and use the real clock controller (2017-06-09 11:21:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-2

for you to fetch changes up to f28d4bdb74b6fec482cdbba032369a185baa74b9:

  ARM: dts: meson: use the real ethernet clock on Meson8 and Meson8b (2017-06-16 12:07:11 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT changes for v4.13 (round 2)
- greatly expands DT clock support for meson8b

----------------------------------------------------------------
Helmut Klein (1):
      clk: meson-gxbb: expose UART clocks

Jerome Brunet (3):
      clk: meson-gxbb: expose spdif clock gates
      clk: meson-gxbb: expose i2s master clock
      clk: meson-gxbb: expose spdif master clock

Kevin Hilman (1):
      Merge tag 'meson-clk-headers-for-4.13-2' of git://github.com/BayLibre/clk-meson into v4.13/dt

Martin Blumenstingl (17):
      clk: meson-gxbb: un-export the CPU clock
      clk: meson8b: export the SAR ADC clocks
      clk: meson8b: export the SDIO clock
      clk: meson8b: export the gate clock for the HW random number generator
      clk: meson8b: export the USB clocks
      clk: meson8b: export the ethernet gate clock
      ARM: dts: meson8: fix the IR receiver pins
      ARM: dts: meson: use C preprocessor friendly include syntax
      ARM: dts: meson: use GIC_SPI and IRQ_TYPE_EDGE_RISING macros
      ARM: dts: meson8: add the PWM_E and PWM_F pins
      ARM: dts: meson8: add the pins for the SDIO controller
      ARM: dts: meson: add the SAR ADC
      ARM: dts: meson8: add reserved memory zones
      ARM: dts: meson: add the hardware random number generator
      ARM: dts: meson: add USB support on Meson8 and Meson8b
      ARM: dts: meson8b: add the SCU device node
      ARM: dts: meson: use the real ethernet clock on Meson8 and Meson8b

Neil Armstrong (1):
      clk: meson-gxbb: expose SPICC gate

 arch/arm/boot/dts/meson.dtsi             |  75 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/boot/dts/meson6-atv1200.dts     |   2 +-
 arch/arm/boot/dts/meson6.dtsi            |   2 +-
 arch/arm/boot/dts/meson8.dtsi            | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/meson8b.dtsi           |  50 +++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h                 |  20 ++++++------
 drivers/clk/meson/meson8b.h              |  20 ++++++------
 include/dt-bindings/clock/gxbb-clkc.h    |  10 +++++-
 include/dt-bindings/clock/meson8b-clkc.h |  10 ++++++
 9 files changed, 271 insertions(+), 42 deletions(-)
