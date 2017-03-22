From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:27 +0300
Subject: [PATCH v7 0/7] Implement clocksource for rockchip SoC using rockchip
 timer
Message-ID: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Daniel, Heiko.

Here is try 7 :) Could you please take a look into it?

rockchip_timer init code implemented using CLOCKEVENT_OF_DECLARE()
introduced in commit 0c8893c9095d ("clockevents: Add a clkevt-of
mechanism like clksrc-of")

There is change in the arch/arm/mach-rockchip/rockchip.c.

This series should be applied after the commit:
https://lkml.org/lkml/2017/3/22/426

As without the commit, you will get linker error ("clkevt-probe.c:63:
undefined reference to `__clkevt_of_table?")

Regards,
Alexander.


Alexander Kochetkov (6):
  dt-bindings: clarify compatible property for rockchip timers
  ARM: dts: rockchip: update compatible property for rk322x timer
  ARM: dts: rockchip: add clockevent attribute to rockchip timers
  clocksource/drivers/rockchip_timer: implement clocksource timer
  ARM: dts: rockchip: add timer entries to rk3188 SoC
  ARM: dts: rockchip: disable arm-global-timer for rk3188

Daniel Lezcano (1):
  clocksource/drivers/clksrc-evt-probe: Describe with the DT both the
    clocksource and the clockevent

 .../bindings/timer/rockchip,rk-timer.txt           |   12 +-
 Documentation/devicetree/bindings/timer/timer.txt  |   38 ++++
 arch/arm/boot/dts/rk3036.dtsi                      |    1 +
 arch/arm/boot/dts/rk3188.dtsi                      |   19 ++
 arch/arm/boot/dts/rk322x.dtsi                      |    3 +-
 arch/arm/boot/dts/rk3288.dtsi                      |    1 +
 arch/arm/mach-rockchip/rockchip.c                  |    2 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |    1 +
 drivers/clocksource/Kconfig                        |    2 +
 drivers/clocksource/clkevt-probe.c                 |    7 +
 drivers/clocksource/clksrc-probe.c                 |    7 +
 drivers/clocksource/rockchip_timer.c               |  215 ++++++++++++++------
 12 files changed, 241 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/timer.txt

-- 
1.7.9.5
