From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 21 Dec 2015 10:24:07 +0100
Subject: [PATCH 0/5] Introduce at91_adc8xx driver
Message-ID: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the very basic support for the adc introduced with the SAMA5D2 SoC
family.

The goal is to provide something to the user as soon as possible instead of
waiting for a full featured driver.

Only unsigned conversions on a software tigger are supported. Next steps are
signed conversions, differential channels, hardware triggers, dma support,
touchscreen support, and others.

Ludovic Desroches (5):
  iio:adc:at91_adc8xx: introduce new atmel adc driver
  MAINTAINERS: add entry for Atmel ADC 8xx driver
  ARM: at91/dt: sama5d2: add adc device
  ARM: at91/dt: sama5d2 Xplained: enable the adc device
  ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig

 .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  27 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  22 ++
 arch/arm/boot/dts/sama5d2.dtsi                     |  11 +-
 arch/arm/configs/sama5_defconfig                   |   1 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/at91_adc8xx.c                      | 417 +++++++++++++++++++++
 8 files changed, 495 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
 create mode 100644 drivers/iio/adc/at91_adc8xx.c

-- 
2.5.0
