From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 20:17:41 +0100
Subject: [PATCH v2 0/7] Switch mach-at91 to multiplatform
Message-ID: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91 is now ready to switch to multiplatform. Do it and clean the remaining mach
includes.

Changes in v2:
 - moved the bool for ARCH_AT91 to the top
 - added a patch to remove the sama5d4 map_io


Alexandre Belloni (7):
  ARM: at91: switch to multiplatform
  ARM: at91: switch at91_dt_defconfig to multiplatform
  ARM: at91: remove unused headers
  ARM: at91: remove useless mach/cpu.h
  ARM: at91: sama5d4: remove useless map_io
  ARM: at91: remove SoC headers
  ARM: at91: remove hardware.h

 arch/arm/Kconfig                               |  13 --
 arch/arm/configs/at91_dt_defconfig             |   5 +-
 arch/arm/mach-at91/Kconfig                     | 117 ++++++-------
 arch/arm/mach-at91/Makefile                    |   2 +
 arch/arm/mach-at91/include/mach/at91_dbgu.h    |  63 -------
 arch/arm/mach-at91/include/mach/at91rm9200.h   | 103 ------------
 arch/arm/mach-at91/include/mach/at91sam9260.h  | 129 ---------------
 arch/arm/mach-at91/include/mach/at91sam9261.h  |  99 -----------
 arch/arm/mach-at91/include/mach/at91sam9263.h  | 117 -------------
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   2 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h  | 143 ----------------
 arch/arm/mach-at91/include/mach/at91sam9n12.h  |  65 --------
 arch/arm/mach-at91/include/mach/at91sam9rl.h   | 105 ------------
 arch/arm/mach-at91/include/mach/at91sam9x5.h   |  71 --------
 arch/arm/mach-at91/include/mach/cpu.h          | 216 ------------------------
 arch/arm/mach-at91/include/mach/hardware.h     | 134 ---------------
 arch/arm/mach-at91/include/mach/sama5d3.h      |  86 ----------
 arch/arm/mach-at91/include/mach/sama5d4.h      |  33 ----
 arch/arm/mach-at91/include/mach/uncompress.h   | 218 -------------------------
 arch/arm/mach-at91/pm.c                        |  12 +-
 arch/arm/mach-at91/pm_slowclock.S              |   1 -
 arch/arm/mach-at91/sama5.c                     |  35 ----
 22 files changed, 75 insertions(+), 1694 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbgu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 delete mode 100644 arch/arm/mach-at91/include/mach/cpu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d4.h
 delete mode 100644 arch/arm/mach-at91/include/mach/uncompress.h

-- 
2.1.0
