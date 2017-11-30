From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:26 -0800
Subject: [PATCH 0/8] ARM: dts: introduce Compulab IoT Gateway
Message-ID: <20171130201434.14122-1-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

The Compulab IoT Gateway is based on an NXP i.MX7D, dual core
Cortex-A7 clocking at 1GHz. It supports up to 2GB of DDR3,
and 32GB of eMMC flash. Onboard, there are two gigabit
ethernet controllers, 4 x USB2, RS485, and CAN.

It uses the same SoM as the cl-som-imx7, but includes a baseboard 
with additional I/O.

Compulab has provided patches for this platform based on v4.1. 
I've used these patches as reference to get things working on tip.

The entire series is based on v4.15-rc1.

Tyler Baker (8):
  ARM: dts: imx7d-sbc-iot: add initial iot gateway dts
  ARM: dts: imx7: build imx7d-sbc-iot-imx7 dtb
  ARM: dts: imx7d-cl-som: add nodes for usbh, and usbotg2
  ARM: dts: imx7s: add dma support
  ARM: dts: imx7s: add node and supplies for vdd1p2
  ARM: dts: imx7d-sbc-iot: enable PCIe peripheral
  ARM: dts: imx7s: add usb hsic phy domain
  PCIe: imx6: imx7d: add support for phy refclk source

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts  |  36 ++++-
 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 252 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi             |  29 +++-
 drivers/pci/dwc/pci-imx6.c               |   8 +-
 5 files changed, 316 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts

-- 
2.9.3
