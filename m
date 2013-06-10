From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:46:38 +0900
Subject: [PATCH 00/03] ARM: shmobile: Remove legacy memory bits
Message-ID: <20130610094638.20803.18484.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Remove legacy memory bits

[PATCH 01/03] ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
[PATCH 02/03] ARM: shmobile: Remove MEMORY_START/SIZE
[PATCH 03/03] ARM: shmobile: Remove mach/memory.h

Now when all users are gone this series removes the legacy memory code
and enables CONFIG_ARM_PATCH_PHYS_VIRT. Depends on the following code:

[PATCH v2] ARM: shmobile: uImage load address rework
[PATCH] ARM: shmobile: Rework sh7372 sleep code to use virt_to_phys()
[PATCH 00/06] ARM: shmobile: SMP virt_to_phys() conversion
[PATCH 00/02] ARM: shmobile: romImage update

The romImage series above still needs to be updated.

This is the final bit of code not to rely on CONFIG_MEMORY_START/SIZE
which in turn is one component that we need for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130607

 arch/arm/Kconfig                             |    2 -
 arch/arm/mach-shmobile/Kconfig               |   31 --------------------------
 arch/arm/mach-shmobile/include/mach/memory.h |    7 -----
 3 files changed, 1 insertion(+), 39 deletions(-)
