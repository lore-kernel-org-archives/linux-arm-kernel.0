From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Dec 2013 17:50:40 +0000
Subject: [GIT PULL] arm64 fixes for 3.13
Message-ID: <20131206175032.GA30277@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to db4ed53cfe9f5a00355891a631d47dfa3fd4541f:

  arm64: mm: Fix PMD_SECT_PROT_NONE definition (2013-12-06 17:22:44 +0000)

----------------------------------------------------------------
- Page table fixes (PROT_NONE, shareability attribute, TLB invalidation)
- Secondary CPUs entry endianness fix
- Make NR_CPUS default to 8

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Fix memory shareability attribute for ioremap_wc/cache

Lorenzo Pieralisi (1):
      arm64: kernel: add code to set cpu boot mode to secondary_entry shim

Mark Rutland (1):
      arm64: ensure completion of TLB invalidatation

Rob Herring (1):
      arm64: make default NR_CPUS 8

Steve Capper (1):
      arm64: mm: Fix PMD_SECT_PROT_NONE definition

 arch/arm64/Kconfig                     | 3 +--
 arch/arm64/include/asm/io.h            | 2 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
 arch/arm64/kernel/head.S               | 3 ++-
 arch/arm64/mm/proc.S                   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
Catalin
