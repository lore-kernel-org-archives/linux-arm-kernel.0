From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Aug 2013 21:08:41 +0200
Subject: [PATCH 0/2] clk: sunxi: Add support for the A20 clocks
Message-ID: <1376766523-9107-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set adds support for the basic clocks found on the Allwinner A20 SoC.
The A20 is on a general basis pretty close to the A10, and this also applies to the clocks.

That allows us to actually reuse a lot of the clocks found there, except for the
gates.

These patches add those gates and the associated documentation for the A20.

Thanks,
Maxime

Maxime Ripard (2):
  clk: sunxi: Add Allwinner A20 gates
  ARM: sun7i: Enable the A20 clocks in the DTSI

 Documentation/devicetree/bindings/clock/sunxi.txt  |   3 +
 .../bindings/clock/sunxi/sun7i-a20-gates.txt       |  98 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 126 +++++++++++++++++++--
 drivers/clk/sunxi/clk-sunxi.c                      |  15 +++
 4 files changed, 232 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt

-- 
1.8.3.4
