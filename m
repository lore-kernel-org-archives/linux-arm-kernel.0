From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Jul 2018 11:39:39 +0200
Subject: [PATCH 0/2] clk: meson: Add video clocks path
Message-ID: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial support the Video Clocks used in the Display
Pipelin from the DRM driver.
The DRM driver is in his way to finaly switch to the Common Clock Framework
to setup the clock path, this adds the clock entries that will be used
by the DRM driver in a near future.

The vid_pll programmable divider is introduced in its R/O form right now,
but will be extended to be R/W in a next iteration.

Until the DRM driver actually uses these clocks, the Gates are marked as
IGNORE_IF_UNSUSED and the MUX/Dividers as NOCACHE since the registers
will be modified directly.

Neil Armstrong (2):
  clk: meson: Add vid_pll divider driver
  clk: meson-gxbb: Add video clocks

 drivers/clk/meson/Makefile            |   2 +-
 drivers/clk/meson/clkc.h              |   6 +
 drivers/clk/meson/gxbb.c              | 667 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |  24 +-
 drivers/clk/meson/vid-pll-div.c       |  90 +++++
 include/dt-bindings/clock/gxbb-clkc.h |  17 +
 6 files changed, 803 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.c

-- 
2.7.4
