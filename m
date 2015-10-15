From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 14:38:50 +0100
Subject: [GIT PULL] arm64: fixes for -rc6
Message-ID: <20151015133849.GE29301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a few more arm64 fixes for 4.3. Again, nothing too significant,
but worth having nonetheless. The MINSIGSTKSZ update is a bit grotty,
but the value we currently have is wrong (too small), so anybody using
that will have issues already. It has Arnd's ack for the asm-generic
change.

Please pull,

Will

--->8

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to eb93ce2cb7a85368c1f1733df35aab87152db56f:

  arm64: compat: wire up new syscalls (2015-10-14 13:51:41 +0100)

----------------------------------------------------------------
arm64 fixes for 4.3-rc6

- Fix module CFLAGS setting in workaround for erratum #843419
- Update MINSIGSTKSZ and SIGSTKSZ to match glibc
- Wire up some new compat syscalls

----------------------------------------------------------------
Manjeet Pawar (1):
      arm64: Fix MINSIGSTKSZ and SIGSTKSZ

Will Deacon (2):
      arm64: errata: use KBUILD_CFLAGS_MODULE for erratum #843419
      arm64: compat: wire up new syscalls

 arch/arm64/Makefile                  | 2 +-
 arch/arm64/include/asm/unistd.h      | 2 +-
 arch/arm64/include/asm/unistd32.h    | 9 +++++++++
 arch/arm64/include/uapi/asm/signal.h | 3 +++
 include/uapi/asm-generic/signal.h    | 2 ++
 5 files changed, 16 insertions(+), 2 deletions(-)
