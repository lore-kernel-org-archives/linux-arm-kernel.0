From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 1 Oct 2014 19:20:03 +0200
Subject: [GIT PULL] at91: soc for 3.18 #3
Message-ID: <1412184003-13568-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another pull-request for 3.18 if you feel it can be stacked up now. This one is
*only* about removing code: the old !MMU at91x40 and 2 board files plus the whole
code in at91sam9g45 & at91sam9rl files for implementing this deprecated method:
as the EK were the only one to use this code, we remove quite a bunch of lines.
We can use these boards with DT right now.
As a matter of fact, the diffstat is pretty nice :-)

Thanks, best regards,

The following changes since commit 02037a9719fa89b7e5dc25cb22afc06c4eae406e:

  ARM: at91: document Atmel SMART compatibles (2014-09-22 14:42:40 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-soc3

for you to fetch changes up to f71529722cf8c209a4e71c1000f0f8b8e74f674f:

  ARM: at91: remove at91sam9rl legacy board support (2014-10-01 19:00:33 +0200)

----------------------------------------------------------------
Third batch of cleanup/SoC for 3.18:
- removal of old at91x40 !MMU ARM7TDMI support which was kind of rusty
- removal of board-sam9m10g45ek.c and board-sam9rlek.c from mach-at91
  and the code related to these board C files + defconfigs. Use DT for them now!

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: remove at91sam9rl legacy board support

Boris Brezillon (1):
      ARM: at91: remove at91sam9g45/9m10 legacy board support

Nicolas Ferre (1):
      ARM: at91: remove no-MMU at91x40 support

 arch/arm/configs/at91sam9g45_defconfig       |  172 ---
 arch/arm/configs/at91sam9rl_defconfig        |   83 --
 arch/arm/configs/at91x40_defconfig           |   48 -
 arch/arm/mach-at91/Kconfig                   |   25 +-
 arch/arm/mach-at91/Kconfig.non_dt            |   56 -
 arch/arm/mach-at91/Makefile                  |   12 -
 arch/arm/mach-at91/at91sam9g45.c             |  404 ------
 arch/arm/mach-at91/at91sam9g45_devices.c     | 1915 --------------------------
 arch/arm/mach-at91/at91sam9rl.c              |  333 -----
 arch/arm/mach-at91/at91sam9rl_devices.c      | 1260 -----------------
 arch/arm/mach-at91/at91x40.c                 |   93 --
 arch/arm/mach-at91/at91x40_time.c            |   85 --
 arch/arm/mach-at91/board-eb01.c              |   52 -
 arch/arm/mach-at91/board-sam9m10g45ek.c      |  526 -------
 arch/arm/mach-at91/board-sam9rlek.c          |  332 -----
 arch/arm/mach-at91/generic.h                 |    3 -
 arch/arm/mach-at91/include/mach/at91_dbgu.h  |    3 -
 arch/arm/mach-at91/include/mach/at91x40.h    |   60 -
 arch/arm/mach-at91/include/mach/cpu.h        |    1 -
 arch/arm/mach-at91/include/mach/hardware.h   |    4 -
 arch/arm/mach-at91/include/mach/uncompress.h |    7 -
 arch/arm/mach-at91/setup.c                   |    2 +-
 drivers/rtc/Kconfig                          |    2 +-
 23 files changed, 7 insertions(+), 5471 deletions(-)
 delete mode 100644 arch/arm/configs/at91sam9g45_defconfig
 delete mode 100644 arch/arm/configs/at91sam9rl_defconfig
 delete mode 100644 arch/arm/configs/at91x40_defconfig
 delete mode 100644 arch/arm/mach-at91/at91sam9g45_devices.c
 delete mode 100644 arch/arm/mach-at91/at91sam9rl_devices.c
 delete mode 100644 arch/arm/mach-at91/at91x40.c
 delete mode 100644 arch/arm/mach-at91/at91x40_time.c
 delete mode 100644 arch/arm/mach-at91/board-eb01.c
 delete mode 100644 arch/arm/mach-at91/board-sam9m10g45ek.c
 delete mode 100644 arch/arm/mach-at91/board-sam9rlek.c
 delete mode 100644 arch/arm/mach-at91/include/mach/at91x40.h

-- 
Nicolas Ferre
