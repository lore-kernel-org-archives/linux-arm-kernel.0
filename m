From: plaes@plaes.org (Priit Laes)
Date: Mon, 27 Feb 2017 23:09:10 +0200
Subject: [PATCH 0/4] ARM: sun7i: Convert sun7i SoC to sunxi-ng
Message-ID: <20170227210914.18954-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is serie brings another SoC into the sunxi-ng world.

As mentioned in sun5i conversion, this is pretty much standard
stuff as all the required clocks were already implemented in
the sunxi-ng framework.


Priit Laes (4):
  clk: sunxi-ng: Add clocks and reset indices for sun7i-a20 SoC
  clk: sunxi-ng: Add sun7i-a20 CCU driver
  ARM: sun7i: Convert to CCU
  dt-bindings: List devicetree binding for the CCU of Allwinner A20

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  719 ++-----------
 drivers/clk/sunxi-ng/Kconfig                       |   11 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun7i-a20.c               | 1068 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun7i-a20.h               |  121 +++
 include/dt-bindings/clock/sun7i-ccu.h              |  127 +++
 include/dt-bindings/reset/sun7i-ccu.h              |   40 +
 8 files changed, 1455 insertions(+), 633 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun7i-a20.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun7i-a20.h
 create mode 100644 include/dt-bindings/clock/sun7i-ccu.h
 create mode 100644 include/dt-bindings/reset/sun7i-ccu.h

-- 
2.9.3
