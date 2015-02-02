From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Feb 2015 20:27:54 +0100
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4 (bis)
In-Reply-To: <CAOesGMhycUD4ZfQccjD=zzRB901u0YT1NqCuA7chNTnvgt7Fsg@mail.gmail.com>
References: <CAOesGMhycUD4ZfQccjD=zzRB901u0YT1NqCuA7chNTnvgt7Fsg@mail.gmail.com>
Message-ID: <1422905274-9303-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

As advised by Olof, here is a second attempt with this pull-request but this
time with the at91-3.19-fixes branch as a base. Here is how I did it:
- took v3.19-rc4
- merged my at91-3.19-fixes branch that is now in Linus' tree
- merged my at91-cleanup3 tag that you already have in your "soc" branch. These
  patches obviously depend on this tag.
- stacked the contend of this cleanup/soc pull-request.

I hope that it's what you had in mind.

Here is the older message, for the record:
"
This is a batch of cleanup/soc modifications that you may also stack on top of
your "soc" branch as the previous one.
It collects some more cleanup material and simplifies the AT91 boot code. Only
some little details remain before having a classical DT boot (without
additional
mapping of registers for instance). This part will be addressed in 3.21.

The switch to multi-platform is not included as it needs some patches in ASoC,
ata and arm-soc/next/drivers to be able to compile. I may send patches or a
pull-request that can be send to Linus late during the merge-window. Tell me
how you feel it can be done (or delayed to 3.21).

The conflict related to the rename of board-dt-sama5.c => sama5.c is solved in
this branch:
https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=arm-soc-for-next%2bat91-3.20-cleanup
"

Thanks, best regards,

The following changes since commit 980657d8cdff97343619cf2e3332b8307e9d07ea:

  Merge tag 'at91-cleanup3' into at91-3.20-soc (2015-02-02 10:59:34 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-soc4

for you to fetch changes up to ad3fc3e316891cbc4f33116a61c57c4a9b2a2518:

  ARM: at91/trivial: unify functions and machine names (2015-02-02 11:01:29 +0100)

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
 arch/arm/mach-at91/Kconfig                         | 92 ++++++----------------
 arch/arm/mach-at91/Makefile                        | 18 +----
 arch/arm/mach-at91/at91rm9200.c                    | 57 +++++++++-----
 arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} | 33 ++++----
 arch/arm/mach-at91/at91sam9260.c                   | 26 ------
 arch/arm/mach-at91/at91sam9261.c                   | 25 ------
 arch/arm/mach-at91/at91sam9263.c                   | 24 ------
 arch/arm/mach-at91/at91sam9g45.c                   | 24 ------
 arch/arm/mach-at91/at91sam9n12.c                   | 20 -----
 arch/arm/mach-at91/at91sam9rl.c                    | 25 ------
 arch/arm/mach-at91/at91sam9x5.c                    | 20 -----
 arch/arm/mach-at91/board-dt-rm9200.c               | 54 -------------
 arch/arm/mach-at91/generic.h                       | 19 ++---
 arch/arm/mach-at91/include/mach/cpu.h              | 52 ++++--------
 arch/arm/mach-at91/pm.c                            | 52 +++++++++++-
 arch/arm/mach-at91/{board-dt-sama5.c => sama5.c}   | 47 +++++++++--
 arch/arm/mach-at91/sama5d3.c                       | 29 -------
 arch/arm/mach-at91/sama5d4.c                       | 63 ---------------
 arch/arm/mach-at91/setup.c                         | 77 ------------------
 arch/arm/mach-at91/soc.h                           | 77 ------------------
 21 files changed, 193 insertions(+), 651 deletions(-)
 rename arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} (63%)
 delete mode 100644 arch/arm/mach-at91/at91sam9260.c
 delete mode 100644 arch/arm/mach-at91/at91sam9261.c
 delete mode 100644 arch/arm/mach-at91/at91sam9263.c
 delete mode 100644 arch/arm/mach-at91/at91sam9g45.c
 delete mode 100644 arch/arm/mach-at91/at91sam9n12.c
 delete mode 100644 arch/arm/mach-at91/at91sam9rl.c
 delete mode 100644 arch/arm/mach-at91/at91sam9x5.c
 delete mode 100644 arch/arm/mach-at91/board-dt-rm9200.c
 rename arch/arm/mach-at91/{board-dt-sama5.c => sama5.c} (54%)
 delete mode 100644 arch/arm/mach-at91/sama5d3.c
 delete mode 100644 arch/arm/mach-at91/sama5d4.c
 delete mode 100644 arch/arm/mach-at91/soc.h

-- 
Nicolas Ferre
