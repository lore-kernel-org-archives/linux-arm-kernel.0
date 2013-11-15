From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Nov 2013 15:26:08 -0800
Subject: [PATCH 00/17] Convert ARM sched_clock users to sched_clock_register()
Message-ID: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Please consider picking up these simple conversion patches. They
were sent a few months back[1] but I didn't keep pushing them due
to the complex path to mainline that the core patches took. I've
picked up the acks and resent. Now that the core kernel changes have
landed in Linus' tree it's much easier to pull these changes in.

Stephen Boyd (17):
  ARM: timer-sp: Switch to sched_clock_register()
  ARM: clps711x: Switch to sched_clock_register()
  ARM: davinci: Switch to sched_clock_register()
  ARM: imx: Switch to sched_clock_register()
  ARM: integrator: Switch to sched_clock_register()
  ARM: IXP4xx: Switch to sched_clock_register()
  ARM: mmp: Switch to sched_clock_register()
  ARM: msm: Switch to sched_clock_register()
  ARM: OMAP1: Switch to sched_clock_register()
  ARM: OMAP2+: Switch to sched_clock_register()
  ARM: pxa: Switch to sched_clock_register()
  ARM: sa1100: Switch to sched_clock_register()
  ARM: u300: Switch to sched_clock_register()
  ARM: iop: Switch to sched_clock_register()
  ARM: OMAP: Switch to sched_clock_register()
  ARM: orion: Switch to sched_clock_register()
  ARM: versatile: Switch to sched_clock_register()

 arch/arm/common/timer-sp.c               | 4 ++--
 arch/arm/mach-clps711x/common.c          | 4 ++--
 arch/arm/mach-davinci/time.c             | 4 ++--
 arch/arm/mach-imx/time.c                 | 4 ++--
 arch/arm/mach-integrator/integrator_ap.c | 4 ++--
 arch/arm/mach-ixp4xx/common.c            | 4 ++--
 arch/arm/mach-mmp/time.c                 | 4 ++--
 arch/arm/mach-msm/timer.c                | 4 ++--
 arch/arm/mach-omap1/time.c               | 4 ++--
 arch/arm/mach-omap2/timer.c              | 4 ++--
 arch/arm/mach-pxa/time.c                 | 4 ++--
 arch/arm/mach-sa1100/time.c              | 4 ++--
 arch/arm/mach-u300/timer.c               | 4 ++--
 arch/arm/plat-iop/time.c                 | 4 ++--
 arch/arm/plat-omap/counter_32k.c         | 4 ++--
 arch/arm/plat-orion/time.c               | 4 ++--
 arch/arm/plat-versatile/sched-clock.c    | 4 ++--
 17 files changed, 34 insertions(+), 34 deletions(-)

[1] https://lkml.org/lkml/2013/7/31/631

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
