From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 16:10:46 +0100
Subject: [GIT PULL] at91: drivers for 3.3
Message-ID: <4EEA0DF6.3050408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is a first "drivers" part of our material for 3.3 merge window. It collects
Ethernet drivers changes.
One thing to note is that the macb.c driver is modified to support
device tree. We agreed with David to drag those modifications into
arm-soc git tree because they go on top of Jamie's work on macb-gem driver
already in your drivers/macb-gem branch.

This pull request goes on top of Linus' 3.2-rc5 commit but with additional 
dependencies with two of your branches:
1/ fixes (which seems already included in 3.2-rc5)
2/ drivers/macb-gem

I had to resolve a conflict while merging the macb-gem branche with current 3.2-rc5. The 
resolution is commited into this branch.
Tell me if you need more precision.


The following changes since commit 6d69370e2b4a1e04e9ba0095d60aec7736fa1a99:

  Merge remote-tracking branch 'armsoc/drivers/macb-gem' into for-3.3on32rc5-drivers (2011-12-15 15:55:59 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git for-arnd-3.3-drivers

Jean-Christophe PLAGNIOL-VILLARD (1):
      net/macb: add DT support for Cadence macb/gem driver

Nicolas Ferre (2):
      ARM: at91/net: add macb ethernet controller in 9g45/9g20 DT
      net/at91_ether: use gpio_is_valid for phy IRQ line

 Documentation/devicetree/bindings/net/macb.txt |   25 ++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi             |    7 ++
 arch/arm/boot/dts/at91sam9g45.dtsi             |    7 ++
 arch/arm/boot/dts/at91sam9m10g45ek.dts         |    5 ++
 arch/arm/boot/dts/usb_a9g20.dts                |    5 ++
 drivers/net/ethernet/cadence/at91_ether.c      |   23 ++++---
 drivers/net/ethernet/cadence/macb.c            |   73 +++++++++++++++++++++---
 drivers/net/ethernet/cadence/macb.h            |    2 +
 8 files changed, 129 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/macb.txt

Thanks, bye,
-- 
Nicolas Ferre
