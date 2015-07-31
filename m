From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 19:46:15 +0200
Subject: [PATCH v2 0/7] ARM: sunxi: Switch to clock indices
Message-ID: <1438364782-3968-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We currently have in our clock driver a logic very similar to the one
that clock-indices is supposed to cover.

Using this property, we can create a new driver generic for all gates
that will get the valid indices directly from the device tree, instead
of storing that in the driver itself.

While we're at it, we also move to using CLK_OF_DECLARE for that new
driver, which should ease the orphan clocks breakage we saw.

Let me know what you think,
Maxime

Changes from v1:
  - Remove unused headers in the driver
  - Fix the wrong commit log for the A80

Maxime Ripard (7):
  ARM: sun4i: Add clock indices
  ARM: sun5i: Add clock indices
  ARM: sun6i: Add clock indices
  ARM: sun7i: Add clock indices
  ARM: sun8i: Add clock indices
  ARM: sun9i: Wrap the clock-indices
  clk: sunxi: Add a simple gates driver

 arch/arm/boot/dts/sun4i-a10.dtsi     |  69 ++++++++++----
 arch/arm/boot/dts/sun5i-a10s.dtsi    |  23 ++++-
 arch/arm/boot/dts/sun5i-a13.dtsi     |  18 +++-
 arch/arm/boot/dts/sun5i.dtsi         |   1 +
 arch/arm/boot/dts/sun6i-a31.dtsi     |  24 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi     |  23 +++++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  15 +++
 arch/arm/boot/dts/sun9i-a80.dtsi     |  32 +++++--
 drivers/clk/sunxi/Makefile           |   1 +
 drivers/clk/sunxi/clk-simple-gates.c | 157 +++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c        | 177 -----------------------------------
 11 files changed, 333 insertions(+), 207 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-simple-gates.c

-- 
2.4.6
