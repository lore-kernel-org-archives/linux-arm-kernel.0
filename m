From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Mar 2017 13:59:55 +0000
Subject: [GIT PULL] arm64: fixes/statx for -rc4
Message-ID: <20170324135955.GE4990@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these changes for -rc4. There's a kaslr fix and then two patches to
update our native and compat syscall tables. Arnd asked that we take the
addition of statx to the asm-generic unistd.h via arm64, as he didn't have
anything queued in the asm-generic tree.

Thanks,

Will

--->8

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to afd0e5a876703accb95894f23317a13e2c49b523:

  arm64: kaslr: Fix up the kernel image alignment (2017-03-22 15:43:11 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix mapping of kernel image under certain kaslr offsets

- Hook up new statx syscall in asm-generic syscall table

- Update compat syscall table to match arch/arm/ (pkeys and statx)

----------------------------------------------------------------
Neeraj Upadhyay (1):
      arm64: kaslr: Fix up the kernel image alignment

Stafford Horne (1):
      generic syscalls: Wire up statx syscall

Will Deacon (1):
      arm64: compat: Update compat syscalls

 arch/arm64/include/asm/unistd.h   |  2 +-
 arch/arm64/include/asm/unistd32.h |  8 ++++++++
 arch/arm64/kernel/kaslr.c         | 10 +++++++---
 include/uapi/asm-generic/unistd.h |  4 +++-
 4 files changed, 19 insertions(+), 5 deletions(-)
