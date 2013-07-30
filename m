From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 16:59:44 +0200
Subject: [PATCH 00/10] Introduce Allwinner A20 support
Message-ID: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

This patchset brings in support for the Allwinner A20 SoC.

This SoC is pretty much the heir of the Allwinner A10. They both have a lot of
IP in common, the A20 is pin-compatible with the A10, the only major difference
being that the A20 has 2 Cortex-A7 instead of the single Cortex-A8 found in the
A10.

Just like the A31, the SMP support isn't there yet, nor do we have clock
support or any storage device.

We also have the same SMP bit issue that makes Linux run without the caches
enabled for the time being when CONFIG_SMP isn't set.

This serie comes on top of the serie "ARM: sunxi: Add support for the Allwinner
A31 SoC" I sent previously.

Thanks,
Maxime

Maxime Ripard (10):
  ARM: sunxi: Introduce Allwinner A20 support
  ARM: sun7i: Add Allwinner A20 DTSI
  ARM: sun7i: Add Olimex A20-Olinuxino-Micro support
  pinctrl: sunxi: Wrap long compatible declaration lines
  pinctrl: sunxi: Add Allwinner A20 pins set
  pinctrl: sunxi: Fix inconsistent indentation
  ARM: sun7i: Add the PIO controller node to the DTSI
  ARM: sun7i: DT: Add UART muxing options to the DTSI
  ARM: sun7i: a20-olinuxino: Enable UARTs muxing
  ARM: sun7i: a20-olinuxino: Enable the user LED

 arch/arm/boot/dts/Makefile                      |    3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   61 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  204 +++++
 arch/arm/mach-sunxi/sunxi.c                     |    1 +
 drivers/pinctrl/pinctrl-sunxi-pins.h            | 1028 ++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-sunxi.c                 |   24 +-
 6 files changed, 1311 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20.dtsi

-- 
1.8.3.4
