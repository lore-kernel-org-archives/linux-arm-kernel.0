From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 10:25:21 +0800
Subject: [PATCH v7 0/6] imx28/imx6q: add usb support
Message-ID: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is platform part to add imx28/imx6q driver support.
The dirver part has been mostly merged to usb-next.

Changes since last version:
 - correct subject
 - use of_find_compatible_node
 - remove hub reset
 - add mx28 evk gpio pinctrl 

Richard Zhao (6):
  ARM: imx6q: add usb controller clock lookups
  ARM: imx6q: add usbphy clocks
  ARM: imx6q: disable usb charger detector
  ARM: dts: imx6q-sabrelite: add usb devices
  clk: mxs: clk_register_clkdev mx28 usb clocks
  ARM: dts: imx28-evk: add usb devices

 arch/arm/boot/dts/imx28-evk.dts       |   38 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi          |   12 ++++++++--
 arch/arm/boot/dts/imx6q-sabrelite.dts |   19 ++++++++++++++-
 arch/arm/boot/dts/imx6q.dtsi          |   36 +++++++++++++++++++++++++++--
 arch/arm/mach-imx/clk-imx6q.c         |   11 ++++++++-
 arch/arm/mach-imx/mach-imx6q.c        |   41 +++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk-imx28.c           |    4 ++++
 7 files changed, 155 insertions(+), 6 deletions(-)

-- 
1.7.9.5
