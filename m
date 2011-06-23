From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jun 2011 13:08:32 +0200
Subject: [GIT PULL] U300 and Ux500 patches for the arm-soc tree
In-Reply-To: <BANLkTik5HgtT5vFhxfODh3_G2zJ9c1YKmQ@mail.gmail.com>
References: <BANLkTik5HgtT5vFhxfODh3_G2zJ9c1YKmQ@mail.gmail.com>
Message-ID: <BANLkTinAMk1uiQ8A6VyzhgNXmMOLRT2xBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> These are a number of trivial-and-simple patches that have been reviewed on
> the LAKML mailing list. They are independent patches that are mostly
> self-descriptive.

Not much seems to happen in the arm-soc tree so I'm reiterating the pull
request, putting last weeks patches for section misses in the compilation
and the Snowball support patch set redux on top of the stuff previously
included:

The following changes since commit 56299378726d5f2ba8d3c8cbbd13cb280ba45e4f:

  Linux 3.0-rc4 (2011-06-20 20:25:46 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
for-arnd

[Mirrors seem slow, try the ssh:// to the server to get the latest branch
if you need it immediately, it'll be there in a few hours I guess]

Linus Walleij (8):
      mach-ux500: add HREFv60 Kconfig option
      mach-ux500: fix HREFv60 regression
      mach-ux500: correct MMC/SDI parameters
      mach-ux500: activate USB in the U8500 defconfig
      mach-ux500: complete regulator constraints for MOP500 board
      mach-u300: cleanup clockevent code
      mach-u300: set apropriate FIFO trigger levels
      mach-ux500: register a clock for the SMP TWD

Mathieu J. Poirier (3):
      mach-ux500: setting proper uart for snowball
      mach-ux500: Add SDI support for snowball board
      mach-ux500: Kconfig for snowball board

Mattias Wallin (1):
      mach-ux500: iomap PRCMU TCDM memory

Robert Marklund (4):
      mach-x500: fix SECTION warnings in uib
      mach-ux500: add basic support for snowball board
      mach-ux500: Add pin configuration for snowball board
      mach-ux500: add configs for snowball board

 arch/arm/configs/u8500_defconfig              |   32 ++++--
 arch/arm/mach-u300/spi.c                      |    4 +-
 arch/arm/mach-u300/timer.c                    |   33 ++----
 arch/arm/mach-ux500/Kconfig                   |   15 +++-
 arch/arm/mach-ux500/board-mop500-pins.c       |   43 +++++++
 arch/arm/mach-ux500/board-mop500-regulators.c |    9 ++-
 arch/arm/mach-ux500/board-mop500-sdi.c        |   61 +++++++---
 arch/arm/mach-ux500/board-mop500-uib.c        |    2 +-
 arch/arm/mach-ux500/board-mop500.c            |  154 +++++++++++++++++++++++--
 arch/arm/mach-ux500/board-mop500.h            |    5 +
 arch/arm/mach-ux500/clock.c                   |   48 ++++++++
 arch/arm/mach-ux500/cpu-db5500.c              |    1 +
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 +-
 13 files changed, 350 insertions(+), 60 deletions(-)

Thanks,
Linus Walleij
