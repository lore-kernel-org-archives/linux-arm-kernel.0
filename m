From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 05 Jan 2015 18:51:56 -0700
Subject: [PATCH 0/4] ARM64 compilation fixes for missing header includes
Message-ID: <20150106014554.27249.89116.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will & Catalin,

An ARM64 build here on next-20150105 breaks due to some missing
header file includes.  Looks like someone reorganized some
headers - although I have not tracked down what the root cause
is.  These patches get the kernel building again.  They are based
on the arm64 fixes/core branch.

The patches are also available via git at this signed tag:

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/tegra-pending tags/arm64-header-fixes-20150105


Compile-tested only.


- Paul

---

Paul Walmsley (4):
      arm64: fix missing asm/pgtable-hwdef.h include in asm/processor.h
      arm64: fix missing linux/bug.h include in asm/arch_timer.h
      arm64: fix missing asm/alternative.h include in kernel/module.c
      arm64: fix missing asm/io.h include in kernel/smp_spin_table.c


 arch/arm64/include/asm/arch_timer.h |    1 +
 arch/arm64/include/asm/processor.h  |    1 +
 arch/arm64/kernel/module.c          |    1 +
 arch/arm64/kernel/smp_spin_table.c  |    1 +
 4 files changed, 4 insertions(+)

arm64-header-file-fixes-v3.19-rc1
   text	   data	    bss	    dec	    hex	filename
7173728	 449984	 199064	7822776	 775db8	vmlinux
7173728	 449984	 199064	7822776	 775db8	vmlinux
