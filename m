From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  5 Apr 2016 00:22:29 +0800
Subject: [PATCH RFC 0/5] net: phy: sun8i-h3-ephy: Add Allwinner H3 Ethernet
 PHY driver
Message-ID: <1459786954-12649-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is an attempt to support the Ethernet PHY incorporated in Allwinner's
H3 SoC. It is a MII PHY, supporting 10/100 Mbps Ethernet.

Before the PHY can be accessed via MDIO and used, it needs to be powered
on and configured. This is done via a system control register in the CPU
address space. The same register also controls PHY interface mode and
MAC TX clock sources.

This driver brings up the Ethernet PHY (if it is used), and exports a
clock control for the MAC TX clock.

Patch 1 adds the bindings for this piece of hardware.

Patch 2 adds the driver for it.

Patch 3 adds a device node for the PHY.

Patch 4 & 5 are not to be merged. They are provided here as a solid
example of how this driver is used. The sun8i-emac bindings have not
been submitted and are not stable yet.

Comments welcome.

Regards
ChenYu


Chen-Yu Tsai (4):
  net: phy: sun8i-h3-ephy: Add bindings for Allwinner H3 Ethernet PHY
  net: phy: sun8i-h3-ephy: Add driver for Allwinner H3 Ethernet PHY
  ARM: dts: sun8i-h3: Add H3 Ethernet PHY device node to sun8i-h3.dtsi
  ARM: dts: sun8i: Enable Ethernet controller on the Orange PI PC

LABBE Corentin (1):
  ARM: dts: sun8i-h3: Add Ethernet controller device node to
    sun8i-h3.dtsi

 .../bindings/net/allwinner,sun8i-h3-ephy.txt       |  44 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  14 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  21 ++
 drivers/net/phy/Kconfig                            |   8 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/sun8i-h3-ephy.c                    | 266 +++++++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-h3-ephy.txt
 create mode 100644 drivers/net/phy/sun8i-h3-ephy.c

-- 
2.7.0
