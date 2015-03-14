From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 14 Mar 2015 11:57:15 +0800
Subject: [PATCH v5 0/2] ARM: sun9i: Add USB host controller support for A80
Message-ID: <1426305437-15208-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v5 of my A80 USB support series. v5 addresses some comments
on the phy driver, and adds a patch switching the dts from phy driver
regulator bindings to phy core bindings.


Changes since v4:

  - Fixed copyright date

  - Dropped unused header files

  - Dropped regulator code in the phy driver in favor of phy core
    power sequencing code

  - Dropped unneeded dev_set_drvdata()

  - Fixed MODULE_LICENSE to say GPL, matching header

  - Dropped unneeded "select USB_PHY" in Kconfig

  - Mention optional "phy-supply" property in bindings

  - Added "ARM: dts: sun9i: optimus: Switch to phy core regulator
    bindings for usb phys"


Regards
ChenYu

Chen-Yu Tsai (2):
  phy: Add driver to support individual USB PHYs on sun9i
  ARM: dts: sun9i: optimus: Switch to phy core regulator bindings for
    usb phys

 .../devicetree/bindings/phy/sun9i-usb-phy.txt      |  38 ++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   4 +-
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-sun9i-usb.c                        | 202 +++++++++++++++++++++
 5 files changed, 254 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
 create mode 100644 drivers/phy/phy-sun9i-usb.c

-- 
2.1.4
