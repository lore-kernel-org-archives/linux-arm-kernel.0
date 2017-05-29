From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 29 May 2017 18:17:30 +0200
Subject: [PATCH v2 0/3] Add fixes to STM32 pintrl
Message-ID: <1496074653-2941-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add several fixes to STM32 pinctrl:
 - Set input mode when PIN is used as interrupt
 - Implement .get_direction() gpio_chip callback  
 - In DT: set each gpio controller as a interrupt controller. User who
   wants to use gpio as interrupt will have choice to use either "gpiolib"
   interface or "common" interrupt interface.

Changes since v1:
 -rebase on 4.12-rc1
 -Let gpiochip and irqchip orthogonal in stm32 pinctrl driver
 -Don't use gpiolib internal define

Regards
Alex

Alexandre TORGUE (3):
  pinctrl: stm32: set pin to gpio input when used as interrupt
  pinctrl: stm32: Implement .get_direction gpio_chip callback
  ARM: dts: stm32: Set gpio controller also as interrupt controller

 arch/arm/boot/dts/stm32f429.dtsi      | 22 +++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi      | 22 +++++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.c | 62 ++++++++++++++++++++++++++++-------
 drivers/pinctrl/stm32/pinctrl-stm32.h |  5 ++-
 4 files changed, 98 insertions(+), 13 deletions(-)

-- 
1.9.1
