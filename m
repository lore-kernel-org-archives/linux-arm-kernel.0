From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 05 Jan 2018 16:26:40 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.16, round 3
Message-ID: <7hh8rz25of.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A final round of 64-bit DT changes for Amlogic SoCs.

These were just waiting for the clock dependencies to land in the clock
tree which they now have.  I've merged the same tag into this branch to
avoid any dependency issues.

Thanks,

Kevin


The following changes since commit 43b9f617b5f98f2f7abb508fef5e535e5fb66a41:

  arm64: dts: meson-axg: add new reset DT node (2017-12-15 16:20:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3

for you to fetch changes up to f6f6ac914b82402b910b783cd13bf72de067f69f:

  ARM64: dts: meson-axg: enable ethernet for A113D S400 board (2018-01-05 15:27:31 -0800)

----------------------------------------------------------------
Another round of 64-bit DT changes for the new Amlogic SoCs.  These
include IR, SPI and ethernet MAC support for the new AXG family SoCs.

----------------------------------------------------------------
Kevin Hilman (1):
      Merge tag 'meson-clk-headers-for-v4.16-2' of git://github.com/BayLibre/clk-meson into v4.16/dt64

Qiufang Dai (1):
      clk: meson-axg: add clocks dt-bindings required header

Sunny Luo (1):
      ARM64: dts: meson-axg: add the SPICC controller

Yixun Lan (5):
      dt-bindings: clock: add compatible variant for the Meson-AXG
      arm64: dts: meson-axg: switch uart_ao clock to CLK81
      ARM64: dts: meson-axg: enable IR controller
      ARM64: dts: meson-axg: add ethernet mac controller
      ARM64: dts: meson-axg: enable ethernet for A113D S400 board

 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt |   7 +++--
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                |  13 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                    | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/axg-clkc.h                          |  71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/clock/axg-clkc.h
