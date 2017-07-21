From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Fri, 21 Jul 2017 06:06:38 +0200
Subject: [PATCH v4 0/2] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170721040640.31424-1-linux-kernel-dev@beckhoff.com>
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

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

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

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:65/78=83%)
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: Jonathan Cameron <jic23@kernel.org> (commit_signer:6/78=8%)
Cc: Kevin Hilman <khilman@baylibre.com> (commit_signer:6/78=8%)
Cc: Thierry Reding <treding@nvidia.com> (commit_signer:5/78=6%)
Cc: Maxime Ripard <maxime.ripard@free-electrons.com> (commit_signer:5/78=6%)
Cc: "Andreas F?rber" <afaerber@suse.de> (authored:4/78=5%)
Cc: Marek Vasut <marek.vasut@gmail.com> (authored:4/78=5%)
Cc: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk> (added_lines:14/92=15%,removed_lines:13/14=93%)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> (removed_lines:1/14=7%,commit_signer:66/621=11%)
Cc: "David S. Miller" <davem@davemloft.net> (commit_signer:52/621=8%)
Cc: Mauro Carvalho Chehab <mchehab@kernel.org> (commit_signer:44/621=7%)
Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
To: linux-kernel at vger.kernel.org (open list)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Fabio Estevam <fabio.estevam@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM PORT)

Patrick Bruenn (2):
  dt-bindings: arm: Add entry for Beckhoff CX9020
  ARM: dts: imx: add CX9020 Embedded PC device tree

 Documentation/devicetree/bindings/arm/bhf.txt      |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts                 | 295 +++++++++++++++++++++
 arch/arm/boot/dts/imx53-pinfunc.h                  |   4 +
 arch/arm/boot/dts/imx53.dtsi                       |   9 +
 7 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts

-- 
2.11.0
