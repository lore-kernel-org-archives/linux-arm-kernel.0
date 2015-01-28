From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:07 +0100
Subject: [PATCH 00/15] ARM: simple randconfig fixes
Message-ID: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've sorted through my 300-patch series for randconfig and found
a number of patches that look basically ok, please review if you
find the time.

Most of them simply add Kconfig dependencies to prevent configurations
that are know to be broken, but others are more subtle. I have more
patches that are not included here and that I might get back to at
a later point.

Those are either things you rejected already, or that I would do
differently, or that fix problems I cannot currently reproduce.

	Arnd

Arnd Bergmann (15):
  ARM: always select IRQ_WORK on SMP
  ARM: KGDB does not build on BE32
  ARM: disable branch profiling in uncompressor
  ARM: fix LPAE build without ARM_PATCH_PHYS_VIRT
  ARM: no longer expose CPU_ARM7TDMI/CPU_ARM9TDMI
  ARM: disable UACCESS_WITH_MEMCPY and Kprobes for ARMv3
  ARM: disable some options on ARMv7-M
  ARM: add missing arch_irqs_disabled function
  ARM: disable CONFIG_PTDUMP on !MMU
  ARM: call printk conditonally on armv7-m
  ARM: HAVE_VIRT_CPU_ACCOUNTING_GEN requires cmpxchg64
  ARM: bpf: fix NOMMU build
  ARM: code patching only works on MMU
  ARM: do not use optimized do_div for ARMv3
  ARM: don't discard exit sections for spinlock debugging

 arch/arm/Kconfig                  | 16 +++++++++-------
 arch/arm/Kconfig.debug            |  1 +
 arch/arm/boot/compressed/Makefile |  2 ++
 arch/arm/include/asm/cacheflush.h |  7 +++++++
 arch/arm/include/asm/div64.h      |  2 +-
 arch/arm/include/asm/irqflags.h   |  5 +++++
 arch/arm/kernel/entry-v7m.S       |  2 ++
 arch/arm/kernel/vmlinux.lds.S     |  3 +--
 arch/arm/mm/Kconfig               |  4 ++--
 arch/arm/mm/mmu.c                 |  2 ++
 10 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.1.0.rc2
