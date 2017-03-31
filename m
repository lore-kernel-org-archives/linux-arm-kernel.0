From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Mar 2017 18:15:05 +0100
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20170331171505.GC4897@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these fixes for -rc5. The main thing is a fix for a NULL
dereference on systems that boot using spin-tables or the ACPI parking
protocol, but there are also a couple of trivial one-liners too.

We're currently debugging a page flags corruption issue under syzkaller,
but we're still some way from fixing that as it's proving fiddly to reproduce.

Thanks,

Will

--->8

The following changes since commit c02ed2e75ef4c74e41e421acb4ef1494671585e8:

  Linux 4.11-rc4 (2017-03-26 14:15:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 9b3403ae56e13cdf45252f34db196a8f5f52b6ac:

  arm64: drop non-existing vdso-offsets.h from .gitignore (2017-03-30 19:29:30 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix cpu_die() NULL dereference when booting secondary CPUs using spin-table

- Remove redundant #include

- Remove obsolete .gitignore entry

----------------------------------------------------------------
Mark Salter (1):
      arm64: fix NULL dereference in have_cpu_die()

Masahiro Yamada (1):
      arm64: drop non-existing vdso-offsets.h from .gitignore

Shaokun Zhang (1):
      arm64: remove redundant header file in current.h

 arch/arm64/include/asm/current.h  | 2 --
 arch/arm64/kernel/smp.c           | 2 +-
 arch/arm64/kernel/vdso/.gitignore | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)
