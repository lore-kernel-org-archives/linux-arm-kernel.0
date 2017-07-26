From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Wed, 26 Jul 2017 14:05:30 +0200
Subject: [PATCH v5 0/4] ARM: dts: imx: add CX9020 Embedded PC device tree
Message-ID: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

The CX9020 differs from i.MX53 Quick Start Board by:
- use uart2 instead of uart1
- DVI-D connector instead of VGA
- no audio
- no SATA connector
- CCAT FPGA connected to emi
- enable rtc

v5:
- rebased on v4.13-rc2
- don't take maintainership for imx53-cx9020.dtsi, keep it to
  ARM/FREESCALE IMX maintainers
- add explicit pinmux settings for pwr leds (EIM_D22 - D24)
- remove display0->status="okay"
- use "regulator-vbus" as name for usb_vbus regulator node
- use correct reset values for explicit pinmux settings of:
  MX53_PAD_GPIO_0__CCM_CLKO
  MX53_PAD_GPIO_16__I2C3_SDA
  MX53_PAD_GPIO_1__ESDHC1_CD
  MX53_PAD_GPIO_3__GPIO1_3
  MX53_PAD_GPIO_8__GPIO1_8

v4:
- move alternative UART2 pinmux settings to imx53-pinfunc.h
- fix copyright notice and model name to clearify cx9020 is a
  Beckhoff board and not from Freescale/NXP/Qualcomm
- add "bhf,cx9020" compatible
- remove ccat node and pin configuration as long as the ccat
  driver is not mainlined
- use dvi-connector + ti,tfp410 instead of panel-simple
- add newlines between property list and child nodes
- replace underscores in node names with hypens
- replace magic number 0 with polarity defines from
  include/dt-bindings/gpio/gpio.h
- move rtc node into imx53.dtsi, change it's name into 'srtc',
  to avoid a conflict with 'rtc' node in imx53-m53.dtsi
- rename regulator-3p2v
- drop imx53-qsb container node
- make iomux configuration explicit
- remove unused audmux
- remove unused led_pin_gpio3_23 configuration
- use blue gpio-leds as disk-activity indicators for mmc0 and mmc1
- add mmc indicator leds to sdhc pingroups
- keep node names in alphabetical order
- remove unused sata and ssi2
- remove unused pin configs from hoggrp
- add entry for Beckhoff related files to MAINTAINERS

v3: add missig changelog
v2:
- keep alphabetic order of dts/Makefile
- configure uart2 with 'fsl,dte-mode'
- use display-0 and panel-0 as node names
- remove unnecessary "simple-bus" for fixed regulators

Patrick Bruenn (4):
  dt-bindings: arm: Add entry for Beckhoff CX9020
  ARM: dts: imx53: add srtc node
  ARM: dts: imx53: add alternative UART2 configuration
  ARM: dts: imx: add CX9020 Embedded PC device tree

 Documentation/devicetree/bindings/arm/bhf.txt      |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   5 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts                 | 297 +++++++++++++++++++++
 arch/arm/boot/dts/imx53-pinfunc.h                  |   4 +
 arch/arm/boot/dts/imx53.dtsi                       |   9 +
 7 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts

-- 
2.11.0
