From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 17 Jan 2017 14:12:32 -0200
Subject: [PATCH v3 0/5] usb: dwc2: Add support for USB OTG on STM32F4x9
Message-ID: <20170117161237.3802-1-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STM32F4x9 MCU family has two DWC2 USB OTG cores on it. One core is
USB OTG FS and other core is USB OTG HS. The USB FS core only works with
its internal phy whilst the USF HS core can work in HS with external ulpi
phy or in FS/LS speed with the embedded FS PHY.

The goal of this patch series is to enable the use of USB OTG FS/HS cores
in FS mode using the internal phy.

Changes since v3:
- Removed commented lines from patch (sent by mistake)
- Split DTS patch by boards and SOC
- Removed unnecessary pinctrl nodes from DTS files

Changes since v2:
- Rename driver variables to meet the driver standard
- Add compatible string for HS core

Changes since v1:
- Add dwc2_core_params structure for stm32f4 otg fs
- Add compatible string for FS core/mode
- Use GGPIO register to deativate power down of the phy

Bruno Herrera (5):
  usb: dwc2: Add support for STM32F429/439/469 USB OTG HS/FS in FS mode
    (internal PHY)
  ARM: dts: stm32: Add USB FS support for STM32F429 MCU
  ARM: dts: stm32: Enable USB FS on stm32f469-disco
  ARM: dts: stm32: Enable USB HS in FS mode (embedded phy) on
    stm32f429-disco
  dt-bindings: Document the STM32 USB OTG DWC2 core binding

 Documentation/devicetree/bindings/usb/dwc2.txt |  4 ++
 arch/arm/boot/dts/stm32f429-disco.dts          | 16 ++++++++
 arch/arm/boot/dts/stm32f429.dtsi               | 31 ++++++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts          | 16 ++++++++
 drivers/usb/dwc2/core.h                        |  4 ++
 drivers/usb/dwc2/hcd.c                         | 13 ++++++-
 drivers/usb/dwc2/hw.h                          |  2 +
 drivers/usb/dwc2/params.c                      | 51 ++++++++++++++++++++++++++
 8 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.10.1 (Apple Git-78)
