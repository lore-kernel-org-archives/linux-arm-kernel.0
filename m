From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2016 17:01:34 +0100
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20161028160134.GC1076@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these three arm64 fixes for -rc3. They're all pretty
straightforward: a couple of NUMA issues from the Huawei folks and a
thinko in __page_to_voff that seems to be benign, but is certainly
better off fixed.

Thanks,

Will

--->8

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3fa72fe9c614717d22ae75b84d45f41da65c10fe:

  arm64: mm: fix __page_to_voff definition (2016-10-26 18:22:42 +0100)

----------------------------------------------------------------
arm64 fixes:

- Couple of NUMA fixes
- Thinko in __page_to_voff

----------------------------------------------------------------
Hanjun Guo (1):
      arm64/numa: fix incorrect log for memory-less node

Neeraj Upadhyay (1):
      arm64: mm: fix __page_to_voff definition

Yisheng Xie (1):
      arm64/numa: fix pcpu_cpu_distance() to get correct CPU proximity

 arch/arm64/include/asm/memory.h | 2 +-
 arch/arm64/mm/numa.c            | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)
