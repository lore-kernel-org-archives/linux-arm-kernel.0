From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 27 Jan 2015 19:07:19 +0100
Subject: [PATCH 0/7] AT91 cleanup rework for 3.20/3.21
Message-ID: <cover.1422381280.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a little rework of the patches sent by Alexandre and some ideas coming
from Arnd.
I reworked the series so that it goes flawlessly on top of what I'd already
sent and doesn't need extra dependencies with drivers that are being cleaned-up
(at91_udc, pata_at91, etc.).

The multi-platform upcoming series from Alexandre has more dependencies. This
is why it is not stacked on top of this material. I plan to sent some kind of
preview soon so that it can be taken as a "late" pull-request if it's possible.

Thanks. Bye.

Alexandre Belloni (4):
  ARM: at91: at91rm9200: set idle and restart from
    rm9200_dt_device_init()
  ARM: at91: merge all SOC_AT91SAM9xxx
  ARM: at91: remove at91_boot_soc
  ARM: at91: remove at91_dt_initialize and machine init_early()

Nicolas Ferre (3):
  ARM: at91: move alternative initial mapping to board-dt-sama5.c
  ARM: at91: change board files into SoC files
  ARM: at91/trivial: unify functions and machine names

 arch/arm/configs/at91_dt_defconfig    | 10 +---
 arch/arm/mach-at91/Kconfig            | 92 ++++++++++------------------------
 arch/arm/mach-at91/Makefile           | 18 +------
 arch/arm/mach-at91/at91rm9200.c       | 57 ++++++++++++++-------
 arch/arm/mach-at91/at91sam9.c         | 87 ++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c      | 26 ----------
 arch/arm/mach-at91/at91sam9261.c      | 25 ----------
 arch/arm/mach-at91/at91sam9263.c      | 24 ---------
 arch/arm/mach-at91/at91sam9g45.c      | 24 ---------
 arch/arm/mach-at91/at91sam9n12.c      | 20 --------
 arch/arm/mach-at91/at91sam9rl.c       | 25 ----------
 arch/arm/mach-at91/at91sam9x5.c       | 20 --------
 arch/arm/mach-at91/board-dt-rm9200.c  | 54 --------------------
 arch/arm/mach-at91/board-dt-sam9.c    | 90 ---------------------------------
 arch/arm/mach-at91/board-dt-sama5.c   | 60 ----------------------
 arch/arm/mach-at91/generic.h          | 19 +++----
 arch/arm/mach-at91/include/mach/cpu.h | 52 ++++++--------------
 arch/arm/mach-at91/pm.c               | 52 ++++++++++++++++++--
 arch/arm/mach-at91/sama5.c            | 93 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sama5d3.c          | 29 -----------
 arch/arm/mach-at91/sama5d4.c          | 63 ------------------------
 arch/arm/mach-at91/setup.c            | 77 -----------------------------
 arch/arm/mach-at91/soc.h              | 77 -----------------------------
 23 files changed, 318 insertions(+), 776 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91sam9.c
 delete mode 100644 arch/arm/mach-at91/at91sam9260.c
 delete mode 100644 arch/arm/mach-at91/at91sam9261.c
 delete mode 100644 arch/arm/mach-at91/at91sam9263.c
 delete mode 100644 arch/arm/mach-at91/at91sam9g45.c
 delete mode 100644 arch/arm/mach-at91/at91sam9n12.c
 delete mode 100644 arch/arm/mach-at91/at91sam9rl.c
 delete mode 100644 arch/arm/mach-at91/at91sam9x5.c
 delete mode 100644 arch/arm/mach-at91/board-dt-rm9200.c
 delete mode 100644 arch/arm/mach-at91/board-dt-sam9.c
 delete mode 100644 arch/arm/mach-at91/board-dt-sama5.c
 create mode 100644 arch/arm/mach-at91/sama5.c
 delete mode 100644 arch/arm/mach-at91/sama5d3.c
 delete mode 100644 arch/arm/mach-at91/sama5d4.c
 delete mode 100644 arch/arm/mach-at91/soc.h

-- 
2.1.3
