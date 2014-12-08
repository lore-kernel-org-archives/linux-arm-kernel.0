From: lyz@rock-chips.com (Yunzhi Li)
Date: Mon,  8 Dec 2014 17:46:23 +0800
Subject: [PATCH v3 0/5] 
Message-ID: <1418031988-2700-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches to add support for Rockchip usb phys.Add a new Rockchip
usb phy driver and modify dwc2 controller driver to make dwc2
platform devices support a generic PHY framework driver. This
patch set has been tested on my rk3288-evb and power off the usb
phys would reduce about 60mW power budget in total during sustem
suspend.

Changes in v3:
- Use BIT macro instead of bit shift ops.
- Rename the config entry to PHY_ROCKCHIP_USB.
- Fix coding style: both branches of the if() which only one
  branch of the conditional statement is a single statement should
  have braces.
- No need to test dwc2->phy for NULL before calling generic phy
  APIs.
- Add more context about the changes in the long description.

Yunzhi Li (5):
  phy: add a driver for the Rockchip SoC internal USB2.0 PHY
  Documentation: bindings: add doc for the Rockchip usb PHY
  usb: dwc2: add generic PHY framework support for dwc2 usb    
    controler platform driver.
  ARM: dts: add rk3288 usb PHY
  ARM: dts: Enable usb PHY on rk3288-evb board

 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |  22 +++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   4 +
 arch/arm/boot/dts/rk3288.dtsi                      |  13 ++
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rockchip-usb.c                     | 179 +++++++++++++++++++++
 drivers/usb/dwc2/gadget.c                          |  33 ++--
 drivers/usb/dwc2/platform.c                        |  36 ++++-
 8 files changed, 272 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 drivers/phy/phy-rockchip-usb.c

-- 
2.0.0
