From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Oct 2015 10:08:54 +0200
Subject: [PATCH v5 0/5] clk: sunxi: Add support for the Audio PLL
Message-ID: <1445242139-20965-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie adds support for the PLL2 aka the Audio PLL on the
Allwinner A10 and the later SoCs.

This is the last part of the audio codec support, it's been around for
quite a while now, and I expect it to be merged in 4.4.

This serie is built on top of a generic clk-multiplier driver to
handle clock that multiply their parent clock rate (mostly PLL's), in
order to provide the driver for the PLL2 base clock, and then adds the
drivers for the clock that derive from the Audio PLL.

Thanks!
Maxime

Changes from v4:
  - Fixed the genmask calls
  - Fixed the number of parents registration in mod1
  - Added Chen-Yu's Reviewed-by

Changes from v3:
  - Fixed the header issues: removed unused ones, added some others
  - Added the __acquire / __release call when a spinlock is not defined

Changes from v2:
  - Renamed clk-factor to clk-multiplier
  - Added an exception for the A13 clock

Changes from v1:
  - Removed a bogus of_iomap in the mod1 clock driver
  - Wrote the clk-factor driver
  - Converted the PLL2 clock to that driver

Emilio L?pez (2):
  clk: sunxi: codec clock support
  clk: sunxi: mod1 clock support

Maxime Ripard (3):
  clk: Add a basic multiplier clock
  clk: sunxi: Add a driver for the PLL2
  clk: sunxi: pll2: Add A13 support

 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-multiplier.c               | 181 ++++++++++++++++++++++++
 drivers/clk/sunxi/Makefile                 |   3 +
 drivers/clk/sunxi/clk-a10-codec.c          |  44 ++++++
 drivers/clk/sunxi/clk-a10-mod1.c           |  81 +++++++++++
 drivers/clk/sunxi/clk-a10-pll2.c           | 216 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/sun4i-a10-pll2.h |  53 +++++++
 include/linux/clk-provider.h               |  42 ++++++
 8 files changed, 621 insertions(+)
 create mode 100644 drivers/clk/clk-multiplier.c
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
 create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
 create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
 create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h

-- 
2.5.3
