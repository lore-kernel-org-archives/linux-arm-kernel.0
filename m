From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:14:54 +0800
Subject: [PATCH v2 0/4] Support the timer on RK3368 SoC
Message-ID: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer0~11 count up from zero to a programmed value and
generate an interrupt when the count reaches the programmed value.

TIMER0, TIMER1, TIMER2, Timer3, TIMER4 and TIMER5 are in the CPU
subsystem, using timer ch0 ~ ch5 respectively. The timer clock is 24MHz
OSC.

This series are found on RK3368 SoC, verified on rk3368 evb board.


Changes in v2:
- As Heiko/Daniel comments, let's split it into two patch.

Changes in v1:
- As Russell, Thomas, Daniel comments, let's replace NO_IRQ by '!irq'.
- As the Heiko comments, add the "rockchip,rk3368-timer" for timer.
  Although the 'rockchip,rk3288-timer' is working for RK3368, need to add the
  'rockchip,rk3368-timer' for the rk3368-spec timer in the future.

Caesar Wang (4):
  clocksource: rockchip: Make the driver more compatible
  clocksource: rockchip: trivial: Make the driver more readability
  arm64: Enable the timer on Rockchip architecture
  arm64: dts: rockchip: Add the needed timer for RK3368 SoC

 arch/arm64/Kconfig.platforms             |  1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi |  6 ++++++
 drivers/clocksource/rockchip_timer.c     | 27 ++++++++++++++-------------
 3 files changed, 21 insertions(+), 13 deletions(-)

-- 
1.9.1
