From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Sep 2017 18:09:27 +0100
Subject: [GIT PULL] arm64 fixes for 4.14-rc3
Message-ID: <20170929170924.sb52kp7fcvzwg2sh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 760bfb47c36a07741a089bf6a28e854ffbee7dc9:

  arm64: fault: Route pte translation faults via do_translation_fault (2017-09-29 16:47:40 +0100)

----------------------------------------------------------------
arm64 fixes:

- SPsel register initialisation on reset as the architecture defines its
  state as unknown

- Use READ_ONCE when dereferencing pmd_t pointers to avoid race
  conditions in page_vma_mapped_walk() (or fast GUP) with concurrent
  modifications of the page table

- Avoid invoking the mm fault handling code for kernel addresses (check
  against TASK_SIZE) which would otherwise result in calling
  might_sleep() in atomic context

----------------------------------------------------------------
Marc Zyngier (1):
      arm64: Make sure SPsel is always set

Will Deacon (2):
      arm64: mm: Use READ_ONCE when dereferencing pointer to pte table
      arm64: fault: Route pte translation faults via do_translation_fault

 arch/arm64/include/asm/pgtable.h | 2 +-
 arch/arm64/kernel/head.S         | 1 +
 arch/arm64/mm/fault.c            | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
Catalin
