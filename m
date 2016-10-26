From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 26 Oct 2016 17:03:53 +0200
Subject: [PATCH v2 0/4] Add DT support for DA8xx
Message-ID: <1477494237-22831-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this series is to add DT support to the da8xx USB OTG.
This series should apply and build without any issues but it has
some dependencies on "Add DT support for ohci-da8xx" series.
Without it, the phy init will fail and then the da8xx driver will also fail.

Changes in v2:
* Remove unrelated changes in patch 3
* Rename the device node in patch 4

Alexandre Bailon (1):
  ARM: dts: da850: Add the usb otg device node

Petr Kulhavy (3):
  dt/bindings: Add binding for the DA8xx MUSB driver
  usb: musb: core: added helper function for parsing DT
  usb: musb: da8xx: Add DT support for the DA8xx driver

 .../devicetree/bindings/usb/da8xx-usb.txt          | 43 ++++++++++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts                   |  8 ++++
 arch/arm/boot/dts/da850.dtsi                       | 15 +++++++
 drivers/usb/musb/da8xx.c                           | 47 ++++++++++++++++++++++
 drivers/usb/musb/musb_core.c                       | 19 +++++++++
 drivers/usb/musb/musb_core.h                       |  5 +++
 6 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/da8xx-usb.txt

-- 
2.7.3
