From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Sep 2016 14:08:56 +0100
Subject: [GIT PULL] arm64 fixes for 4.8
Message-ID: <20160923130853.GA9414@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull a couple of last-minute arm64 fixes for 4.8. Thanks.

The following changes since commit 3be7988674ab33565700a37b210f502563d932e6:

  Linux 4.8-rc7 (2016-09-18 17:27:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 67787b68ec48c239d5ec12f9bf5adaf5c459517a:

  arm64: kgdb: handle read-only text / modules (2016-09-23 11:25:01 +0100)

----------------------------------------------------------------
- Fix secondary CPU to NUMA node assignment

- Fix kgdb breakpoint insertion in read-only text sections (when
  CONFIG_DEBUG_RODATA or CONFIG_DEBUG_SET_MODULE_RONX are enabled)

----------------------------------------------------------------
AKASHI Takahiro (1):
      arm64: kgdb: handle read-only text / modules

David Daney (1):
      arm64: Call numa_store_cpu_info() earlier.

 arch/arm64/include/asm/debug-monitors.h |  2 --
 arch/arm64/kernel/kgdb.c                | 36 ++++++++++++++++++++++-----------
 arch/arm64/kernel/smp.c                 | 14 ++++++-------
 3 files changed, 30 insertions(+), 22 deletions(-)

-- 
Catalin
