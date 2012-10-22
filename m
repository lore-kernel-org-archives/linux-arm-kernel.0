From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Oct 2012 14:53:31 +0200
Subject: [PATCHv5 0/2] ARM: I2C: Add device tree bindings to i2c-mux-gpio
Message-ID: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset adds the device tree entry to the CFA-10049 board of its i2c
muxer. This muxer controls sub-buses that contains three Nuvoton NAU7802
ADCs and a NXP PCA955 GPIO expander. Support for these will be added
eventually.

Thanks,
Maxime

Changes from v4:
  - Fixed a wrong sentence in the bindings documentation, stating a false
    behavoiour

Maxime Ripard (2):
  i2c: mux: Add dt support to i2c-mux-gpio driver
  ARM: dts: cfa10049: Add the i2c muxer buses to the CFA-10049

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 ++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   24 +++
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  169 +++++++++++++++-----
 3 files changed, 235 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

-- 
1.7.9.5
