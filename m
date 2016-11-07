From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2016 17:57:49 +0000
Subject: [GIT PULL] arm64 fix for -rc5
Message-ID: <20161107175749.GI20591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

It's been pretty quiet on the fixes side of things for us, but Artem
reported a build failure introduced during the merge window that appears
with older GCCs that do not support asm goto. The fix is bigger than I'd
like, but it's a mechnical move of some constants to break an include
dependency between atomic.h and jump_label.h when !HAVE_JUMP_LABEL.

Please pull,

Will

--->8

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 272d01bd790fdf3f1b16372fe28136e27756756f:

  arm64: Fix circular include of asm/lse.h through linux/jump_label.h (2016-11-05 20:59:06 +0000)

----------------------------------------------------------------
arm64 fix:

- Fix build failure on compilers without asm goto

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Fix circular include of asm/lse.h through linux/jump_label.h

 arch/arm64/include/asm/alternative.h |  2 +-
 arch/arm64/include/asm/cpucaps.h     | 40 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h  | 20 +-----------------
 arch/arm64/include/asm/lse.h         |  1 -
 4 files changed, 42 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpucaps.h
