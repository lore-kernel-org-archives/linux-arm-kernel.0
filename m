From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 14 Apr 2014 10:43:10 +0200
Subject: [PATCH 0/4] ARM: at91: move sam9x5 SoCs and boards to the CCF
Message-ID: <1397464994-27267-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <b.brezillon.dev@gmail.com>

Hello,

This series moves the at91sam9x5 SoCs and the at91sam9x5-ek boards to
the Common Clock Framework.

It depends on this series [1], which introduces new slow clock and main
clock implementation (and DT bindings) for at91 SoCs.

Best Regards,

Boris

[1] http://lkml.iu.edu/hypermail/linux/kernel/1403.3/00074.html

Boris BREZILLON (4):
  ARM: at91: prepare common clk transition for sam9x5 SoCs
  ARM: at91/dt: define sam9x5 clocks
  ARM: at91/dt: define sam9x5ek's crystal frequencies
  ARM: at91: move sam9x5 SoCs to the CCF

 arch/arm/boot/dts/at91sam9x5.dtsi        | 357 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9x5_can.dtsi    |  31 +++
 arch/arm/boot/dts/at91sam9x5_isi.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  11 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi      |   8 +
 arch/arm/mach-at91/Kconfig               |   1 -
 arch/arm/mach-at91/at91sam9x5.c          |   6 +-
 10 files changed, 485 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9x5_can.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_isi.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_lcd.dtsi

-- 
1.8.3.2
