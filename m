From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 10 Feb 2017 11:04:42 +0100
Subject: [PATCH 0/2] meson-gxbb: Add mali-450 support
Message-ID: <1486721084-1383-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the merge of the Mali dt bindings at [1], add support for Mali clocks
and DT node.

The Mali is clocked by two identical clock paths behind a glitch free mux
to safely change frequency while running.
So these clocks must be added to the meson-gxbb clock controller.

[1] http://lkml.kernel.org/r/b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard at free-electrons.com

Neil Armstrong (2):
  clk: meson-gxbb: Add MALI clocks and fix GP0 pll support
  ARM64: dts: meson-gxbb: Add Mali node

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  37 +++++
 drivers/clk/meson/clk-pll.c                 |  34 ++++-
 drivers/clk/meson/clkc.h                    |   3 +
 drivers/clk/meson/gxbb.c                    | 211 +++++++++++++++++++++++++++-
 drivers/clk/meson/gxbb.h                    |   7 +-
 include/dt-bindings/clock/gxbb-clkc.h       |   4 +
 6 files changed, 282 insertions(+), 14 deletions(-)

-- 
1.9.1
