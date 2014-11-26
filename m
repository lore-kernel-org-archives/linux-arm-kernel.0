From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Nov 2014 16:14:26 +0100
Subject: [GIT PULL] at91: cleanup for 3.19 #3
Message-ID: <1417014866-14623-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

More legacy removal here. Nearly all "C board support" is now gone for AT91.

Thanks, best regards,

The following changes since commit f0a0a58e6f46c2dded813ee860b9cbd795b4e571:

  ARM: at91: move sdramc/ddrsdr header to include/soc/at91 (2014-11-13 12:03:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup3

for you to fetch changes up to 4fdfb67f24b64844ac110622bb51b2ee0f894492:

  ARM: at91/Kconfig: remove useless fbdev Kconfig options (2014-11-21 12:18:40 +0100)

----------------------------------------------------------------
Third batch of cleanup/SoC for 3.19:
- fixes following legacy board removal
- removal of legacy board support for at91sam9263, at91sam9260/at91sam9g20
  and at91sam9261/at91sam9g10 SoCs families. Please use DT now.
- removal of some now useless Kconfig options

----------------------------------------------------------------
Nicolas Ferre (7):
      ARM: at91/at91sam9g45: remove useless header file
      ARM: at91: remove at91sam9263 legacy board support
      ARM: at91: remove at91sam9260/at91sam9g20 legacy boards files
      ARM: at91: remove at91sam9260/at91sam9g20 legacy board support
      ARM: at91/Kconfig: remove unused config options
      ARM: at91: remove at91sam9261/at91sam9g10 legacy board support
      ARM: at91/Kconfig: remove useless fbdev Kconfig options

 arch/arm/configs/at91sam9260_9g20_defconfig |  145 ---
 arch/arm/configs/at91sam9261_9g10_defconfig |  147 ---
 arch/arm/configs/at91sam9263_defconfig      |  151 ---
 arch/arm/mach-at91/Kconfig.non_dt           |  172 ---
 arch/arm/mach-at91/Makefile                 |   29 -
 arch/arm/mach-at91/at91sam9260.c            |  397 -------
 arch/arm/mach-at91/at91sam9260_devices.c    | 1364 ------------------------
 arch/arm/mach-at91/at91sam9261.c            |  375 -------
 arch/arm/mach-at91/at91sam9261_devices.c    | 1098 -------------------
 arch/arm/mach-at91/at91sam9263.c            |  399 -------
 arch/arm/mach-at91/at91sam9263_devices.c    | 1538 ---------------------------
 arch/arm/mach-at91/at91sam9g45.c            |    1 -
 arch/arm/mach-at91/board-afeb-9260v1.c      |  223 ----
 arch/arm/mach-at91/board-cam60.c            |  199 ----
 arch/arm/mach-at91/board-cpu9krea.c         |  386 -------
 arch/arm/mach-at91/board-flexibity.c        |  171 ---
 arch/arm/mach-at91/board-gsia18s.c          |  585 ----------
 arch/arm/mach-at91/board-pcontrol-g20.c     |  228 ----
 arch/arm/mach-at91/board-sam9-l9260.c       |  230 ----
 arch/arm/mach-at91/board-sam9260ek.c        |  354 ------
 arch/arm/mach-at91/board-sam9261ek.c        |  623 -----------
 arch/arm/mach-at91/board-sam9263ek.c        |  493 ---------
 arch/arm/mach-at91/board-sam9g20ek.c        |  429 --------
 arch/arm/mach-at91/board-snapper9260.c      |  191 ----
 arch/arm/mach-at91/board-stamp9g20.c        |  294 -----
 arch/arm/mach-at91/stamp9g20.h              |    7 -
 drivers/misc/Kconfig                        |    2 +-
 drivers/rtc/Kconfig                         |    4 +-
 drivers/video/backlight/Kconfig             |    1 -
 drivers/video/fbdev/Kconfig                 |   17 -
 30 files changed, 2 insertions(+), 10251 deletions(-)
 delete mode 100644 arch/arm/configs/at91sam9260_9g20_defconfig
 delete mode 100644 arch/arm/configs/at91sam9261_9g10_defconfig
 delete mode 100644 arch/arm/configs/at91sam9263_defconfig
 delete mode 100644 arch/arm/mach-at91/at91sam9260_devices.c
 delete mode 100644 arch/arm/mach-at91/at91sam9261_devices.c
 delete mode 100644 arch/arm/mach-at91/at91sam9263_devices.c
 delete mode 100644 arch/arm/mach-at91/board-afeb-9260v1.c
 delete mode 100644 arch/arm/mach-at91/board-cam60.c
 delete mode 100644 arch/arm/mach-at91/board-cpu9krea.c
 delete mode 100644 arch/arm/mach-at91/board-flexibity.c
 delete mode 100644 arch/arm/mach-at91/board-gsia18s.c
 delete mode 100644 arch/arm/mach-at91/board-pcontrol-g20.c
 delete mode 100644 arch/arm/mach-at91/board-sam9-l9260.c
 delete mode 100644 arch/arm/mach-at91/board-sam9260ek.c
 delete mode 100644 arch/arm/mach-at91/board-sam9261ek.c
 delete mode 100644 arch/arm/mach-at91/board-sam9263ek.c
 delete mode 100644 arch/arm/mach-at91/board-sam9g20ek.c
 delete mode 100644 arch/arm/mach-at91/board-snapper9260.c
 delete mode 100644 arch/arm/mach-at91/board-stamp9g20.c
 delete mode 100644 arch/arm/mach-at91/stamp9g20.h

-- 
Nicolas Ferre
