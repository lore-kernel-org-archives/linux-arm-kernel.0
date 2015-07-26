From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jul 2015 23:14:23 +0200
Subject: [PATCH 0/7] ARM: sunxi: Switch to clock indices
Message-ID: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
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

Maxime Ripard (7):
  ARM: sun4i: Add clock indices
  ARM: sun5i: Add clock indices
  ARM: sun6i: Add clock indices
  ARM: sun7i: Add clock indices
  ARM: sun8i: Add clock indices
  ARM: sun9i: Add clock indices
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
 drivers/clk/sunxi/clk-simple-gates.c | 159 +++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c        | 177 -----------------------------------
 11 files changed, 335 insertions(+), 207 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-simple-gates.c

-- 
2.4.6
