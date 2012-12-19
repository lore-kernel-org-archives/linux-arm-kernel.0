From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Dec 2012 21:18:09 +0100
Subject: [PATCHv2 0/6] Add pinctrl driver for Allwinner A1X SoCs
Message-ID: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch set adds a pinctrl driver for the IP found in the Allwinner A10
and A13, and the SoC-specific bits for the A13. It also adds the documentation
for the device tree bindings.

This patch set has been tested on a Olimex A13-Olinuxino.

Thanks,
Maxime

Changes from v1:
  - Uses the pinconf-generic mechanism
  - Changed the dt interface to remove the direct bitstuffing to a more
    readable format
  - Replaced the register accessor macros by inline functions and documented
    them

Maxime Ripard (6):
  ARM: sunxi: Add pinctrl driver for Allwinner SoCs
  ARM: pinctrl: sunxi: Add the pinctrl pin set for sun5i
  ARM: sunxi: Add pinctrl node to the device tree
  ARM: sunxi: Add uart1 pinctrl groups
  tty: of_serial: Add pinctrl support
  ARM: sunxi: olinuxino: Add muxing for the uart

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   60 ++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    2 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   21 +
 arch/arm/mach-sunxi/Kconfig                        |    1 +
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-sunxi.c                    |  792 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.h                    |  384 ++++++++++
 drivers/tty/serial/of_serial.c                     |    7 +
 include/linux/pinctrl/pinconf-generic.h            |    1 +
 10 files changed, 1274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.c
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.h

-- 
1.7.9.5
