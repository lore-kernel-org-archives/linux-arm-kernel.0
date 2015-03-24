From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Mar 2015 18:16:54 +0000
Subject: [GIT PULL] arm64 fixes for 4.0-rc6
Message-ID: <20150324181408.GA2694@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f3eab7184ddcd4867cf42e3274ba24a66e1e093d:

  arm64: percpu: Make this_cpu accessors pre-empt safe (2015-03-24 18:02:55 +0000)

----------------------------------------------------------------
arm64 fixes:
- switch_mm() fix where init_mm.pgd ends up in the user TTBR0;
  swapper_pg_dir is not suitable for user mappings
- this_cpu accessors fix for preemption safety

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Use the reserved TTBR0 if context switching to the init_mm

Steve Capper (1):
      arm64: percpu: Make this_cpu accessors pre-empt safe

 arch/arm64/include/asm/cmpxchg.h     | 32 +++++++++++++++++++-------
 arch/arm64/include/asm/mmu_context.h |  9 ++++++++
 arch/arm64/include/asm/percpu.h      | 44 +++++++++++++++++++++++++++---------
 3 files changed, 66 insertions(+), 19 deletions(-)

-- 
Catalin
