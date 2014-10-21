From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Oct 2014 14:49:24 +0800
Subject: [RFC 0/3] ARM: sun9i: Add PRCM clocks and reset controls support
Message-ID: <1413874167-6479-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds basic support for the PRCM module on sun9i, which
has clock and reset controls for the CPU-S or RTC block.

The series is marked RFC, because we do not have actual documentation
for it. I am assuming the clock tree and register format is the same
as the A31 and A23. Obviously we will need to do some testing to verify,
which we would need actual peripherals to do.

I'm posting this so Maxime can test his pinctrl drivers, and then we
can work out how to verify the clocks.


Cheers
ChenYu


Chen-Yu Tsai (3):
  clk: sunxi: sun6i-apb0: Add support for sun9i A80 apbs gates
  mfd: sun6i-prcm: Add support for PRCM found on Allwinner A80 SoC
  ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun9i-a80.dtsi                  | 47 +++++++++++++++++++-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          |  6 +++
 drivers/mfd/sun6i-prcm.c                          | 52 +++++++++++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)

-- 
2.1.1
