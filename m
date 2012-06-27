From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 27 Jun 2012 08:50:05 -0500
Subject: [RFC]Add initial support for Altera's SOCFPGA hardward
Message-ID: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following 2 patches are initial submissions for Altera's SOCFPGA on ARM platform. Advance and deep appreciation to those who will take the time to review and send comments.

[PATCH 1] Add defines for the SOCFPGA hardware
 MAINTAINERS                                        |    5
 arch/arm/Kconfig                                   |   19 +
 arch/arm/Makefile                                  |    1 
 arch/arm/mach-socfpga/Kconfig                      |   21 +
 arch/arm/mach-socfpga/Makefile                     |    8 
 arch/arm/mach-socfpga/Makefile.boot                |    3 
 arch/arm/mach-socfpga/clock.c                      |   50 +++
 arch/arm/mach-socfpga/common.c                     |  156 ++++++++++
 arch/arm/mach-socfpga/common.h                     |   38 ++
 arch/arm/mach-socfpga/dw_apb_timer.c               |  164 +++++++++++
 arch/arm/mach-socfpga/headsmp.S                    |   41 ++
 arch/arm/mach-socfpga/hotplug.c                    |  125 ++++++++
 arch/arm/mach-socfpga/include/mach/clock.h         |   11 
 arch/arm/mach-socfpga/include/mach/debug-macro.S   |   29 +
 arch/arm/mach-socfpga/include/mach/dw_apb_timer.h  |   38 ++
 arch/arm/mach-socfpga/include/mach/io.h            |   27 +
 arch/arm/mach-socfpga/include/mach/iomap.h         |   37 ++
 arch/arm/mach-socfpga/include/mach/irqs.h          |  305 +++++++++++++++++++++
 arch/arm/mach-socfpga/include/mach/memory.h        |   32 ++
 arch/arm/mach-socfpga/include/mach/smp.h           |   15 +
 arch/arm/mach-socfpga/include/mach/socfpga-timer.h |   27 +
 arch/arm/mach-socfpga/include/mach/system.h        |   31 ++
 arch/arm/mach-socfpga/include/mach/timex.h         |   19 +
 arch/arm/mach-socfpga/include/mach/uncompress.h    |   44 +++
 arch/arm/mach-socfpga/localtimer.c                 |   34 ++
 arch/arm/mach-socfpga/platsmp.c                    |  154 ++++++++++
 arch/arm/mm/Kconfig                                |    2 
 27 files changed, 1435 insertions(+), 1 deletion(-)

[PATCH 2] Add support for the SOCFPGA Cyclone V board
boot/dts/socfpga.dtsi                        |   73 ++++++++++++
 boot/dts/socfpga_cyclone5.dts                |   90 +++++++++++++++
 configs/socfpga_defconfig                    |   84 ++++++++++++++
 mach-socfpga/include/mach/clkdev.h           |   16 ++
 mach-socfpga/include/mach/socfpga_cyclone5.h |   83 +++++++++++++
 mach-socfpga/socfpga_cyclone5.c              |  161 +++++++++++++++++++++++++++
 tools/mach-types                             |    1
 7 files changed, 508 insertions(+)

Thanks,
Dinh 
