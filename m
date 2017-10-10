From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:35 +0300
Subject: [PATCH v2 00/14] at91 fixes and enhancements
Message-ID: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series contains fixes and enhancements for Atmel/Microchip boards,
mainly for SoM1-EK board, SAMA5D2 Xplained board and SAM9x5 boards.
Please accept them for 4.15.

Thank you,
Claudiu Beznea

Changes since v1:
- correct author for some patches; these were developed first on internal
branch and then were manualy ported by me to Linux public tree (since the device
tree files are different) but then I forgot to keep the real author
- removed patch "ARM: dts: at91: sama5d2_xplained: Add charger node of pmic."
from this series since it was already applied on at91-dt branch (see [1])

[1] https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=at91-dt&id=4b6ad41f267b8ddabf5dd1b02a318bc74f0b95e9

Claudiu Beznea (14):
  ARM: dts: at91: sama5d27_som1_ek: add disabled/okay status
  ARM: dts: at91: sama5d27_som1_ek: update serial aliases
  ARM: dts: at91: sama5d27_som1_ek: set USER button as a wakeup source
  ARM: dts: at91: sama5d27_som1_ek: add aliases for i2c
  ARM: dts: at91: sama5d27_som1_ek: add pinmuxing for pwm0
  ARM: dts: at91: sama5d27_som1_ek: remove not connected CAN0
  ARM: dts: at91: sama5d27_som1_ek: remove pull-up on SD/MMC lines
  ARM: dts: at91: sama5d2_xplained: Add charger node of pmic.
  ARM: dts: at91: sama5d2_xplained: set PB_USER as wakeup source
  ARM: dts: at91: sama5d2_xplained: add pinmuxing for pwm0
  ARM: dts: at91: sama5d2_xplained: remove pull-up on SD/MMC lines
  ARM: dts: at91: at91sam9x25ek: add CAN1 interface
  ARM: dts: at91: at91sam9x25ek: add pwm0
  ARM: dts: at91: at91sam9x5ek: use DMA for USART0

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 46 ++++++++++++++---------------
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 39 ++++++++++++++++--------
 arch/arm/boot/dts/at91sam9x25ek.dts         | 10 +++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  2 ++
 4 files changed, 62 insertions(+), 35 deletions(-)

-- 
2.7.4
