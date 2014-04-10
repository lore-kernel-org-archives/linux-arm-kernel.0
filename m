From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 10 Apr 2014 15:07:49 +0200
Subject: [PATCH RESEND 0/5] ARM: berlin: add pinctrl support
Message-ID: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I made a typo in the LAKML address, so resend it.

This series add support for the Marvell Berlin pinctrl, allowing to
configure the pinmuxing from the device tree.

This is a group based pinmux and only group informations are defined.
For this to work a modification in the pinctrl framework is needed so
that get_group_pin could not be defined. Please have a look on patches
1/5 and 2/5 commit logs.

This serie applies on top of patches introducing the Marvell Berlin
BG2Q you can find on Sebastian's for-next branch[1] and Alexandre's
BG2Q symbol introduction[2].

Tested on the Berlin BG2Q.

[1] https://github.com/shesselba/linux-berlin/commits/for-next
[2] https://patchwork.kernel.org/patch/3876141/

Antoine T?nart (5):
  pinctrl: allows not to define the get_group_pins operation
  pinctrl: berlin: add a pinctrl driver for Marvell Berlin SoCs
  ARM: berlin: add the pinctrl dependency for the Marvell Berlin SoCs
  Documentation: add the Marvell Berlin pinctrl documentation
  ARM: dts: berlin: add the pinctrl node and muxing setup for uarts

 .../bindings/pinctrl/marvell,berlin-pinctrl.txt    |  43 ++
 arch/arm/boot/dts/berlin2.dtsi                     |  20 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |  13 +
 arch/arm/boot/dts/berlin2q.dtsi                    |  20 +
 arch/arm/mach-berlin/Kconfig                       |   2 +
 drivers/pinctrl/Kconfig                            |   4 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/core.c                             |  17 +-
 drivers/pinctrl/pinctrl-berlin.c                   | 498 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-berlin.h                   |  72 +++
 drivers/pinctrl/pinmux.c                           |  23 +-
 11 files changed, 696 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-berlin.c
 create mode 100644 drivers/pinctrl/pinctrl-berlin.h

-- 
1.8.3.2
