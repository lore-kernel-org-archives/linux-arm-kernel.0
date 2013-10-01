From: cinifr@gmail.com (Fan Rong)
Date: Tue,  1 Oct 2013 23:42:22 +0800
Subject: [Add SMP support for Allwinner A20: PATCH V4 0/3] 
Message-ID: <1380642145-17295-1-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the version 4 patch. It use smp_prepare_cpus replacing early_init as cpuconfigure map init funcation caller and use sun7i replacing sunxi7i as funcation name and variable name.

Fan Rong (3):
  Add smp support for Allwinner A20(sunxi 7i).
  Add cpuconfig nodes in dts for smp configure.
  Add arch count timer node in dts for Allwinner A20(sunxi 7i).

 arch/arm/boot/dts/sun7i-a20.dtsi |  15 ++++++
 arch/arm/mach-sunxi/Makefile     |   2 +
 arch/arm/mach-sunxi/headsmp.S    |  18 +++++++
 arch/arm/mach-sunxi/platsmp.c    | 114 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c      |   3 ++
 5 files changed, 152 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
1.8.1.2
