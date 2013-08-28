From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 28 Aug 2013 13:00:40 +0200
Subject: [PATCH 0/9] ARM: at91/dt: add missing devices to rm9200ek board
Message-ID: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for the remaining devices (or device options)
not yet supported in dt.

AFAICT there is no more infos/devices not converted to dt for this board,
and we should be able to remove board-at91rm9200ek.c (when we decide to
do it).

This series was not tested (the dt compilation passed), could someone
owning this board test it ?

In order to test it, you need to apply these series first:
https://lkml.org/lkml/2013/8/27/58
pinctrl: at91: add support for OUTPUT config

Best Regards,

Boris

Boris BREZILLON (9):
  ARM: at91/dt: rm9200: add spi0 chip select pins definitions
  ARM: at91/dt: add ethernet phy to at91rm9200ek board
  ARM: at91/dt: add usb1 vbus and pullup pins
  ARM: at91/dt: add atmel,pullup-gpio to at91rm9200ek usb1 definition
  ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek board
  ARM: at91/dt: add spi0 support to at91rm9200ek board
  ARM: at91/dt: add i2c devices connected to at91rm9200ek board
  ARM: at91/dt: add new at91rm9200ek_mmc board
  ARM: at91/dt: add new at91rm9200ek_dataflash board

 arch/arm/boot/dts/at91rm9200.dtsi            |   20 ++++++
 arch/arm/boot/dts/at91rm9200ek.dts           |   88 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek_dataflash.dts |   33 ++++++++++
 arch/arm/boot/dts/at91rm9200ek_mmc.dts       |   23 +++++++
 4 files changed, 164 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91rm9200ek_dataflash.dts
 create mode 100644 arch/arm/boot/dts/at91rm9200ek_mmc.dts

-- 
1.7.9.5
