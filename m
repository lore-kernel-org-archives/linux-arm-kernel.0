From: Catalin.Marinas@arm.com (Catalin Marinas)
Date: Fri, 31 May 2013 16:25:39 +0100
Subject: [GIT PULL] arm64 fixes for 3.10
Message-ID: <20130531152539.GE15551@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. Thanks.

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to 9955ac47f4ba1c95ecb6092aeaefb40a22e99268:

  arm64: don't kill the kernel on a bad esr from el0 (2013-05-31 16:04:51 +0100)

----------------------------------------------------------------
- Module compilation issues (symbol not exported).
- Plug a hole where user space can bring the kernel down.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Do not report user faults for handled signals

Chen Gang (1):
      arm64: kernel: compiling issue, need 'EXPORT_SYMBOL(clear_page)'

Mark Rutland (2):
      arm64: treat unhandled compat el0 traps as undef
      arm64: don't kill the kernel on a bad esr from el0

 arch/arm64/kernel/arm64ksyms.c |  1 +
 arch/arm64/kernel/entry.S      | 10 ++++++++++
 arch/arm64/kernel/traps.c      | 17 ++++++++++++-----
 arch/arm64/mm/fault.c          |  3 ++-
 4 files changed, 25 insertions(+), 6 deletions(-)
