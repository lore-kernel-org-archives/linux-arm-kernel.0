From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 10 Feb 2015 15:50:22 +0800
Subject: [PATCH v3 0/5] add usb support for hi6220
Message-ID: <1423554627-694-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
fix typo and add -EPROBE_DEFER of regulator, pointed by Peter

v2:
address comments from Sergei and Peter
add hi6220_phy_setup(false) code

v1:
hi6220 usb controller is inherited from dwc2
add phy accordingly
support otg gadget/host


Zhangfei Gao (5):
  Documentation: dt-bindings: add dt binding info for hi6220 dwc2
  Documentation: dt-bindings: add dt binding info for hi6220
  usb: dwc2: platform: add hi6220 support
  usb: phy: load usb phy earlier
  usb: phy: add phy-hi6220-usb

 Documentation/devicetree/bindings/usb/dwc2.txt     |   1 +
 .../devicetree/bindings/usb/hi6220-usb.txt         |  49 ++++
 drivers/usb/Makefile                               |   2 +-
 drivers/usb/dwc2/platform.c                        |  30 ++
 drivers/usb/phy/Kconfig                            |   9 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-hi6220-usb.c                   | 308 +++++++++++++++++++++
 7 files changed, 399 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt
 create mode 100644 drivers/usb/phy/phy-hi6220-usb.c

-- 
1.9.1
