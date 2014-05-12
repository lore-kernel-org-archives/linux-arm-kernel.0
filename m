From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:23:33 +0200
Subject: [PATCH v2 0/4] ARM: at91: move sam9x5 SoCs and boards to the CCF
Message-ID: <1399911817-4980-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series moves the at91sam9x5 SoCs and the at91sam9x5-ek boards to
the Common Clock Framework.

It depends on these series: [1], [2].

Best Regards,

Boris

[1] http://lkml.iu.edu/hypermail/linux/kernel/1403.3/00074.html
[2] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/27632

Boris BREZILLON (4):
  ARM: at91: prepare common clk transition for sam9x5 SoCs
  ARM: at91/dt: define sam9x5 clocks
  ARM: at91/dt: define sam9x5ek's crystal frequencies
  ARM: at91: move sam9x5 SoCs to the CCF

 arch/arm/boot/dts/at91sam9x5.dtsi        | 355 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9x5_can.dtsi    |  31 +++
 arch/arm/boot/dts/at91sam9x5_isi.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi    |  26 +++
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |  11 +
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  11 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi      |   8 +
 arch/arm/mach-at91/Kconfig               |   1 -
 arch/arm/mach-at91/at91sam9x5.c          |   6 +-
 10 files changed, 483 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9x5_can.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_isi.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5_lcd.dtsi

-- 
1.8.3.2
