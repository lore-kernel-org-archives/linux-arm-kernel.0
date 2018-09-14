From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Sep 2018 17:19:08 +0100
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20180914161908.GF6236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The trickle of arm64 fixes continues to come in. Nothing that's the end
of the world, but we've got a fix for PCI IO port accesses, an accidental
naked "asm goto" and a fix to the vmcoreinfo PT_NOTE merged this time
around which we'd like to get sorted before it becomes ABI.

Details in the tag, but please pull.

Thanks,

Will

--->8

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 500dd232449e7c07500e713dc6970aa713f8e4f1:

  asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO (2018-09-14 09:49:21 +0100)

----------------------------------------------------------------
arm64 fixes

- Fix ioport_map() mapping the wrong physical address for some I/O BARs

- Remove direct use of "asm goto", since some compilers don't like that

- Ensure kimage_voffset is always present in vmcoreinfo PT_NOTE

----------------------------------------------------------------
Andrew Murray (1):
      asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO

James Morse (1):
      arm64: kernel: arch_crash_save_vmcoreinfo() should depend on CONFIG_CRASH_CORE

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

 arch/arm64/include/asm/jump_label.h |  4 ++--
 arch/arm64/kernel/Makefile          |  1 +
 arch/arm64/kernel/crash_core.c      | 19 +++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c   | 11 -----------
 include/asm-generic/io.h            |  3 ++-
 5 files changed, 24 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_core.c
