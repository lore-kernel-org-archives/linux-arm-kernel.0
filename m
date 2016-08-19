From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 19 Aug 2016 22:16:58 +0930
Subject: [PATCH v2 0/7] aspeed: Integrate pinctrl and gpio drivers
Message-ID: <20160819124705.24633-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series contains the SoC-related patches of the Aspeed pinctrl and gpio
drivers. The v2 has been split out from the original monolithic series found at:

  https://lkml.org/lkml/2016/7/20/69 

The combined series has been tested with both the AST2400 (g4) and AST2500 (g5)
SoCs on OpenPOWER Palmetto and Aspeed AST2500 EVB machines respectively, and
similarly in QEMU with the palmetto-bmc and ast2500-evb machines[1].

Cheers,

Andrew

Andrew Jeffery (7):
  mach-aspeed: Select pinctrl drivers
  mach-aspeed: Select GPIO driver
  aspeed-g4: Add syscon and pin controller nodes
  palmetto: Request relevant mux functions in devicetree
  aspeed-g4: Add gpio controller to devicetree
  aspeed-g5: Add syscon and pin controller nodes
  aspeed-g5: Add gpio controller to devicetree

 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  14 +
 arch/arm/boot/dts/aspeed-g4.dtsi              | 429 ++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 213 +++++++++++++
 arch/arm/mach-aspeed/Kconfig                  |   5 +
 4 files changed, 661 insertions(+)

-- 
2.9.3
