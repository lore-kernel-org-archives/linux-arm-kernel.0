From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jul 2016 15:49:00 +0100
Subject: [GIT PULL] arm64: fixes for -rc7
Message-ID: <20160708144859.GC6493@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

A couple of late fixes here, but one that we've been sitting on for a
few weeks while the details were worked out. Specifically, we now
enforce USER_DS on taking exceptions whilst in the kernel, which avoids
leaking kernel data to userspace through things like perf. The other
patch is an update to a workaround for a hardware erratum on some Cavium
SoCs.

Please pull,

Will

--->8

The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:

  Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 47c459beabe969c6751e2ea8d1f85c5fa1652d6c:

  arm64: Enable workaround for Cavium erratum 27456 on thunderx-81xx (2016-07-07 18:35:21 +0100)

----------------------------------------------------------------
arm64 fixes:

- Enforce USER_DS on exception entry from EL1
- Apply workaround for Cavium errata #27456 on Thunderx-81xx parts

----------------------------------------------------------------
Ganapatrao Kulkarni (1):
      arm64: Enable workaround for Cavium erratum 27456 on thunderx-81xx

James Morse (1):
      arm64: kernel: Save and restore UAO and addr_limit on exception entry

 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/include/asm/ptrace.h  |  2 ++
 arch/arm64/kernel/asm-offsets.c  |  1 +
 arch/arm64/kernel/cpu_errata.c   |  6 ++++++
 arch/arm64/kernel/entry.S        | 19 +++++++++++++++++--
 arch/arm64/mm/fault.c            |  3 ++-
 6 files changed, 30 insertions(+), 3 deletions(-)
