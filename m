From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:34:18 +0200
Subject: [PATCH 0/3] new ARM-soc warning fixes
Message-ID: <1349796861-31164-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here are three more fixes that I'd like to merge through the arm-soc
as time permits. All of them should be completely harmless and they
only fix harmless gcc warnings.

I don't know what your plans are for sending the next fixes branch.
I've uploaded these into a new "fixes2" branch on top of the patches
that are already in "fixes". We can either send them all together,
or you send the ones that are already queued first and these ones
with the next batch. Feel free to rebase if necessary.

	Arnd

Arnd Bergmann (3):
  ARM: shmobile: mark shmobile_init_late as __init
  ARM: assabet: fix bogus warning in get_assabet_scr (again)
  ARM: integrator: use __iomem pointers for MMIO, part 2

 arch/arm/mach-integrator/include/mach/cm.h       |    2 +-
 arch/arm/mach-integrator/include/mach/platform.h |    6 +++---
 arch/arm/mach-integrator/integrator_ap.c         |    2 +-
 arch/arm/mach-integrator/integrator_cp.c         |    4 ++--
 arch/arm/mach-sa1100/assabet.c                   |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h     |    2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.7.10

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Simon Horman <horms@verge.net.au>
