From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Jan 2014 18:19:58 +0100
Subject: [PATCH 0/5] ARM: sun6i: Add support for the A31 I2C controller
Message-ID: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset adds support the A31 i2c controller. This is mostly the
same controller as the one found in the other Allwinner SoCs, except
for the interrupts acking.

On the other SoCs using this driver, the interrupts are acked by
clearing the INT_FLAG bit in the control register, while on the A31,
the interrupt is acked by writing that bit into the control register.

The other difference is that the I2C IP is maintained in reset by a
reset controller, so we're adding optionnal support for the reset
framework in the driver to deassert the device from reset.

Thanks!
Maxime

Maxime Ripard (5):
  i2c: mv64xxx: Add reset deassert call
  i2c: mv64xxx: Add support for the Allwinner A31 I2C driver
  ARM: sun6i: Enable the I2C controllers
  ARM: sun6i: Enable the I2C muxing options
  ARM: sun6i: colombus: Enable the I2C controllers

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  1 +
 arch/arm/boot/dts/sun6i-a31-colombus.dts           | 18 +++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 61 ++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-mv64xxx.c                   | 16 ++++++
 5 files changed, 97 insertions(+)

-- 
1.8.4.2
