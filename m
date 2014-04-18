From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 12:22:35 +0200
Subject: [PATCH 0/8] USB3 support for Armada 38x
Message-ID: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds the USB3 support for the Armada 38x and also
prepares the support for Armada 375. These SoCs use an xHCI but still
need specific initialization, mainly to setup the windows memory on
the mbus.

The first patch extend the the xhci-plat driver to allow to register
platform specific functions.

The second patch use it to setup the windows memory on the mbus for
Armada 38x.

Then the 3rd patch update he binding documentation.

This first 3 patches should go through the xhci subsystem, I really
would like to have a feedback on the 1st patch from the USB
maintainers.

The rest of the series is more platform specific and should go through
the mvebu tree, except the last patch that should be taken directly by
the arm-soc maintainer.

The support for Armada 375 is coming soon.

Thanks,

Gregory

Gregory CLEMENT (8):
  usb: host: xhci-plat: Allow to register glue code using the device
    tree
  usb: host: xhci-plat: Add support for the Armada 38x glue code
  xhci-platform: Add a new controller using xhci: Armada 38x
  ARM: mvebu: Add USB3 UTMI support
  ARM: mvebu: Add Device Tree description of xHCI hosts on Armada 38x
  ARM: mvebu: Add USB3 support for Armada 38x
  ARM: configs: Add usb_xhci_mvebu to mvebu_v7_defconfig
  ARM: configs: Add usb_xhci_mvebu to multi_v7_defconfig

 Documentation/devicetree/bindings/usb/usb-xhci.txt |   3 +-
 arch/arm/boot/dts/armada-385-db.dts                |   8 ++
 arch/arm/boot/dts/armada-385-rd.dts                |   4 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  17 ++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 arch/arm/mach-mvebu/Kconfig                        |   1 +
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/usb-utmi.c                     |  64 +++++++++++++
 drivers/usb/host/Kconfig                           |   7 ++
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/xhci-mvebu.c                      | 105 +++++++++++++++++++++
 drivers/usb/host/xhci-mvebu.h                      |  21 +++++
 drivers/usb/host/xhci-plat.c                       |  82 +++++++++++++++-
 drivers/usb/host/xhci.h                            |   4 +
 15 files changed, 315 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/usb-utmi.c
 create mode 100644 drivers/usb/host/xhci-mvebu.c
 create mode 100644 drivers/usb/host/xhci-mvebu.h

-- 
1.8.1.2
