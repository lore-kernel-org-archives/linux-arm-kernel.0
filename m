From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 14:11:15 +0200
Subject: [GIT PULL] EP93xx cleanups for v4.3
Message-ID: <CACRpkdbEnK2Z2SW-QafisHv9hXv-bSdYx0dS7wtGh3oMDDcg=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

this is a long due pull request finally doing some EP93xx
cleanups, most prominently:

- Switch to GENERIC TIME

- Remove memory config options and rely on PATCH_PHYS_VIRT

I forgot the latter in the tag text, feel free to copy it
back in when pulling.

There is a series of defconfig changes adjacent to this that
I would consider merging into the same branch on top
of this, but I don't know how you want to handle it so they
will be served separately.

Please pull this in for v4.3!

Yours,
Linus Walleij


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/ep93xx-cleanup

for you to fetch changes up to 109965a32b67cf45951f4fcb92c8d606c0474619:

  ARM: ep93xx: simone: enable DMA on the SPI host (2015-07-17 11:50:23 +0200)

----------------------------------------------------------------
EP93xx cleanup and completing developments. This switches
EP93xx to generic time and brings in a few out-of-tree small
patches that were stalled for ages.

----------------------------------------------------------------
H Hartley Sweeten (3):
      ARM: ep93xx: remove memory configuration options
      ARM: ep93xx: vision_ep9307: enable DMA for SPI
      ARM: ep93xx: vision_ep9307: add audio support

Linus Walleij (7):
      ARM: ep93xx: move timer to its own file
      ARM: ep93xx: switch to GENERIC_CLOCKEVENTS
      ARM: ep93xx: use non-raw accessors for timer
      ARM: ep93xx: switch clockevent to timer 3
      ARM: ep93xx: update comment on timer usage
      ARM: ep93xx: toss the device ID into the entropy pool
      ARM: ep93xx: simone: enable DMA on the SPI host

 arch/arm/Kconfig                     |  11 ++-
 arch/arm/mach-ep93xx/Kconfig         |  54 --------------
 arch/arm/mach-ep93xx/Makefile        |   2 +-
 arch/arm/mach-ep93xx/Makefile.boot   |  15 +---
 arch/arm/mach-ep93xx/core.c          | 116 ++---------------------------
 arch/arm/mach-ep93xx/simone.c        |   1 +
 arch/arm/mach-ep93xx/timer-ep93xx.c  | 140 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/vision_ep9307.c |  61 ++++++++++++++-
 8 files changed, 213 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/timer-ep93xx.c
