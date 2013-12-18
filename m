From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Dec 2013 15:10:24 +0100
Subject: i.MX35 devicetree support
Message-ID: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree support for the i.MX35. This was originally made
by Steffen Trumtrar and later continued by Denis Carikli. Changes since
the last posting from Denis (v8, Nov 12 2013):

- use CLK_OF_DECLARE as requested by Shawn
- add usb devicetree nodes
- add spi devicetree nodes
- add cpus devicetree node
- split uart pin groups into txd,rxd / rts,cts

Sascha

----------------------------------------------------------------
Steffen Trumtrar (2):
      ARM i.MX35: Add devicetree support.
      ARM: dts: Add support for the i.MX35.

 .../devicetree/bindings/clock/imx35-clock.txt      | 113 +++++++
 arch/arm/boot/dts/imx35-pingrp.h                   | 104 ++++++
 arch/arm/boot/dts/imx35.dtsi                       | 375 +++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |   8 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/clk-imx35.c                      |  14 +
 arch/arm/mach-imx/imx35-dt.c                       |  57 ++++
 7 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 arch/arm/boot/dts/imx35-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx35.dtsi
 create mode 100644 arch/arm/mach-imx/imx35-dt.c
