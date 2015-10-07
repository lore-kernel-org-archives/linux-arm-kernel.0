From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Oct 2015 15:20:21 +0100
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20151007142021.GA12577@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.3-rc5. They address a couple
of issues found with RT, a broken initrd message in the console log and
a simple performance fix for some MMC workloads. Headlines in the tag.

Thanks,

Will

--->8

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 62c6c61adbc623cdacf74b8f29c278e539060c48:

  arm64: replace read_lock to rcu lock in call_break_hook (2015-10-06 19:10:28 +0100)

----------------------------------------------------------------
arm64 fixes for 4.3-rc5

- A couple of locking fixes for RT kernels
- Avoid printing bogus initrd warnings when initrd isn't present
- Performance fix for random mmap file readahead
- Typo fix

----------------------------------------------------------------
Mark Rutland (1):
      arm64: Don't relocate non-existent initrd

Mark Salyzyn (1):
      arm64: readahead: fault retry breaks mmap file read random detection

Yang Shi (3):
      arm64: debug: Fix typo in debug-monitors.c
      arm64: convert patch_lock to raw lock
      arm64: replace read_lock to rcu lock in call_break_hook

 arch/arm64/kernel/debug-monitors.c | 23 ++++++++++++-----------
 arch/arm64/kernel/insn.c           |  6 +++---
 arch/arm64/kernel/setup.c          |  2 ++
 arch/arm64/mm/fault.c              |  1 +
 4 files changed, 18 insertions(+), 14 deletions(-)
