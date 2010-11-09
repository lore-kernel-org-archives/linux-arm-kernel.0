From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue,  9 Nov 2010 11:06:09 +0200
Subject: [PATCH 0/4] ARM kdump fixes
Message-ID: <cover.1289292124.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Here is a set of patches which I hope allows us to build
crashkernels on ARM platforms. The first patch is needed so that we
can get rid of a compiler warning when building /proc/vmcore on
32-bit only platform. I think it should go via Andrew's tree (if
accepted, that is).

Patches 2 and 3 should replace following patches which are in
Russell's patch tracker:

	6121/1 allow passing an ELF64 header to elf_check_arch()
	-> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6121/1

	6123/1 kdump: add CONFIG_CRASH_DUMP Kconfig option
	-> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6123/1

The last patch converts reserve_crashkernel() to use memblock.

Thanks,
MW

Mika Westerberg (4):
  proc/vmcore: allow archs to override vmcore_elf_check_arch()
  ARM: provide zero vmcore_elf64_check_arch()
  ARM: add CONFIG_CRASH_DUMP to Kconfig
  ARM: memblock: convert reserve_crashkernel() to use memblock

 arch/arm/Kconfig           |   13 +++++++++++++
 arch/arm/include/asm/elf.h |    2 ++
 arch/arm/kernel/setup.c    |   21 +++++++--------------
 fs/proc/vmcore.c           |    2 +-
 include/linux/crash_dump.h |    9 ++++++++-
 5 files changed, 31 insertions(+), 16 deletions(-)

-- 
1.7.2.3
