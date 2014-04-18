From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Apr 2014 09:41:43 +0200
Subject: [PATCH 0/5] ARM: mvebu: misc Device Tree fixes and updates
Message-ID: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Andrew, Sebastian,

Here are five patches making misc Device Tree fixes and updates for
mvebu platforms:

 * The first patch is really a fix, that makes audio actually work on
   Armada 370 DB. It should be merged as part of 3.15-rc.

 * The second patch enables the SATA interface on Armada 375 DB,
   apparently something we forgot to do when submitting the initial
   Armada 375 DB Device Tree. Not sure whether it's 3.15 or 3.16
   material.

 * The last three patches are improvements to the Device Tree to use
   the 'clocks' property for UART controllers instead of an hard-coded
   'clock-frequency' property. This is clearly cleanup stuff, so 3.16
   is in order.

Thanks!

Thomas

Thomas Petazzoni (5):
  ARM: mvebu: specify I2C bus frequency on Armada 370 DB
  ARM: mvebu: enable the SATA interface on Armada 375 DB
  ARM: mvebu: use clocks property for serial ports
  ARM: mvebu: remove clock-frequency of serial port Device Tree nodes
  ARM: mvebu: don't use clocks property in UART node for Netgear RN2120

 arch/arm/boot/dts/armada-370-db.dts              | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 1 -
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 1 -
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 1 -
 arch/arm/boot/dts/armada-370-rd.dts              | 1 -
 arch/arm/boot/dts/armada-370-xp.dtsi             | 2 ++
 arch/arm/boot/dts/armada-375-db.dts              | 6 +++++-
 arch/arm/boot/dts/armada-375.dtsi                | 2 ++
 arch/arm/boot/dts/armada-385-db.dts              | 1 -
 arch/arm/boot/dts/armada-385-rd.dts              | 1 -
 arch/arm/boot/dts/armada-38x.dtsi                | 2 ++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 2 --
 arch/arm/boot/dts/armada-xp-db.dts               | 4 ----
 arch/arm/boot/dts/armada-xp-gp.dts               | 4 ----
 arch/arm/boot/dts/armada-xp-matrix.dts           | 4 ----
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 1 -
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 2 --
 arch/arm/boot/dts/armada-xp.dtsi                 | 2 ++
 18 files changed, 14 insertions(+), 25 deletions(-)

-- 
1.9.2
