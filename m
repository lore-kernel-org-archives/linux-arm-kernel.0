From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Sep 2012 14:18:09 +0200
Subject: [PATCHv2 0/7] gpios: Add daisy-chaining and dt support to 74x164
Message-ID: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the second attempt at adding the support for chained 8 bit
shift registers that are present in the cfa-10049.

This patchset also adds dt support to the 74x164 gpio driver.

Thanks,
Maxime

Changes since v1:
  * Added back the possibility to set the gpio base from the platform
    data
  * Removed the output-latch-gpios dt property to use the regular spi
    chip select mechanism that works in the same way.
  * Moved from multiple spi_write to a single spi_sync call because the
    chip select must be enabled during the whole transfer in our case,
    and not disabled after sending every byte.

Maxime Ripard (7):
  gpio: 74x164: Use module_spi_driver boiler plate function
  gpio: 74x164: Use devm_kzalloc
  gpio: 74x164: Use dynamic gpio number assignment if no pdata is
    present
  gpio: 74x164: Add device tree support
  gpio: 74x164: Add support for the daisy-chaining
  gpio: 74x164: dts: Add documentation for the dt binding
  ARM: dts: cfa10049: Add the 74HC595 gpio expanders

 .../devicetree/bindings/gpio/gpio-74x164.txt       |   22 ++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   21 ++++
 drivers/gpio/gpio-74x164.c                         |  105 ++++++++++++++------
 3 files changed, 120 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-74x164.txt

-- 
1.7.9.5
