From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 11:44:41 +0200
Subject: [PATCH 0/3] Fix baud rate for Armada SoCs
Message-ID: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit df59fa7f4bca "spi: orion: support armada extended baud
rates" was too optimistic for the maximum baud rate that the Armada
SoCs can support. Fixing it is the purpose of the 1st patch.

Actually the Armada SoCs do not have the same constraints, some of
them have maximum absolute values whereas for the other it is linked
to the TCLK value. The second patch takes care of managing all these
cases.

Then the third patch updates the dtsi in order to use the accurate
value.

Only the first patch fixes a bug observed on the board by using a too
high frequency on the SPI bus. The other ones allow using the best
maximum frequency available.

Thanks,

Gregory


Gregory CLEMENT (3):
  spi: orion: Fix maximum baud rates for Armada 370/XP
  spi: orion: Fix extended baud rates for each Armada SoCs
  ARM: mvebu: use improved armada spi device tree compatible name for
    each SoC

 .../devicetree/bindings/spi/spi-orion.txt          |  8 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  2 -
 arch/arm/boot/dts/armada-370.dtsi                  |  4 ++
 arch/arm/boot/dts/armada-375.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  8 +++
 drivers/spi/spi-orion.c                            | 70 ++++++++++++++++++++--
 8 files changed, 96 insertions(+), 14 deletions(-)

-- 
2.1.0
