From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Oct 2015 18:38:48 +0100
Subject: [GIT PULL] arm64 fixes for 4.3
Message-ID: <20151002173844.GA24678@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ee556d00cf20012e889344a0adbbf809ab5015a3:

  arm64: ftrace: fix function_graph tracer panic (2015-10-02 11:12:56 +0100)

----------------------------------------------------------------
- Fix for transparent huge page change_protection() logic which was
  inadvertently changing a huge pmd page into a pmd table entry.
- Function graph tracer panic fix caused by the return_to_handler code
  corrupting the multi-regs function return value (composite types).

----------------------------------------------------------------
Li Bin (1):
      arm64: ftrace: fix function_graph tracer panic

Steve Capper (1):
      arm64: Fix THP protection change logic

 arch/arm64/include/asm/pgtable.h |  4 ++--
 arch/arm64/kernel/entry-ftrace.S | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
Catalin
