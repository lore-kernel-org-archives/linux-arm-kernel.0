From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Sep 2015 15:51:09 +0800
Subject: [PATCH 0/3] Support the timer on RK3368 SoC
Message-ID: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer0~11 count up from zero to a programmed value and
generate an interrupt when the count reaches the programmed value.

TIMER0, TIMER1, TIMER2, Timer3, TIMER4 and TIMER5 are in the CPU
subsystem, using timer ch0 ~ ch5 respectively. The timer clock is 24MHz
OSC.

This series are found on RK3368 SoC, verified on rk3368 evb board.



Caesar Wang (3):
  clocksource: rockchip: Make the driver more readability and compatible
  arm64: Enable the timer on Rockchip architecture
  arm64: dts: rockchip: Add the needed timer for rk3368 SoC

 arch/arm64/Kconfig.platforms             |  1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi |  6 ++++++
 drivers/clocksource/rockchip_timer.c     | 29 +++++++++++++++--------------
 3 files changed, 22 insertions(+), 14 deletions(-)

-- 
1.9.1
