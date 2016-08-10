From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 10 Aug 2016 11:20:05 +0530
Subject: [PATCH v6 0/3] net: phy: Add xilinx gmiitorgmii converter support
Message-ID: <1470808208-32133-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
Ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
This core can be used in all three modes of operation(10/100/1000 Mb/s).
The Management Data Input/Output (MDIO) interface is used to configure the
Speed of operation. This core can switch dynamically between the three
Different speed modes by configuring the conveter register through mdio write.

The conveter sits b/w the MAC and external phy like below

MACB <==> GMII2RGMII <==> RGMII_PHY

        MDIO    <========> GMII2RGMII
MCAB <=======>
                <========> RGMII

Using MAC MDIO bus we can access both the converter and the external PHY.
We need to program the line speed of the converter during run time based
On the external phy negotiated speed.

This patch series does the below
---> Add mask for Control register 10Mbps speed.
---> Add support for xilinx gmiitorgmii converter.

Kedareswara rao Appana (3):
  net: Add mask for Control register 10Mbps speed
  Documentation: DT: net: Add Xilinx gmiitorgmii converter device tree
    binding documentation
  net: phy: Add gmiitorgmii converter support

 .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |  35 +++++++
 drivers/net/phy/Kconfig                            |   7 ++
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xilinx_gmii2rgmii.c                | 109 +++++++++++++++++++++
 include/uapi/linux/mii.h                           |   1 +
 5 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
 create mode 100644 drivers/net/phy/xilinx_gmii2rgmii.c

-- 
2.1.2
