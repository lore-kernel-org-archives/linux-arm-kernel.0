From: hechtb@gmail.com (Bastian Hecht)
Date: Fri,  8 Mar 2013 12:29:34 +0100
Subject: [PATCH v2 0/7] Enable CMT and TMU for DT
Message-ID: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the sequel to "[PATCH 0/3] Add OF support to CMT driver - bindings
discussion".

I moved to a general bindings definition for all timer devices and realized
it for CMT and TMU.

For MTU2 I unfortunately got no hardware and no datasheet, so the DT
implementation is postponed.
For TMU there is no DT version for the INTCS available, so this is untested. As
the code is so similar to the CMT driver, I decided to trust in the code
regardless.

In this version r8a7740 moves the CMT10 to DT too.

Based on Simon Hormans topic/all+next.
I can rebase patches 6 and 7 on topic/intc-of as well.

Cheers,

 Bastian

Bastian Hecht (7):
  ARM: shmobile: Define DT bindings for timer devices
  clocksource: sh_cmt: Add OF support
  clocksource: sh_tmu: Add OF support
  ARM: shmobile: sh73a0: Add timer DT names to clock list
  ARM: mach-shmobile: sh73a0: Setup the timer CMT10 using DT
  ARM: shmobile: r8a7740: Add DT name to clock list for CMT10
  ARM: mach-shmobile: r8a7740: Setup the timer CMT10 using DT

 .../devicetree/bindings/timer/renesas,timer.txt    |   45 ++++++++
 arch/arm/boot/dts/sh73a0.dtsi                      |   11 ++
 arch/arm/mach-shmobile/clock-r8a7740.c             |    1 +
 arch/arm/mach-shmobile/clock-sh73a0.c              |    3 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |   33 ------
 arch/arm/mach-shmobile/setup-sh73a0.c              |   32 ------
 drivers/clocksource/sh_cmt.c                       |  109 +++++++++++++++++---
 drivers/clocksource/sh_tmu.c                       |   94 +++++++++++++++--
 8 files changed, 239 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,timer.txt

-- 
1.7.9.5
