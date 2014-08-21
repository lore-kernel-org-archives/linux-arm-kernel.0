From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 21 Aug 2014 07:51:47 +0200
Subject: [PATCH v4 0/7] net: cpsw: Support for am335x chip MACIDs
Message-ID: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support to the cpsw driver to read the MACIDs of the am335x
chip and use them as fallback. These addresses are only used if there are no
mac addresses in the devicetree, for example set by a bootloader.

In v4 I removed an unused Makefile rule which was introduced by me when this
series introduced a seperate driver to read the MACID. As the code is now
integrated into the main driver this is not necessary anymore.

Best regards,

Markus Pargmann


Markus Pargmann (7):
  DT doc: net: cpsw mac-address is optional
  net: cpsw: Add missing return value
  net: cpsw: header, Add missing include
  net: cpsw: Replace pr_err by dev_err
  net: cpsw: Add am33xx MACID readout
  am33xx: define syscon control module device node
  arm: dts: am33xx, Add syscon phandle to cpsw node

 Documentation/devicetree/bindings/net/cpsw.txt |  6 +++-
 arch/arm/boot/dts/am33xx.dtsi                  |  6 ++++
 drivers/net/ethernet/ti/Kconfig                |  2 ++
 drivers/net/ethernet/ti/cpsw.c                 | 49 ++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw.h                 |  1 +
 5 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.1.0.rc1
