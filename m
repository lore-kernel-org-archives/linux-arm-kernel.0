From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 12 Feb 2015 15:37:22 +0800
Subject: [PATCH v4 0/4] add usb support for hi6220
Message-ID: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Move drivers/usb/phy/phy-hi6220-usb.c to drivers/phy/phy-hi6220-usb.c, required by Balbi.
Modify dt bindings per comments from Mark and Sergei

v3:
fix typo and add -EPROBE_DEFER of regulator, pointed by Peter

v2:
address comments from Sergei and Peter
add hi6220_phy_setup(false) code

v1:
hi6220 usb controller is inherited from dwc2
add phy accordingly
support otg gadget/host

Zhangfei Gao (4):
  Documentation: dt-bindings: add dt binding info for hi6220 dwc2
  Documentation: dt-bindings: add dt binding info for hi6220
  usb: dwc2: platform: add hi6220 support
  phy: add phy-hi6220-usb

 Documentation/devicetree/bindings/usb/dwc2.txt     |   1 +
 .../devicetree/bindings/usb/hi6220-usb.txt         |  49 ++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-hi6220-usb.c                       | 306 +++++++++++++++++++++
 drivers/usb/dwc2/platform.c                        |  30 ++
 6 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt
 create mode 100644 drivers/phy/phy-hi6220-usb.c

-- 
1.9.1
