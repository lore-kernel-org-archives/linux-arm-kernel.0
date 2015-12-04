From: yrdreddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 4 Dec 2015 12:09:41 -0500
Subject: [PATCH v2 0/3] gpio support for Broadcom NSP
Message-ID: <1449248981-12102-1-git-send-email-yrdreddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second iteration in the series.

Changes in v2:
Addressed the review comments on device tree bindings and
the device tree file.

This patchset contains the gpio support for the Broadcom's
Northstar Plus (NSP) SOC.

The first patch provides the documentation details and the
second patch contains driver details. The third patch
contains the enable method.

This patchset has been tested on NSP bcm958625HR board with pinctrl
patch added.
This patchset is based on v4.4.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: nsp-gpio-v1

Yendapally Reddy Dhananjaya Reddy (3):
  pinctrl: Broadcom NSP GPIO-a device tree bindings
  pinctrl: nsp: add gpio-a driver support for Broadcom NSP SoC
  ARM: dts: enable GPIO-a for Broadcom NSP

 .../devicetree/bindings/pinctrl/brcm,nsp-gpio.txt  |  80 +++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  12 +
 drivers/pinctrl/bcm/Kconfig                        |  17 +
 drivers/pinctrl/bcm/Makefile                       |   1 +
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             | 749 +++++++++++++++++++++
 5 files changed, 859 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
 create mode 100644 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c

-- 
2.1.0
