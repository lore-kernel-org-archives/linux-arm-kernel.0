From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Jan 2015 12:51:12 +0100
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4
Message-ID: <1422532272-32055-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a batch of cleanup/soc modifications that you may also stack on top of
your "soc" branch as the previous one.
It collects some more cleanup material and simplifies the AT91 boot code. Only
some little details remain before having a classical DT boot (without additional
mapping of registers for instance). This part will be addressed in 3.21.

The switch to multi-platform is not included as it needs some patches in ASoC,
ata and arm-soc/next/drivers to be able to compile. I may send patches or a
pull-request that can be send to Linus late during the merge-window. Tell me
how you feel it can be done (or delayed to 3.21).

The conflict related to the rename of board-dt-sama5.c => sama5.c is solved in
this branch:
https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=arm-soc-for-next%2bat91-3.20-cleanup

Thanks, best regards,

The following changes since commit 9726b6892beeaa736610370429a23a481d1b133e:

  ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage (2015-01-26 13:44:19 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup4

for you to fetch changes up to fa9df37f603459bf08a4f8fc99337874c677e2bf:

  ARM: at91/trivial: unify functions and machine names (2015-01-27 18:46:31 +0100)

----------------------------------------------------------------
Fourth cleanup/soc batch for 3.20:
- merge all the at91sam9 code and remove the empty SoC-specific files
- remove the at91_boot_soc that is now useless in a DT context
- move the sram code in PM code as it's now only used there
- some file + function name changes after this big cleanup

----------------------------------------------------------------
Alexandre Belloni (4):
      ARM: at91: at91rm9200: set idle and restart from rm9200_dt_device_init()
      ARM: at91: merge all SOC_AT91SAM9xxx
      ARM: at91: remove at91_boot_soc
      ARM: at91: remove at91_dt_initialize and machine init_early()

Nicolas Ferre (3):
      ARM: at91: move alternative initial mapping to board-dt-sama5.c
      ARM: at91: change board files into SoC files
      ARM: at91/trivial: unify functions and machine names

 arch/arm/configs/at91_dt_defconfig                 | 10 +--
 arch/arm/mach-at91/Kconfig                         | 92 ++++++---------------
 arch/arm/mach-at91/Makefile                        | 18 +----
 arch/arm/mach-at91/at91rm9200.c                    | 57 ++++++++-----
 arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} | 33 ++++----
 arch/arm/mach-at91/at91sam9260.c                   | 26 ------
 arch/arm/mach-at91/at91sam9261.c                   | 25 ------
 arch/arm/mach-at91/at91sam9263.c                   | 24 ------
 arch/arm/mach-at91/at91sam9g45.c                   | 24 ------
 arch/arm/mach-at91/at91sam9n12.c                   | 20 -----
 arch/arm/mach-at91/at91sam9rl.c                    | 25 ------
 arch/arm/mach-at91/at91sam9x5.c                    | 20 -----
 arch/arm/mach-at91/board-dt-rm9200.c               | 54 -------------
 arch/arm/mach-at91/board-dt-sama5.c                | 60 --------------
 arch/arm/mach-at91/generic.h                       | 19 ++---
 arch/arm/mach-at91/include/mach/cpu.h              | 52 ++++--------
 arch/arm/mach-at91/pm.c                            | 52 +++++++++++-
 arch/arm/mach-at91/sama5.c                         | 93 ++++++++++++++++++++++
 arch/arm/mach-at91/sama5d3.c                       | 29 -------
 arch/arm/mach-at91/sama5d4.c                       | 63 ---------------
 arch/arm/mach-at91/setup.c                         | 77 ------------------
 arch/arm/mach-at91/soc.h                           | 77 ------------------
 22 files changed, 246 insertions(+), 704 deletions(-)
 rename arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} (63%)
 delete mode 100644 arch/arm/mach-at91/at91sam9260.c
 delete mode 100644 arch/arm/mach-at91/at91sam9261.c
 delete mode 100644 arch/arm/mach-at91/at91sam9263.c
 delete mode 100644 arch/arm/mach-at91/at91sam9g45.c
 delete mode 100644 arch/arm/mach-at91/at91sam9n12.c
 delete mode 100644 arch/arm/mach-at91/at91sam9rl.c
 delete mode 100644 arch/arm/mach-at91/at91sam9x5.c
 delete mode 100644 arch/arm/mach-at91/board-dt-rm9200.c
 delete mode 100644 arch/arm/mach-at91/board-dt-sama5.c
 create mode 100644 arch/arm/mach-at91/sama5.c
 delete mode 100644 arch/arm/mach-at91/sama5d3.c
 delete mode 100644 arch/arm/mach-at91/sama5d4.c
 delete mode 100644 arch/arm/mach-at91/soc.h

-- 
Nicolas Ferre
