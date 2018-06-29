From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jun 2018 18:20:37 +0100
Subject: [GIT PULL] arm64 fixes for 4.18-rc3
Message-ID: <20180629172035.mmkauxlu7taulubu@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 24fe1b0efad4fcdd32ce46cffeab297f22581707:

  arm64: Remove unnecessary ISBs from set_{pte,pmd,pud} (2018-06-27 18:26:20 +0100)

----------------------------------------------------------------
arm64 fixes:

- The alternatives patching code uses flush_icache_range() which itself
  uses alternatives. Change the code to use an unpatched variant of
  cache maintenance

- Remove unnecessary ISBs from set_{pte,pmd,pud}

- perf: xgene_pmu: Fix IOB SLOW PMU parser error

----------------------------------------------------------------
Catalin Marinas (1):
      Merge branch 'perf/fixes' of git://git.kernel.org/.../will/linux

Hoan Tran (1):
      drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error

Will Deacon (2):
      arm64: Avoid flush_icache_range() in alternatives patching code
      arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}

 arch/arm64/include/asm/alternative.h |  7 ++++-
 arch/arm64/include/asm/pgtable.h     |  6 +----
 arch/arm64/kernel/alternative.c      | 51 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/module.c           |  5 ++--
 drivers/perf/xgene_pmu.c             |  2 +-
 5 files changed, 54 insertions(+), 17 deletions(-)

-- 
Catalin
