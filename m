From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  3 Apr 2015 23:16:01 +0200
Subject: [PATCH 0/6] pinctrl and gpio drivers for NXP LPC18xx family
Message-ID: <1428095767-6286-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds drivers for pinctrl and gpio on NXP LPC18xx/43xx
devices. Patchset is based on Linus master 4.0-rc6.

The pinctrl driver uses the generic muxing and properties DT bindings as
described in pinctrl-bindings.txt. There is still two TODOs left in the
pinctrl driver regarding property control of special usb1 pins but I would
like it merged regardless of this. Support will be added once I get USB up
and running on the MCU.

There is no gpio irq support in this patch set, this will come at a later
time.

The two last patches depend on two other patch sets and are only included
to show the DT bindings in actual use.

Other LPC18xx patches:
Base support: http://marc.info/?l=linux-arm-kernel&m=142792344110733&w=2
Clk support: http://marc.info/?l=linux-arm-kernel&m=142800699801335&w=2

Joachim Eastwood (6):
  pinctrl: add lpc18xx pinctrl driver
  doc: dt: add documentation for lpc1850-scu pinctrl driver
  gpio: add lpc18xx gpio driver
  doc: dt: add documentation for lpc1850-gpio driver
  ARM: dts: lpc18xx: add pinctrl and gpio nodes
  ARM: dts: lpc4357-ea4357: add pinctrl and uart0 muxing

 .../devicetree/bindings/gpio/nxp,lpc1850-gpio.txt  |   23 +
 .../bindings/pinctrl/nxp,lpc1850-scu.txt           |   57 +
 arch/arm/boot/dts/lpc18xx.dtsi                     |   57 +
 arch/arm/boot/dts/lpc4357-ea4357.dts               |   19 +
 drivers/gpio/Kconfig                               |    8 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-lpc18xx.c                        |  191 ++++
 drivers/pinctrl/Kconfig                            |    8 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-lpc18xx.c                  | 1145 ++++++++++++++++++++
 10 files changed, 1510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt
 create mode 100644 drivers/gpio/gpio-lpc18xx.c
 create mode 100644 drivers/pinctrl/pinctrl-lpc18xx.c

-- 
1.8.0
