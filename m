From: cinifr@gmail.com (Fan Rong)
Date: Sun, 22 Sep 2013 20:21:25 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 0/3] 
Message-ID: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the version3 patch. It delete platform.h and delete some code in platsmp.c that's not necessary. The patchs add smp support for Allwinner A20. It add cpu register node and arch timer node in dts for smp booting. SMP need arch timer as clocksource, It does use virtual counter timer and does not use physical counter timer, so bootloader ***must*** set CNTVOFF register for a20 before kernel booting. I have add support set CNTVOFF register for uboot, if you want to test it in a20 board, you need update uboot. Thanks for advice of Mark Rutland, Marc Zyngier, Ian Campbell, Russell King and Maxime Ripard.

Fan Rong (3):
  Add smp support for Allwinner A20(sunxi 7i).
  Add cpuconfig nodes in dts for smp configure.
  add arch count timer node in dts for Allwinner A20(sunxi 7i).

 arch/arm/boot/dts/sun7i-a20.dtsi | 19 ++++++++-
 arch/arm/mach-sunxi/Makefile     |  2 +
 arch/arm/mach-sunxi/headsmp.S    | 17 ++++++++
 arch/arm/mach-sunxi/platsmp.c    | 86 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c      | 31 +++++++++++++++
 5 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
1.8.1.2
