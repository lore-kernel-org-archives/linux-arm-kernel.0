From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 21 Aug 2012 16:29:00 +0200
Subject: [RFC PATCH 0/5] fixes and DT support based on Nikolaus TWI driver
Message-ID: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Nikolaus,

First of all, thanks for the work you have done on i2c-at91 driver and sorry
to have been so long to answer you.

This set of patches is based on:
http://article.gmane.org/gmane.linux.kernel/1285193/match=patch+v10+0+4+at91+replace+broken+twi+driver+i2c+c

On my side, I don't see any issue with this new driver. I am not an I2C guru
but it works with all the I2C devices I have and your patches have already
been reviewed and tested. I'll continue to test it with other I2C devices and
on several chips.

So the goal of this set of patches is to get feedback on the fix I added, on
the DT support and to resurect your set of patches.

Regards

Ludovic

Ludovic Desroches (5):
  i2c: at91: add new fixes for some TWI ip versions
  i2c: at91: add dt support to i2c-at91
  ARM: at91: add clocks for i2c DT entries
  ARM: dts: add twi nodes for atmel SOCs
  ARM: dts: add twi nodes for atmel boards

 .../devicetree/bindings/i2c/atmel-i2c.txt          | 29 +++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 | 23 +++----
 arch/arm/boot/dts/at91sam9263.dtsi                 | 23 +++----
 arch/arm/boot/dts/at91sam9263ek.dts                | 20 +++---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 28 ++++-----
 arch/arm/boot/dts/at91sam9g25ek.dts                | 12 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 | 33 ++++++----
 arch/arm/boot/dts/at91sam9m10g45ek.dts             | 14 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 | 33 ++++++----
 arch/arm/boot/dts/at91sam9n12ek.dts                |  8 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 69 +++++++++------------
 arch/arm/mach-at91/at91rm9200_devices.c            |  9 ---
 arch/arm/mach-at91/at91sam9260.c                   |  1 +
 arch/arm/mach-at91/at91sam9263.c                   |  1 +
 arch/arm/mach-at91/at91sam9g45.c                   |  2 +
 arch/arm/mach-at91/at91sam9n12.c                   |  2 +
 arch/arm/mach-at91/at91sam9x5.c                    |  3 +
 drivers/i2c/busses/i2c-at91.c                      | 71 ++++++++++++++++------
 18 files changed, 239 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.txt

-- 
1.7.11.3
