From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:31:59 +0100
Subject: [PATCH 00/11] usb: gadget: at91_udc: Rework for multi-platform support
Message-ID: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series reworks the at91_udc driver to prepare at91 for multi-platform
support.

It also include several fixes:
 - fix clock names to be consistent with other USB drivers
 - document clocks and clock-names properties in atmel-usb DT bindings doc

and some cleanup changes:
 - remove useless usb_clk
 - allocate at91_udc instance instead of using the statically defined one
 - simplify the probe and remove functions by using devm_ helpers
 - remove !DT specific code

The series depends on this patch [1] (which adds matrix registers definition).

Regards,

Boris

[1]https://lkml.org/lkml/2014/12/3/230

Boris Brezillon (11):
  usb: gadget: at91_udc: Fix clock names
  usb: gadget: at91_udc: Drop uclk clock
  usb: gadget: at91_udc: Document DT clocks and clock-names property
  ARM: at91/dt: at91sam9261: fix clocks and clock-names in udc
    definition
  usb: gadget: at91_udc: Remove non-DT handling code
  usb: gadget: at91_udc: Simplify probe and remove functions
  usb: gadget: at91_udc: Rework for multi-platform kernel support
  usb: gadget: at91_udc: Update DT binding documentation
  usb: gadget: at91_udc: Allocate udc instance
  ARM: at91/dt: declare matrix node as a syscon device
  ARM: at91/dt: fix at91 udc compatible strings

 .../devicetree/bindings/usb/atmel-usb.txt          |  10 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   9 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/gadget/udc/at91_udc.c                  | 530 +++++++++++----------
 drivers/usb/gadget/udc/at91_udc.h                  |   9 +-
 7 files changed, 298 insertions(+), 265 deletions(-)

-- 
1.9.1
