From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Mar 2016 11:28:10 +0000
Subject: [GIT PULL] arm64: two late fixes for -final
Message-ID: <20160310112809.GC24623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I thought we were done for 4.5, but then the 64k-page chaps came crawling
out of the woodwork. *sigh*

The vmemmap fix I sent for -rc7 caused a regression with 64k pages and
sparsemem and at some point during the release cycle the new hugetlb
code using contiguous ptes started failing the libhugetlbfs tests with
64k pages enabled.

So here are a couple of patches that fix the vmemmap alignment and disable
the new hugetlb page sizes whilst a proper fix is being developed.

I'm not going to pass comment on the state of things this time around.
I've learned my lesson.

Please pull.

Will

--->8

The following changes since commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb:

  Linux 4.5-rc7 (2016-03-06 14:48:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ff7925848b50050732ac0401e0acf27e8b241d7b:

  arm64: hugetlb: partial revert of 66b3923a1a0f (2016-03-09 15:29:29 +0000)

----------------------------------------------------------------
arm64 fixes:

- Temporarily disable huge pages built using contiguous ptes
- Ensure vmemmap region is sufficiently aligned for sparsemem sections

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: account for sparsemem section alignment when choosing vmemmap offset

Will Deacon (1):
      arm64: hugetlb: partial revert of 66b3923a1a0f

 arch/arm64/include/asm/pgtable.h |  5 +++--
 arch/arm64/mm/hugetlbpage.c      | 14 --------------
 2 files changed, 3 insertions(+), 16 deletions(-)
