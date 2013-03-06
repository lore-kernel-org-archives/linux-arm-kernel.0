From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Mar 2013 09:22:14 +0900
Subject: [PATCH 00/04] ARM: shmobile: TWD update
Message-ID: <20130306002214.5430.43766.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: TWD update 
[PATCH 01/04] ARM: shmobile: Register DT TWD from timer.c 
[PATCH 02/04] ARM: shmobile: Add EMEV2 specific timer_init
[PATCH 03/04] ARM: shmobile: Add EMEV2 TWD support
[PATCH 04/04] ARM: shmobile: Remove r8a7779_register_twd() from common.

These patches are the first attempt to update the state of
mach-shmobile TWD support. Patch 01/04 adds shared mach-shmobile
code to allow TWD support via DT, patch 02/04 and 03/04 add TWD
support to EMEV2 and the KZM9D board. Finally patch 04/04 removes
unnecessary forward declaration.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against -next in renesas.git.

 arch/arm/boot/dts/emev2.dtsi                 |    6 ++++++
 arch/arm/mach-shmobile/board-kzm9d.c         |    2 +-
 arch/arm/mach-shmobile/clock-emev2.c         |    5 ++++-
 arch/arm/mach-shmobile/include/mach/common.h |    2 --
 arch/arm/mach-shmobile/include/mach/emev2.h  |    1 +
 arch/arm/mach-shmobile/setup-emev2.c         |   12 ++++++++++--
 arch/arm/mach-shmobile/smp-emev2.c           |    9 +++++++++
 arch/arm/mach-shmobile/timer.c               |    1 +
 8 files changed, 32 insertions(+), 6 deletions(-)
