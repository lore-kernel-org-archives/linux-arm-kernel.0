From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:19:25 +0900
Subject: [PATCH 00/06] ARM: shmobile: SMP virt_to_phys() conversion
Message-ID: <20130610091925.18944.68117.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: SMP virt_to_phys() conversion

[PATCH 01/06] ARM: shmobile: Add SMP boot function and argument
[PATCH 02/06] ARM: shmobile: Add SCU boot function using argument
[PATCH 03/06] ARM: shmobile: r8a7779 SMP with SCU boot fn and args
[PATCH 04/06] ARM: shmobile: sh73a0 SMP with SCU boot fn and args
[PATCH 05/06] ARM: shmobile: EMEV2 SMP with SCU boot fn and args
[PATCH 06/06] ARM: shmobile: Remove old SCU boot code

This series replaces the inline virtual to physical address conversion code
in the mach-shmobile assembly files with C code making use of virt_to_phys().

This is one of several series of code that rework code not to rely on
CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130607

 arch/arm/mach-shmobile/headsmp-scu.S         |   35 ++++++++++----------------
 arch/arm/mach-shmobile/headsmp.S             |   13 +++++++--
 arch/arm/mach-shmobile/include/mach/common.h |    6 ++--
 arch/arm/mach-shmobile/smp-emev2.c           |    6 ++--
 arch/arm/mach-shmobile/smp-r8a7779.c         |    6 ++--
 arch/arm/mach-shmobile/smp-sh73a0.c          |    6 ++--
 6 files changed, 40 insertions(+), 32 deletions(-)
