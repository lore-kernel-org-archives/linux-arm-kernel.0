From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 10:22:27 +0200
Subject: [GIT PULL] AT91 reset and ramc rework, Cleanups
Message-ID: <20140717082227.GA31917@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Here is the last pull request with the various cleanups possibles now
that we have the poweroff and reset drivers in place.

Thanks,
Maxime

The following changes since commit cb17ad293f38b5b409739c15cbba9e628c6c8786:

  Merge branches 'at91/drivers-for-3.17' and 'at91/dt-for-3.17' into at91/cleanup-for-3.17 (2014-07-15 14:57:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/at91-cleanup-for-3.17

for you to fetch changes up to d732c88dceda47599f80132d7e885232dd189bac:

  ARM: at91: Remove rstc and shdwc headers (2014-07-15 14:58:39 +0200)

----------------------------------------------------------------
AT91 poweroff and reset cleanup

Remove the reset and poweroff code from mach-at91, and convert the various
users of the former code to the newly introduced mechanisms

This branch also merges the two first branches in order to preserve
bisectability.

----------------------------------------------------------------
Maxime Ripard (12):
      ARM: at91: setup: Switch to pr_fmt
      ARM: at91: Rework ramc mapping code
      ARM: at91: Remove the old-style reset probing
      ARM: at91/soc: Introduce register_devices callback
      ARM: at91: Probe the reset driver
      ARM: at91: Call at91_register_devices in the board files
      ARM: at91: Remove reset code from the machine code
      ARM: at91: Register the poweroff driver
      ARM: at91: Remove poweroff code
      ARM: at91/pm: Remove show_reset_status function
      ARM: at91: Remove rstc and shdwnc global base addresses
      ARM: at91: Remove rstc and shdwc headers

 .../devicetree/bindings/arm/atmel-at91.txt         |   7 --
 arch/arm/mach-at91/Kconfig                         |   8 --
 arch/arm/mach-at91/Makefile                        |   2 -
 arch/arm/mach-at91/at91_rstc.h                     |  53 ----------
 arch/arm/mach-at91/at91_shdwc.h                    |  50 ---------
 arch/arm/mach-at91/at91sam9260.c                   |  45 +++++++-
 arch/arm/mach-at91/at91sam9261.c                   |  45 +++++++-
 arch/arm/mach-at91/at91sam9263.c                   |  45 +++++++-
 arch/arm/mach-at91/at91sam9_alt_reset.S            |  40 --------
 arch/arm/mach-at91/at91sam9g45.c                   |  49 ++++++++-
 arch/arm/mach-at91/at91sam9g45_reset.S             |  45 --------
 arch/arm/mach-at91/at91sam9rl.c                    |  45 +++++++-
 arch/arm/mach-at91/board-afeb-9260v1.c             |   2 +
 arch/arm/mach-at91/board-cam60.c                   |   2 +
 arch/arm/mach-at91/board-cpu9krea.c                |   2 +
 arch/arm/mach-at91/board-flexibity.c               |   2 +
 arch/arm/mach-at91/board-sam9-l9260.c              |   2 +
 arch/arm/mach-at91/board-sam9260ek.c               |   3 +-
 arch/arm/mach-at91/board-sam9261ek.c               |   3 +-
 arch/arm/mach-at91/board-sam9263ek.c               |   3 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c            |   3 +-
 arch/arm/mach-at91/board-sam9rlek.c                |   3 +-
 arch/arm/mach-at91/board-snapper9260.c             |   2 +
 arch/arm/mach-at91/generic.h                       |  10 +-
 arch/arm/mach-at91/pm.c                            |  72 -------------
 arch/arm/mach-at91/setup.c                         | 113 +++++++--------------
 arch/arm/mach-at91/soc.h                           |   1 +
 27 files changed, 269 insertions(+), 388 deletions(-)
 delete mode 100644 arch/arm/mach-at91/at91_rstc.h
 delete mode 100644 arch/arm/mach-at91/at91_shdwc.h
 delete mode 100644 arch/arm/mach-at91/at91sam9_alt_reset.S
 delete mode 100644 arch/arm/mach-at91/at91sam9g45_reset.S

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/3e459a9b/attachment.sig>
