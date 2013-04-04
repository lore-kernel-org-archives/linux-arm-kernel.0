From: florian@openwrt.org (Florian Fainelli)
Date: Thu,  4 Apr 2013 12:27:10 +0200
Subject: [PATCH 0/5 v2] mv643xx_eth: device tree bindings
Message-ID: <1365071235-11611-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch serie implements mv643xx_eth device tree bindings. I opted for
the reuse of the bindings already defined in
Documentation/devicetree/bindings/marvell.txt so that we do not create
any confusion.

For reference, I have included the mv643xx-eth related nodes in the
corresponding Kirkwood, Dove and Orion5x .dtsi files so you can more
easily test on your own platforms.

I tested these on a custom 88F6181-based boards.

Florian Fainelli (5):
  mv643xx_eth: add Device Tree bindings
  mv643xx_eth: update Device Tree bindings documentation
  ARM: kirkwood: add device node entries for the gigabit interfaces
  ARM: orion5x: add gigabit ethernet device tree node
  ARM: dove: add gigabit device tree nodes to dove.dtsi

 Documentation/devicetree/bindings/marvell.txt |   25 +++++-
 arch/arm/boot/dts/dove.dtsi                   |   25 ++++++
 arch/arm/boot/dts/kirkwood.dtsi               |   46 ++++++++++
 arch/arm/boot/dts/orion5x.dtsi                |   23 +++++
 drivers/net/ethernet/marvell/mv643xx_eth.c    |  120 ++++++++++++++++++++++++-
 5 files changed, 234 insertions(+), 5 deletions(-)

-- 
1.7.10.4
