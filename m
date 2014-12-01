From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  2 Dec 2014 02:47:22 +0300
Subject: [PATCH v2 0/4] ARM: sa100: use pxa_timer clocksource driver
Message-ID: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a second iteration of this patch series. Changes since V1:
 - Added OSTIMER0 clock as requested by pxa_timer code.


Thomas has previously blessed that this patchset can go through arm-soc.

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.infradead.org/users/dbaryshkov/zaurus.git sa1100-clksrc

for you to fetch changes up to 261fcd132d124b3700ff0b61112fb1b853028901:

  ARM: sa1100: use pxa_timer clocksource driver (2014-12-02 02:42:28 +0300)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (4):
      clocksource: enable pxa_timer for SA-1100 platform
      ARM: sa1100: implement clk_get_rate
      ARM: sa1100: provide OSTIMER0 clock for pxa_timer
      ARM: sa1100: use pxa_timer clocksource driver

 arch/arm/mach-sa1100/Makefile  |   2 +-
 arch/arm/mach-sa1100/clock.c   |  17 ++++-
 arch/arm/mach-sa1100/generic.c |   6 ++
 arch/arm/mach-sa1100/time.c    | 139 -----------------------------------------
 drivers/clocksource/Kconfig    |   6 ++
 drivers/clocksource/Makefile   |   2 +-
 6 files changed, 30 insertions(+), 142 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/time.c
