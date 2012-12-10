From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Dec 2012 23:08:15 +0100
Subject: [PATCH 0/6] Add pinctrl driver for Allwinner A1X SoCs
Message-ID: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch set adds a pinctrl driver for the IP found in the Allwinner A10
and A13, and the SoC-specific bits for the A13. It also adds the documentation
for the device tree bindings.

This patch set has been tested on a Olimex A13-Olinuxino.

Thanks,
Maxime

Maxime Ripard (6):
  ARM: sunxi: Add pinctrl driver for Allwinner SoCs
  ARM: pinctrl: sunxi: Add the pinctrl pin set for sun5i
  ARM: sunxi: Add pinctrl node to the device tree
  ARM: sunxi: Add uart1 pinctrl groups
  tty: of_serial: Add pinctrl support
  ARM: sunxi: olinuxino: Add muxing for the uart

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   77 +++
 arch/arm/boot/dts/sun5i-olinuxino.dts              |    2 +
 arch/arm/boot/dts/sun5i.dtsi                       |   21 +
 arch/arm/mach-sunxi/Kconfig                        |    1 +
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-sunxi.c                    |  555 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.h                    |  315 +++++++++++
 drivers/tty/serial/of_serial.c                     |    7 +
 9 files changed, 984 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.c
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.h

-- 
1.7.9.5
