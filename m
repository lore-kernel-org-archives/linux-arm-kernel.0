From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 20 Jun 2014 12:43:31 +0200
Subject: [PATCH 0/2] clocksource: add rockchip rk3288 specific armv7-timer
Message-ID: <70167479.zcs3JF0luJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The architected timer on Rockchip's RK3288 SoCs needs a bit of special handling
to start.

This seems to be similar to a recent discussion about the Exynos arch-timer
that also seems to need similar special handling (and mct timer running).

And, the arch-timer on recent Mediatek SoCs also uses this pattern of a
supplying timer below the arch-timer.

Therefore follow a suggestion from Arnd Bergmann and implement a separate
clocksource for it that does the setup and then initializes the arch-timer.

This series uses "of: Provide function to request and map memory" from
Matthias Brugger.

Heiko Stuebner (2):
  clocksource: arm_arch_timer: remove static from arch_timer_init
  clocksource: add rockchip-specific armv7-timer setup

 .../bindings/arm/rockchip/armv7-timer.txt          | 22 +++++++++
 drivers/clocksource/Makefile                       |  1 +
 drivers/clocksource/arm_arch_timer.c               |  2 +-
 drivers/clocksource/arm_arch_timer.h               |  7 +++
 drivers/clocksource/rockchip_timer.c               | 57 ++++++++++++++++++++++
 5 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/armv7-timer.txt
 create mode 100644 drivers/clocksource/arm_arch_timer.h
 create mode 100644 drivers/clocksource/rockchip_timer.c

-- 
1.9.0
