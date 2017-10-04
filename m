From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:08 +1030
Subject: [PATCH v2 0/9] ARM: dts: aspeed: Device tree updates
Message-ID: <20171004064917.2498-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the i2c buses and vuart in the ASPEED device
trees, as well as making a few cleanups.

v2 fixes issues pointed out by Andrew's reivew, and adds Brendan's acks. Thanks
for the review both of you!

There's one more patch than v1 to seperate out fixing the UARTs from changing
their oder. I also used --diff-algorithm=patience for a nicer diff in patch 1.

I will merge these into my Aspeed devicetree tree once they have some acks.

I have a second series ready to go as soon as our clk driver is merged.

Cheers,

Joel

Andrew Jeffery (1):
  ARM: dts: aspeed: Move pinctrl subnodes to improve readability

Joel Stanley (8):
  ARM: dts: aspeed: Reorder ADC node
  ARM: dts: aspeed: Add I2C buses
  ARM: dts: aspeed-romulus: Add I2C devices
  ARM: dts: aspeed-palmetto: Add I2C devices
  ARM: dts: aspeed-ast2500: Add I2C devices
  ARM: dts: aspeed: Add aliases for UARTs
  ARM: dts: aspeed: Correctly order UART nodes
  ARM: dts: aspeed: Clean up UART nodes

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   19 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |   52 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   54 +
 arch/arm/boot/dts/aspeed-g4.dtsi              | 1812 +++++++++++++----------
 arch/arm/boot/dts/aspeed-g5.dtsi              | 1951 ++++++++++++++-----------
 5 files changed, 2265 insertions(+), 1623 deletions(-)

-- 
2.14.1
