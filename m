From: robh@kernel.org (Rob Herring)
Date: Tue,  8 Dec 2015 14:44:14 -0600
Subject: [PATCH 0/4] ARM Versatile multi-platform support
Message-ID: <1449607458-16850-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd lit a fire under me to dust this off and get it merged. So here it 
is. The main change from prior version is I merged all the code to a 
single file. It's a bigger patch than I'd like, but I don't think trying 
to do it in multiple steps is worth it.

This is dependent on some solution for the default platform choice on 
!MMU builds (allnoconfig) as it can't be Versatile after this series. 
Arnd has some ideas on how to address that.

This is tested under QEMU. Linus previously tested this on actual h/w 
and had a problem with the display identification which needs 
investigation or agreement to worry about it if and when someone 
actually cares.

Rob


Rob Herring (4):
  ARM: versatile: add DT based PCI detection
  ARM: versatile: switch to DT only booting and remove legacy code
  ARM: versatile: merge mach code into a single file
  ARM: versatile: convert to multi-platform

 arch/arm/Kconfig                                  |  17 -
 arch/arm/configs/versatile_defconfig              |   2 +-
 arch/arm/mach-versatile/Kconfig                   |  41 +-
 arch/arm/mach-versatile/Makefile                  |   6 +-
 arch/arm/mach-versatile/Makefile.boot             |   4 -
 arch/arm/mach-versatile/core.c                    | 808 ----------------------
 arch/arm/mach-versatile/core.h                    |  46 --
 arch/arm/mach-versatile/include/mach/clkdev.h     |  16 -
 arch/arm/mach-versatile/include/mach/hardware.h   |  38 -
 arch/arm/mach-versatile/include/mach/irqs.h       | 134 ----
 arch/arm/mach-versatile/include/mach/platform.h   | 416 -----------
 arch/arm/mach-versatile/include/mach/uncompress.h |  45 --
 arch/arm/mach-versatile/pci.c                     | 368 ----------
 arch/arm/mach-versatile/versatile_ab.c            |  44 --
 arch/arm/mach-versatile/versatile_dt.c            | 376 +++++++++-
 arch/arm/mach-versatile/versatile_pb.c            |  91 ---
 drivers/clk/versatile/Kconfig                     |   4 +-
 17 files changed, 392 insertions(+), 2064 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/core.c
 delete mode 100644 arch/arm/mach-versatile/core.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/platform.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-versatile/pci.c
 delete mode 100644 arch/arm/mach-versatile/versatile_ab.c
 delete mode 100644 arch/arm/mach-versatile/versatile_pb.c

-- 
2.5.0
