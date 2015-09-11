From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Sep 2015 18:21:59 +0100
Subject: [PATCH 0/3] arm64 fixes following support for hardware AF/DBM
Message-ID: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that the recent patch for handling hardware updates to the AF
and dirty bits also breaks hardware without such feature because of
changes to how a pte is detected as dirty. The first patch fixes the
non-DBM hardware case. The second is fixes losing of the dirty
information for hardware DBM (as a consequence of the first patch,
otherwise a pte was pretty much always dirty anyway). The third patch is
a clean-up.

Catalin Marinas (2):
  arm64: Fix the pte_hw_dirty() check when AF/DBM is enabled
  arm64: Fix pte_modify() to preserve the hardware dirty information

Will Deacon (1):
  arm64: pgtable: use a single bit for PTE_WRITE regardless of DBM

 arch/arm64/include/asm/pgtable.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)
