From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Mar 2017 17:27:35 +0000
Subject: [GIT PULL] arm64 fixes for 4.11-rc3
Message-ID: <20170316172733.GA5128@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

In Will's absence I'm sending the arm64 fixes he queued for 4.11-rc3.
Thanks.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 0e4c0e6ea7d4a988a5ae2791c7cb5769b5256dad:

  arm64: kernel: Update kerneldoc for cpu_suspend() rename (2017-03-10 18:06:24 +0000)

----------------------------------------------------------------
arm64 fixes/cleanups:

- Fix arm64 kernel boot warning when DEBUG_VIRTUAL and KASAN are enabled

- Enable KEYS_COMPAT for keyctl compat support

- Use cpus_have_const_cap() for system_uses_ttbr0_pan() (slight
  performance improvement)

- Update kerneldoc for cpu_suspend() rename

- Remove the arm64-specific kprobe_exceptions_notify (weak generic
  variant defined)

----------------------------------------------------------------
Eric Biggers (1):
      arm64: support keyctl() system call in 32-bit mode

Geert Uytterhoeven (1):
      arm64: kernel: Update kerneldoc for cpu_suspend() rename

Mark Rutland (2):
      arm64: kasan: avoid bad virt_to_pfn()
      arm64: use const cap for system_uses_ttbr0_pan()

Naveen N. Rao (1):
      arm64: kprobes: remove kprobe_exceptions_notify

 arch/arm64/Kconfig                  | 4 ++++
 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/cpuidle.c         | 2 +-
 arch/arm64/kernel/probes/kprobes.c  | 6 ------
 arch/arm64/mm/kasan_init.c          | 2 +-
 5 files changed, 7 insertions(+), 9 deletions(-)

-- 
Catalin
