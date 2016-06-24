From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jun 2016 12:41:21 +0100
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20160624114121.GH29165@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a few more arm64 fixes, but things do finally appear to be
slowing down. The main fix is avoiding hibernation in a previously
unanticipated situation where we have CPUs parked in the kernel, but
it's all good stuff.

Cheers,

Will

--->8

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d74b4e4f1a6dbe27acce723e071c86a6ed154bf2:

  arm64: hibernate: Don't hibernate on systems with stuck CPUs (2016-06-22 15:48:10 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix icache/dcache sync for anonymous pages under migration
- Correct the ASID limit check
- Fix parallel builds of Image and Image.gz
- Refuse to hibernate when we have CPUs that we can't offline

----------------------------------------------------------------
James Morse (2):
      arm64: smp: Add function to determine if cpus are stuck in the kernel
      arm64: hibernate: Don't hibernate on systems with stuck CPUs

Jean-Philippe Brucker (1):
      arm64: update ASID limit

Masahiro Yamada (1):
      arm64: fix boot image dependencies to not generate invalid images

Shaokun Zhang (1):
      arm64: mm: remove page_mapping check in __sync_icache_dcache

 arch/arm64/Makefile           |  2 +-
 arch/arm64/include/asm/smp.h  | 12 ++++++++++++
 arch/arm64/kernel/hibernate.c |  6 ++++++
 arch/arm64/kernel/smp.c       | 18 ++++++++++++++++++
 arch/arm64/mm/context.c       |  9 ++++++---
 arch/arm64/mm/flush.c         |  4 ----
 6 files changed, 43 insertions(+), 8 deletions(-)
