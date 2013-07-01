From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 14:41:06 +0900
Subject: [PATCH v2 00/07] ARM: shmobile: Remove unused auxdata and callbacks
Message-ID: <20130701054106.19319.46845.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Remove unused auxdata and callbacks

[PATCH 01/07] ARM: shmobile: Remove unused EMEV2 auxdata and callback
[PATCH 02/07] ARM: shmobile: Remove unused r8a7740 auxdata table
[PATCH 03/07] ARM: shmobile: Remove unused r8a7778 auxdata and callback
[PATCH 04/07] ARM: shmobile: Remove unused r8a7779 auxdata table
[PATCH 05/07] ARM: shmobile: Remove unused sh7372 auxdata table
[PATCH 06/07] ARM: shmobile: Remove unused sh73a0 auxdata table
[PATCH 07/07] ARM: shmobile: Remove redundant r8a7790 callback

Rework the mach-shmobile code to pass NULL to of_platform_populate()
instead of empty lists. This cleans up the code and reduces the
number of lines. New in V2: Remove init_machine() callbacks that
only call of_platform_populate(), thanks to Arnd for his advice!

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130701

 arch/arm/mach-shmobile/setup-emev2.c   |   10 ----------
 arch/arm/mach-shmobile/setup-r8a7740.c |    7 +------
 arch/arm/mach-shmobile/setup-r8a7778.c |   11 -----------
 arch/arm/mach-shmobile/setup-r8a7779.c |    7 +------
 arch/arm/mach-shmobile/setup-r8a7790.c |    5 -----
 arch/arm/mach-shmobile/setup-sh7372.c  |    7 +------
 arch/arm/mach-shmobile/setup-sh73a0.c  |    7 +------
 7 files changed, 4 insertions(+), 50 deletions(-)
