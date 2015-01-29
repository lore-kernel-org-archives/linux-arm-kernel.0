From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 29 Jan 2015 15:09:08 +0100
Subject: [PATCH v6 0/8] imx25 adc and touchscreen driver
Message-ID: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a driver for the Freescale i.MX25 SoC internal ADC unit which
is used for touchscreen and ADC. The driver consists of three parts, the MFD
driver which handles interrupts and some central configuration registers, the
ADC driver and the touchscreen driver.

v6 splits the remaining DT binding documentation out into seperate patches. I
reworked the dt bindings for the gcq unit and made some code improvements from
comments.

Best regards,

Markus


Denis Carikli (2):
  ARM: dts: imx25: Add TSC and ADC support
  ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
    support.

Markus Pargmann (6):
  ARM: dt: Binding documentation for imx25 ADC/TSC
  ARM: dt: Binding documentation for imx25 GCQ
  ARM: dt: Binding documentation for imx25 touchscreen controller
  mfd: fsl imx25 Touchscreen ADC driver
  iio: adc: fsl,imx25-gcq driver
  input: touchscreen: imx25 tcq driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  54 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
 arch/arm/boot/dts/imx25.dtsi                       |  30 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   4 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 361 +++++++++++++
 drivers/input/touchscreen/Kconfig                  |   6 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 587 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 167 ++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
 include/linux/mfd/imx25-tsadc.h                    | 143 +++++
 16 files changed, 1463 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
 create mode 100644 include/linux/mfd/imx25-tsadc.h

-- 
2.1.4
