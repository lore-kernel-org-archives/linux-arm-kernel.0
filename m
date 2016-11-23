From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 23 Nov 2016 15:11:49 +0100
Subject: [PATCH RESEND 0/2] add support for AXP209 GPIOs functions
Message-ID: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP209 PMIC has three GPIOs. Two of them can be muxed in other modes
(namely adc or regulator)[1] which cannot be used while the pin is in one
of GPIO modes.

This adds the possibility to use all functions of the GPIOs present in
the AXP209 PMIC thanks to the pinctrl subsystem.

An upcoming ADC driver for the AXP209 PMIC will make use of this pinctrl to
read ADC values of GPIO0 and GPIO1. At the moment, no driver is pinctrling
these GPIOs.

This patch also corrects the register used to read GPIO input status.

[1] see registers 90H, 92H and 93H at
    http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf

Quentin Schulz (2):
  gpio: axp209: use correct register for GPIO input status
  gpio: axp209: add pinctrl support

 .../devicetree/bindings/gpio/gpio-axp209.txt       |  28 +-
 drivers/gpio/gpio-axp209.c                         | 557 ++++++++++++++++++---
 2 files changed, 504 insertions(+), 81 deletions(-)

-- 

Adding Maxime Ripard (original driver author) and LKML to mail recipients.
2.9.3
