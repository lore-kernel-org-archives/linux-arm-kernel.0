From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jul 2015 18:12:30 +0100
Subject: [GIT PULL] arm64 fixes for 4.2-rc2
Message-ID: <20150710171228.GA2621@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ad2daa85bd50b7ff5c851b80a0b813bdc8d14f8e:

  arm64: entry32: remove pointless register assignment (2015-07-10 16:47:13 +0100)

----------------------------------------------------------------
arm64 fixes/clean-up:

- ACPI fix when checking the validity of the GICC MADT subtable
- handle debug exceptions in the el*_inv exception entries
- remove pointless register assignment in two compat syscall wrappers
- unnecessary include path
- defconfig update

----------------------------------------------------------------
Al Stone (2):
      ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
      ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY macro

Ard Biesheuvel (1):
      arm64: remove another unnecessary libfdt include path

Catalin Marinas (1):
      arm64: Keep the ARM64 Kconfig selects sorted

Mark Rutland (2):
      arm64: entry: handle debug exceptions in el*_inv
      arm64: entry32: remove pointless register assignment

Suneel Garapati (1):
      arm64: defconfig: Add Ceva ahci to the defconfig

 arch/arm64/Kconfig            | 2 +-
 arch/arm64/configs/defconfig  | 1 +
 arch/arm64/include/asm/acpi.h | 8 ++++++++
 arch/arm64/kernel/entry.S     | 4 ++--
 arch/arm64/kernel/entry32.S   | 2 --
 arch/arm64/kernel/smp.c       | 2 +-
 arch/arm64/mm/Makefile        | 2 --
 drivers/irqchip/irq-gic.c     | 2 +-
 8 files changed, 14 insertions(+), 9 deletions(-)

-- 
Catalin
