From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Aug 2011 13:12:02 +0200
Subject: [GIT PULL] u300 cleanups
Message-ID: <CACRpkdbJ0M_7+s+QkrBzAaNVdx_bNL4Pq7zu30T-yY0TkFu6wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

could you please pull the u300 cleanups to the arm-soc tree, so they get
some linux-next rotation?

These changes mainly drops the singlemem that was complicating the
memory.h file so much and switch to using patches physoffset by
default. It also removes an unused device declaration.

All patches have been on LAKML for a while.

The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:

  Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git u300

Linus Walleij (5):
      mach-u300: retire odd singlemem variant
      mach-u300: drop SEMI config option
      mach-u300: patch physoffset by default
      mach-u300: delete bogus memory mappings
      mach-u300: retire AVE device

 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-u300/Kconfig               |   46 -----------------
 arch/arm/mach-u300/Makefile.boot         |   17 +-----
 arch/arm/mach-u300/core.c                |   82 +-----------------------------
 arch/arm/mach-u300/include/mach/memory.h |   22 +-------
 arch/arm/mach-u300/u300.c                |   16 ------
 6 files changed, 7 insertions(+), 177 deletions(-)

Thanks,
Linus Walleij
