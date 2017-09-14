From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 14 Sep 2017 09:56:50 +0200
Subject: [PATCH 0/2] stm32 clocksource driver rework
Message-ID: <1505375812-19037-1-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patch implements clocksource and clockevent by using only one hardware block.
It also limits usage of clocksource to 32 bits timers because 16 bits ones
aren't enough accurate.
Series includes minor clean up in structures, function prototypes and driver name.

Since 16 bits timers become useless it also removes them from stm32f4 and
stm32f7 devicetree.

Benjamin Gaignard (2):
  clocksource: stm32: rework driver to use only one timer
  arm: dts: stm32: remove useless clocksource nodes

 arch/arm/boot/dts/stm32f429.dtsi  |  32 -----
 arch/arm/boot/dts/stm32f746.dtsi  |  32 -----
 drivers/clocksource/timer-stm32.c | 259 +++++++++++++++++++++++---------------
 3 files changed, 155 insertions(+), 168 deletions(-)

-- 
2.7.4
