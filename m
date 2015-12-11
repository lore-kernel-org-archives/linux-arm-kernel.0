From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Dec 2015 18:01:34 +0000
Subject: [GIT PULL] arm64 fixes for 4.4-rc5
Message-ID: <20151211180132.GA10772@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thank you.

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52bb9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 82d340081b6f71237373d1452e3573a5a122794c:

  arm64: Improve error reporting on set_pte_at() checks (2015-12-11 15:44:24 +0000)

----------------------------------------------------------------
arm64 fixes:

- Update the linker script to use L1_CACHE_BYTES instead of hard-coded
  64. We recently changed L1_CACHE_BYTES to 128

- Improve race condition reporting on set_pte_at() and change the BUG to
  WARN_ONCE. With hardware update of the accessed/dirty state, we need
  to ensure that set_pte_at() does not inadvertently override hardware
  updated state. The patch also makes the checks ignore !pte_valid() new
  entries

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: update linker script to increased L1_CACHE_BYTES value

Catalin Marinas (1):
      arm64: Improve error reporting on set_pte_at() checks

 arch/arm64/include/asm/pgtable.h | 12 ++++++++----
 arch/arm64/kernel/vmlinux.lds.S  |  5 +++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
Catalin
