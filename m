From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 15 Feb 2013 15:48:53 +1300
Subject: [RFC PATCH] Add pin control driver for Wondermedia SoCS
Message-ID: <1360896534-20637-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before I get all carried away and start filling in all the data for
this driver, I was hoping someone (or a few people) could review the
basic design in case it requires changes to the data structures.

This driver is based on pinctrl-bcm2835.c as it seems to be similar in
design. The pin controller on Wondermedia SoC's only allows each pin to
either be a GPIO or to be its 'alternate' function. Functions cannot be
remapped to any other pin.

I have seperated out the data from the code as there are several SoC's
to support and each has it's own variation of registers / pin layout.
I borrowed this part of the design from the Tegra pinctrl driver.

Regards
Tony Prisk

Tony Prisk (1):
  pinctrl: gpio: vt8500: Add pin control driver for Wondermedia SoCs

 arch/arm/Kconfig                   |    4 +-
 arch/arm/boot/dts/wm8850-w70v2.dts |   15 +
 arch/arm/boot/dts/wm8850.dtsi      |    7 +-
 arch/arm/mach-vt8500/Kconfig       |    1 +
 drivers/pinctrl/Kconfig            |   10 +
 drivers/pinctrl/Makefile           |    2 +
 drivers/pinctrl/pinctrl-wm8850.c   |  166 +++++++++++
 drivers/pinctrl/pinctrl-wmt.c      |  565 ++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-wmt.h      |   73 +++++
 9 files changed, 840 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-wm8850.c
 create mode 100644 drivers/pinctrl/pinctrl-wmt.c
 create mode 100644 drivers/pinctrl/pinctrl-wmt.h

-- 
1.7.9.5
