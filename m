From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Sep 2012 22:35:38 +0200
Subject: [PATCHv3 0/3] gpios: Add daisy-chaining and dt support to 74x164
Message-ID: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is an attempt at adding the support for chained 8 bit shift registers that
are present in the cfa-10049.

This patchset also adds dt documentation to the 74x164 gpio driver.

Thanks,
Maxime

Changes since v2:
  * Fixed a memleak in the _write_config function when having an error.

Maxime Ripard (3):
  gpio: 74x164: Add support for the daisy-chaining
  gpio: 74x164: dts: Add documentation for the dt binding
  ARM: dts: cfa10049: Add the 74HC595 gpio expanders

 .../devicetree/bindings/gpio/gpio-74x164.txt       |   22 +++++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   21 ++++++
 drivers/gpio/gpio-74x164.c                         |   68 ++++++++++++++++++--
 3 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-74x164.txt

-- 
1.7.9.5
