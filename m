From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon,  2 Oct 2017 17:51:49 +0200
Subject: [PATCH v4 0/4] stm32 clocksource driver rework
Message-ID: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

version 4:
- split patch in 3 parts
  - convert code to timer_of
  - only use 32 bits timers
  - add clocksource support

version 3:
- fix comments done by Daniel
- use timer_of helper functions

version 2:
- fix uninitialized variable

These patches implements clocksource and clockevent by using only one hardware block.
Getting both clock source and events on the same hardware lead to change quite
a lot driver code.
It also limits usage of clocksource to 32 bits timers because 16 bits ones
aren't enough accurate.
Thanks to timer_fo helpers this series includes minor clean up in structures,
function prototypes and driver name.

Since 16 bits timers become useless it also removes them from stm32f4 and
stm32f7 devicetree.

Benjamin Gaignard (4):
  clocksource: stm32: convert driver to timer_of
  clocksource: stm32: only use 32 bits timers
  clocksource: stm32: add clocksource support
  arm: dts: stm32: remove useless clocksource nodes

 arch/arm/boot/dts/stm32f429.dtsi  |  32 ------
 arch/arm/boot/dts/stm32f746.dtsi  |  32 ------
 drivers/clocksource/Kconfig       |   1 +
 drivers/clocksource/timer-stm32.c | 229 ++++++++++++++++++--------------------
 4 files changed, 112 insertions(+), 182 deletions(-)

-- 
2.7.4
