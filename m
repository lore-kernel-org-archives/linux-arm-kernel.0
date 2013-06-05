From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:10 +0900
Subject: [PATCH 00/06] ARM: shmobile: Per-board memory size fixups
Message-ID: <20130605073410.15758.37563.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Per-board memory size fixups

[PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
[PATCH 02/06] ARM: shmobile: AG5EVM memory config via ATAGS fixup
[PATCH 03/06] ARM: shmobile: AP4EVB memory config via ATAGS fixup
[PATCH 04/06] ARM: shmobile: Bonito memory config via ATAGS fixup
[PATCH 05/06] ARM: shmobile: Kota2 memory config via ATAGS fixup
[PATCH 06/06] ARM: shmobile: Marzen memory config via ATAGS fixup

This series adds memory size and base address fixups to
non-DT mach-shmobile boards. This way the ATAGS code in
arch/arm/kernel/atags_parse.c can be overriden on a per-
board basis without the need of any global MEM_SIZE or
PHYS_OFFSET settings.

This is one of several series of code that reworks code
not to rely on CONFIG_MEMORY_START/SIZE which in turn is
needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130604v2

 arch/arm/mach-shmobile/Kconfig               |    5 +++++
 arch/arm/mach-shmobile/board-ag5evm.c        |    4 ++++
 arch/arm/mach-shmobile/board-ap4evb.c        |    3 +++
 arch/arm/mach-shmobile/board-bonito.c        |    4 ++++
 arch/arm/mach-shmobile/board-kota2.c         |    4 ++++
 arch/arm/mach-shmobile/board-marzen.c        |    4 ++++
 arch/arm/mach-shmobile/include/mach/common.h |   13 +++++++++++++
 7 files changed, 37 insertions(+)
