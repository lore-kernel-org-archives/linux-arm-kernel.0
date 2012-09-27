From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Sep 2012 17:13:01 +0200
Subject: [PATCHv3 0/3] ARM: I2C: Add device tree bindings to i2c-mux-gpio
Message-ID: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset adds the device tree entry to the CFA-10049 board of its i2c
muxer. This muxer controls sub-buses that contains three Nuvoton NAU7802
ADCs and a NXP PCA955 GPIO expander. Support for these will be added
eventually.

Thanks,
Maxime

Changes from v2:
  - Fixed indentation of device tree nodes in patch 3
  - Removed the address-cells and size-cells properties that are useless
    for now.

Changes from v1:
  - Fixed indentation in patch 1
  - Fixed arrays allocation for the dt bindings
  - Various fixes in the documentation

Maxime Ripard (3):
  i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
  i2c: mux: Add dt support to i2c-mux-gpio driver
  ARM: dts: cfa10049: Add the i2c muxer buses to the CFA-10049

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 +++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   24 +++
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  172 +++++++++++++++-----
 3 files changed, 234 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

-- 
1.7.9.5
