From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 22:46:28 +0900
Subject: [PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework
Message-ID: <20130213134628.12153.47120.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: SMP Cortex-A9 SCU rework

[PATCH 01/06] ARM: shmobile: Kill off sh73a0 scu_base_addr() function
[PATCH 02/06] ARM: shmobile: Kill off r8a7779 scu_base_addr() function
[PATCH 03/06] ARM: shmobile: Rework EMEV2 scu_base variable
[PATCH 04/06] ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
[PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
[PATCH 06/06] ARM: shmobile: Update EMEV2 to use scu_power_mode()

Rework the EMEV2 SMP code to make use of common scu_power_mode()
code together with a shared shmobile_scu_base and early SCU
setup code in headsmp-scu.S.

The patches are known to build for sh73a0, r8a7779 and EMEV2.

Note that the code has only been tested on the KZM9D/EMEV2 board,
and because of that changes to other boards have been kept at
a minimum. Next target after this is to update the r8a7779 SMP/SCU
code to make use of scu_base_addr(), but that requires hardware
access for testing.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 No known dependencies apart from previous SMP cleanup series
 "[PATCH 00/06] ARM: shmobile: Trivial SMP cleanups"
 Written against -next in renesas.git.

 arch/arm/mach-shmobile/Makefile              |    6 +-
 arch/arm/mach-shmobile/headsmp-scu.S         |   58 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/headsmp-sh73a0.S      |   50 ----------------------
 arch/arm/mach-shmobile/include/mach/common.h |    3 -
 arch/arm/mach-shmobile/smp-emev2.c           |   59 +++++++-------------------
 arch/arm/mach-shmobile/smp-r8a7779.c         |   19 +++-----
 arch/arm/mach-shmobile/smp-sh73a0.c          |   26 +++++------
 7 files changed, 98 insertions(+), 123 deletions(-)
