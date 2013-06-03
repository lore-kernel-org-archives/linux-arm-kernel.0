From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 3 Jun 2013 21:57:40 +0200
Subject: [PATCH 0/3] dw_apb_timer: osc as sched_clock,
 clocks and clocksource_of support
Message-ID: <201306032157.40488.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is split off of my Rockchip support series from yesterday. It's now
a patch more than before, as the third patch enables the timer to be used
thru clocksource_of_init and moves picoxcell and socfpga to it.
 

Heiko Stuebner (3):
  clocksource: dw_apb_timer_of: use the clocksource as sched clock if
    necessary
  clocksource: dw_apb_timer_of: add clock-handling
  clocksource: dw_apb_timer_of: use clocksource_of_init

 Documentation/devicetree/bindings/rtc/dw-apb.txt |   19 +++++
 arch/arm/mach-picoxcell/Kconfig                  |    1 +
 arch/arm/mach-picoxcell/common.c                 |    2 -
 arch/arm/mach-socfpga/Kconfig                    |    1 +
 arch/arm/mach-socfpga/socfpga.c                  |    2 -
 drivers/clocksource/dw_apb_timer_of.c            |   95 ++++++++++++++-------
 include/linux/dw_apb_timer.h                     |    1 -
 7 files changed, 84 insertions(+), 37 deletions(-)

-- 
1.7.2.3
