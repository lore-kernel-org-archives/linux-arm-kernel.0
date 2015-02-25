From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Feb 2015 13:36:11 +0000
Subject: [PATCH 0/6] Add dwc3 usb3 DT node and various phy cleanup
Message-ID: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series primarily adds the dwc3 DT node which activates the usb3 controller on
the stih407-b2120 and stih410-b2120 platforms.

As part of getting this working I noticed some various errors with the DT
documentation examples for how we reference the PHYs which I've also fixed.

Whilst doing this I also noticed the miphy365 (found on stih415/6 platforms) could
now use the generic PHY constants which are used by miphy28, so I've updated this
driver and the DT docs accoringly..

Also miphy28lp driver isn't included in STI section of MAINTAINERS, so rectify that.

regards,

Peter.

Peter Griffin (6):
  phy: miphy365x: Use the generic phy type constants in
    dt-bindings/phy/phy.h
  ahci: st: Update the DT example for how to obtain the PHY.
  ARM: DT: STi: STiH407: Update picophyreset for the usb3 controllers
    usb2 phy
  ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
  usb: dwc3: dwc3-st: Update the DT example.
  MAINTAINERS: Add phy-miphy28lp.c to ARCH/STI architecture

 Documentation/devicetree/bindings/ata/ahci-st.txt  |  4 ++--
 .../devicetree/bindings/phy/phy-miphy365x.txt      |  8 +++----
 Documentation/devicetree/bindings/usb/dwc3-st.txt  |  4 ++--
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/stih407-family.dtsi              | 28 +++++++++++++++++++++-
 arch/arm/boot/dts/stih416.dtsi                     |  4 ++--
 drivers/phy/phy-miphy365x.c                        | 14 +++++------
 include/dt-bindings/phy/phy-miphy365x.h            | 14 -----------
 8 files changed, 45 insertions(+), 32 deletions(-)
 delete mode 100644 include/dt-bindings/phy/phy-miphy365x.h

-- 
1.9.1
