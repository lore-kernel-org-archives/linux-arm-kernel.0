From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 14:26:39 +0100
Subject: [PATCH 0/5] clk: meson: Fix GXBB and GXL/GXM GP0 PLL
Message-ID: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes support for the Amlogic GXBB then GXL/GXM embedded GP0 PLL.

The current support is done via a very generic interface where only the
N/M/OD parameters are changed in the control registers.

But unlike the Fixed PLL, this PLL is not initialized by the bootloader or
firmware, and needs some parameters to initialize and lock correctly.

This patchset also adds the GXL variant compatible string which is already
supported by the GXL and GXM DT nodes.

Neil Armstrong (5):
  clk: meson: Add support for parameters for specific PLLs
  clk: meson-gxbb: Add GP0 PLL init parameters
  clk: meson-gxbb: Add GXL/GXM GP0 Variant
  clk: meson-gxbb: Expose GP0 dt-bindings clock id
  dt-bindings: clock: gxbb-clkc: Add GXL compatible variant

 .../bindings/clock/amlogic,gxbb-clkc.txt           |  3 +-
 drivers/clk/meson/clk-pll.c                        | 52 +++++++++++-
 drivers/clk/meson/clkc.h                           | 23 +++++
 drivers/clk/meson/gxbb.c                           | 97 +++++++++++++++++++++-
 drivers/clk/meson/gxbb.h                           |  4 +-
 include/dt-bindings/clock/gxbb-clkc.h              |  1 +
 6 files changed, 173 insertions(+), 7 deletions(-)

-- 
1.9.1
