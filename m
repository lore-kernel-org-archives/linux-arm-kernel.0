From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Sep 2013 14:05:46 +0100
Subject: [GIT PULL] arm64 fixes for 3.12
Message-ID: <20130920130538.GA32098@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 3.12-rc. Thanks.

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to 25804e6a96681d5d2142058948e218999e4f547c:

  arm64: Widen hwcap to be 64 bit (2013-09-20 09:56:07 +0100)

----------------------------------------------------------------
- Compat register fault reporting fix
- Documentation clarification on tagged pointers
- hwcap widened to 64-bit (user space already reading it as 64-bit)

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Make do_bad_area() function static
      arm64: Correctly report LR and SP for compat tasks

Steve Capper (1):
      arm64: Widen hwcap to be 64 bit

Will Deacon (1):
      arm64: documentation: tighten up tagged pointer documentation

 Documentation/arm64/tagged-pointers.txt | 14 +++++++-------
 arch/arm64/include/asm/hwcap.h          |  2 +-
 arch/arm64/kernel/process.c             | 21 ++++++++++++++++-----
 arch/arm64/kernel/setup.c               |  2 +-
 arch/arm64/mm/fault.c                   |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

-- 
Catalin
