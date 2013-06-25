From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 25 Jun 2013 18:46:39 +0100
Subject: [PATCH 0/2] arm: add early_ioremap() support
Message-ID: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86 and ia64 have the early_ioremap()/early_iounmap() functions, which are
useful for supporting things like UEFI, ACPI and SMBIOS, where configuration
tables need to be parsed before proper memory management is available,
regardless of highmem status.

This patchset implements a restricted form of early_ioremap(), available
before paging_init() only. Like the x86 code on which it is based, it
(p)re-uses the fixmap regions for its virtual mapping range. Up to 7
simultaneous mappings of up to 128KB can be accommodated in the available
fixmap space.

Leif Lindholm (2):
  Documentation: arm: early_ioremap
  arm: add early_ioremap support

 Documentation/arm/00-INDEX          |    2 +
 Documentation/arm/early_ioremap.txt |   12 ++
 arch/arm/Kconfig                    |    7 +
 arch/arm/include/asm/fixmap.h       |   31 +++-
 arch/arm/include/asm/io.h           |   13 ++
 arch/arm/kernel/setup.c             |    3 +
 arch/arm/mm/Makefile                |    1 +
 arch/arm/mm/early_ioremap.c         |  273 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                   |    2 +
 9 files changed, 342 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm/early_ioremap.txt
 create mode 100644 arch/arm/mm/early_ioremap.c

-- 
1.7.10.4
