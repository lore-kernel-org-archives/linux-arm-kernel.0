From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Apr 2017 17:02:39 +0100
Subject: [GIT PULL] arm64: fixes for -rc6
Message-ID: <20170407160239.GS19342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these two arm64 fixes for -rc6. We've got a regression fix for
the signal raised when userspace makes an unsupported unaligned access and a
revert of the contiguous (hugepte) support for hugetlb, which has once again
been found to be broken. One day, maybe, we'll get it right.

Cheers,

Will

--->8

The following changes since commit a71c9a1c779f2499fb2afc0553e543f18aff6edf:

  Linux 4.11-rc5 (2017-04-02 17:23:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 6ae979ab39a368c18ceb0424bf824d172d6ab56f:

  Revert "Revert "arm64: hugetlb: partial revert of 66b3923a1a0f"" (2017-04-07 12:27:29 +0100)

----------------------------------------------------------------
arm64 fixes:

- Restore previous SIGBUS behaviour for unhandled unaligned user accesses

- Revert broken support for the contiguous bit in hugetlb (again...)

----------------------------------------------------------------
Victor Kamensky (1):
      arm64: mm: unaligned access by user-land should be received as SIGBUS

Will Deacon (1):
      Revert "Revert "arm64: hugetlb: partial revert of 66b3923a1a0f""

 arch/arm64/mm/fault.c       | 42 ++++++++++++++++++++++++------------------
 arch/arm64/mm/hugetlbpage.c | 14 --------------
 2 files changed, 24 insertions(+), 32 deletions(-)
