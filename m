From: yrdreddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 20 Nov 2015 12:55:20 -0500
Subject: [PATCH 0/3] pinmux support for Broadcom NSP SOC
Message-ID: <1448042120-9212-1-git-send-email-yrdreddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pinmux support for the Broadcom's
Northstar Plus (NSP) SOC.

The first patch provides the documentation details and the
second patch contains the driver details. The third patch
contains the enable method.

This patchset has been tested on NSP bcm958625HR board.
This patchset is based on v4.4.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: nsp-pinmux-v1

Yendapally Reddy Dhananjaya Reddy (3):
  pinctrl: Broadcom NSP pinctrl device tree bindings
  pinctrl: nsp: add pinmux driver support for Broadcom NSP SoC
  ARM: dts: enable pinctrl for Broadcom NSP

 .../bindings/pinctrl/brcm,nsp-pinmux.txt           |  79 +++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   7 +
 arch/arm/boot/dts/bcm958625k.dts                   |   9 +
 drivers/pinctrl/bcm/Kconfig                        |  13 +
 drivers/pinctrl/bcm/Makefile                       |   1 +
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              | 650 +++++++++++++++++++++
 6 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,nsp-pinmux.txt
 create mode 100644 drivers/pinctrl/bcm/pinctrl-nsp-mux.c

-- 
2.1.0
