From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 16 Aug 2014 17:18:28 +0200
Subject: [PATCH v3 0/7] net: cpsw: Support for am335x chip MACIDs
Message-ID: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support to the cpsw driver to read the MACIDs of the am335x
chip and use them as fallback. These addresses are only used if there are no
mac addresses in the devicetree, for example set by a bootloader.

In v3 I removed the previously seperate driver and included the changes into
the main cpsw driver. I now check for a am33xx machine to not make this
operation when running on davinci.

Patches 1-4 are some minor fixes for the cpsw driver.
Patch 5 adds the readout support.
Patches 6 and 7 are for am33xx.dtsi to actually enable this feature.

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
 drivers/net/ethernet/ti/Makefile               |  1 +
 drivers/net/ethernet/ti/cpsw.c                 | 49 ++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw.h                 |  1 +
 6 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.0.1
