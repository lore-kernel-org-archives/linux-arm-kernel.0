From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  5 May 2016 10:43:58 +0100
Subject: [PATCH 0/4] arm64: pmd accessor fixes
Message-ID: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first two patches are follow-ups on the hardware AF/DBM support, so
they should go in as fixes (on top of current arm64 for-next/core
branch). The third patch is a minor clean-up while the last one
implements pmd_present() following recent discussions around
pmd_mknotpresent() (and it's also a cc stable).

Catalin Marinas (4):
  arm64: Fix typo in the pmdp_huge_get_and_clear() definition
  arm64: Implement pmdp_set_access_flags() for hardware AF/DBM
  arm64: Replace hard-coded values in the pmd/pud_bad() macros
  arm64: Ensure pmd_present() returns false after pmd_mknotpresent()

 arch/arm64/include/asm/pgtable-hwdef.h |  1 -
 arch/arm64/include/asm/pgtable.h       | 26 ++++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)
