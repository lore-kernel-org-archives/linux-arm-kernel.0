From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 18:31:55 +0100
Subject: [GIT PULL] Cacheflush updates for 3.12
Message-ID: <20130812173155.GI25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

Please pull the following user-cacheflush updates for 3.12. This series both
improves performance of cacheflush-heavy workloads (i.e. browser benchmarks)
and also addresses a DoS issue on non-preemptible systems.

Will

--->8

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/cacheflush

for you to fetch changes up to d3065541b5a95e5d0ef37e0dc8ada80fd1fba963:

  ARM: cacheflush: don't bother rounding to nearest vma (2013-07-22 10:49:00 +0100)

----------------------------------------------------------------
Will Deacon (4):
      ARM: entry: allow ARM-private syscalls to be restarted
      ARM: cacheflush: split user cache-flushing into interruptible chunks
      ARM: cacheflush: don't round address range up to nearest page
      ARM: cacheflush: don't bother rounding to nearest vma

 arch/arm/include/asm/cacheflush.h  |  3 +--
 arch/arm/include/asm/thread_info.h | 11 +++++++++++
 arch/arm/kernel/entry-common.S     |  4 ++--
 arch/arm/kernel/traps.c            | 64 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 4 files changed, 63 insertions(+), 19 deletions(-)
