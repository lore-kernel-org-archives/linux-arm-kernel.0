From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 06 Mar 2014 12:28:14 +0900
Subject: [PATCH 00/02] ARM: shmobile: Consolidate early delay setup code
Message-ID: <20140306032814.10814.2949.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Consolidate early delay setup code

[PATCH 01/02] ARM: shmobile: Add shared shmobile_init_delay()
[PATCH 02/02] ARM: shmobile: Use shmobile_init_delay() on r8a7791/Koelsch

Add code to retrieve early delay handling parameters from DT and
as example convert r8a7791 and Koelsch. The first patch should be
rather useful as-is but the second needs to be broken out into
SoC and board specific bits to fit board/soc pull request style.
Also, all mach-shmobile SoCs can be converted to use patch [1/1]

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc4-20140227
 and patch [2/2] also depends on
 [PATCH] ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in C

 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 -
 arch/arm/mach-shmobile/board-koelsch.c           |    2 -
 arch/arm/mach-shmobile/include/mach/common.h     |    1 
 arch/arm/mach-shmobile/include/mach/r8a7791.h    |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c           |    9 -------
 arch/arm/mach-shmobile/timer.c                   |   28 ++++++++++++++++++++++
 6 files changed, 32 insertions(+), 11 deletions(-)
