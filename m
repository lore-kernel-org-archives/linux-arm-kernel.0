From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 May 2015 16:48:28 +0100
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20150514154828.GF18984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.1. The main change is actually
a revert, after some (currently unused) branch patching code introduced
during the merge window was found to have some problems.

Cheers,

Will

--->8

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 4801ba338acad2e69e905e0c537e8ba2682c4e65:

  arm64: perf: fix memory leak when probing PMU PPIs (2015-05-12 16:50:21 +0100)

----------------------------------------------------------------
arm64 fixes:
- Fix potential memory leak in perf PMU probing
- BPF sign extension fix for 64-bit immediates
- Fix build failure with unusual configuration
- Revert unused and broken branch patching from alternative code

----------------------------------------------------------------
Jungseung Lee (1):
      arm64: mm: Fix build error with CONFIG_SPARSEMEM_VMEMMAP disabled

Will Deacon (2):
      Revert "arm64: alternative: Allow immediate branch as alternative instruction"
      arm64: perf: fix memory leak when probing PMU PPIs

Xi Wang (1):
      arm64: bpf: fix signedness bug in loading 64-bit immediate

 arch/arm64/kernel/alternative.c | 53 +----------------------------------------
 arch/arm64/kernel/perf_event.c  |  8 +++----
 arch/arm64/mm/dump.c            |  2 ++
 arch/arm64/net/bpf_jit_comp.c   |  2 +-
 4 files changed, 8 insertions(+), 57 deletions(-)
