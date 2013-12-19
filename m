From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 19 Dec 2013 11:59:15 +0800
Subject: [PATCH 0/3] ARM: at91: add PWM clock and device node
Message-ID: <1387425558-8589-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add PWM clock and device node
  - The sama5d3 has transfer to CCF, so only it uses CCF, all others
    still use old clock method.
Switch gpio control leds to PWM control leds on at91sam9m10g45ek board.

This patch series depends on Atmel PWM driver which has in PWM subsystem.


Bo Shen (3):
  ARM: at91: add PWM clock
  ARM: at91: add PWM device node
  arm: at91: at91sam9m10g45ek: switch to PWM leds

 arch/arm/boot/dts/at91sam9263.dtsi     |    9 +++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |    9 +++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   25 +++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi     |    9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi      |    9 +++++++++
 arch/arm/boot/dts/sama5d3.dtsi         |   10 ++++++++++
 arch/arm/mach-at91/at91sam9263.c       |    1 +
 arch/arm/mach-at91/at91sam9g45.c       |    1 +
 arch/arm/mach-at91/at91sam9n12.c       |    1 +
 arch/arm/mach-at91/at91sam9rl.c        |    1 +
 arch/arm/mach-at91/at91sam9x5.c        |    1 +
 11 files changed, 74 insertions(+), 2 deletions(-)

-- 
1.7.9.5
