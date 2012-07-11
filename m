From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jul 2012 19:33:38 +0800
Subject: [PATCH v6 0/7] imx28/imx6q: add usb support 
Message-ID: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is platform part to add imx28/imx6q driver support.
The dirver part has been mostly merged to usb-next.

The last pinctrl patch also needs imx6q pinctrl driver fix that Aisheng
is working on. Of course it can pass build, and only effect usb gadget
function.

Richard Zhao (7):
  ARM: imx6q: correct device name of usbphy and usb controller clock
    export
  ARM: imx6q: add usbphy clocks
  ARM: imx6q: disable usb charger detector
  ARM: dts: imx6q-sabrelite: add usb devices
  ARM: mxs: clk_register_clkdev mx28 usb clocks
  ARM: dts: imx28-evk: add usb devices
  ARM: dts: imx6q-sabrelite: add usbotg pinctrl support

 arch/arm/boot/dts/imx28-evk.dts       |   36 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi          |   12 ++++++++--
 arch/arm/boot/dts/imx6q-sabrelite.dts |   30 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   42 +++++++++++++++++++++++++++++++--
 arch/arm/mach-imx/clk-imx6q.c         |   11 ++++++++-
 arch/arm/mach-imx/mach-imx6q.c        |   41 ++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk-imx28.c           |    4 ++++
 7 files changed, 171 insertions(+), 5 deletions(-)

-- 
1.7.9.5
