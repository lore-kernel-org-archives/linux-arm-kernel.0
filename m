From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 12:54:11 +0200
Subject: [PATCH 0/2] ARM: mvebu: fixes for v3.11
Message-ID: <1372762453-12018-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set comprises two unrelated fixes for Marvell SoCs based on
what is currently in next-20130701. There may be fixes already pending
for the issues.

The first patch is a clean-up patch removing dmacap,memset from the
device tree binding and users. DMA_MEMSET support has been removed from
DMA API and mv_xor driver.

The second patch fixes compilation of orion5x edmini_v2 by adding a
missing include.

devicetree-discuss is added on Cc for completeness, this is all Marvell
related and should go through Jason Cooper's branch if there are no
objections.

Sebastian Hesselbarth (2):
  ARM: remove dmacap,memset from Device tree binding
  ARM: orion5x: add missing mbus include

 Documentation/devicetree/bindings/dma/mv-xor.txt |    2 --
 arch/arm/boot/dts/armada-370.dtsi                |    2 --
 arch/arm/boot/dts/armada-xp.dtsi                 |    2 --
 arch/arm/boot/dts/dove.dtsi                      |    2 --
 arch/arm/boot/dts/kirkwood.dtsi                  |    2 --
 arch/arm/boot/dts/orion5x.dtsi                   |    1 -
 arch/arm/mach-orion5x/edmini_v2-setup.c          |    1 +
 7 files changed, 1 insertions(+), 11 deletions(-)

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
-- 
1.7.2.5
