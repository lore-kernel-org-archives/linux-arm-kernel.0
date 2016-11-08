From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue,  8 Nov 2016 19:58:28 +0100
Subject: [PATCH 0/3] [PART 4/4] USB: ohci-da8xx: Add DT support
Message-ID: <20161108185831.17683-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series defines the bindings and adds device tree support
for the davinci OHCI driver.

DEPENDENCIES:
1. [PATCH 0/3] fix ohci phy name
https://lkml.org/lkml/2016/11/2/208
2. [PATCH/RFC v2 0/3] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/3/188
3. [PATCH v4 0/3] [PART 1/4] USB: ohci-da8xx: Allow a regulator for VBUS and over current
4. [PATCH 0/3] [PART 2/4] ARM: davinci: OHCI: Use a regulator instead of callbacks
5. [PATCH 0/2] [PART 3/4] USB: ohci-da8xx: Remove platform callbacks

A branch with all the dependencies can be found here:
https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v4


Axel Haslam (3):
  USB: ohci: da8xx: Add devicetree bindings
  USB: ohci: da8xx: Allow probing from DT
  ARM: dts: da850: add usb device node

 .../devicetree/bindings/usb/ohci-da8xx.txt         | 39 ++++++++++++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts                   |  8 +++++
 arch/arm/boot/dts/da850.dtsi                       |  8 +++++
 drivers/usb/host/ohci-da8xx.c                      |  8 +++++
 4 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

-- 
2.10.1
