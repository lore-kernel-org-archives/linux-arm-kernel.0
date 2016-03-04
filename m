From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Mar 2016 20:06:25 +0000
Subject: [GIT PULL] arm64 fix for 4.5-rc7
Message-ID: <20160304200625.GE7886@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull this arm64 fix for -rc7. Without it, our struct page array
can overflow the vmemmap region on systems with a large PHYS_OFFSET.

Nothing else on the radar at the moment, so hopefully that's it for 4.5
from us.

Cheers,

Will

--->8

The following changes since commit 81f70ba233d5f660e1ea5fe23260ee323af5d53a:

  Linux 4.5-rc5 (2016-02-20 13:39:35 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to dfd55ad85e4a7fbaa82df12467515ac3c81e8a3e:

  arm64: vmemmap: use virtual projection of linear region (2016-02-26 17:59:04 +0000)

----------------------------------------------------------------
arm64 fix:

- Ensure struct page array fits within vmemmap area

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: vmemmap: use virtual projection of linear region

 arch/arm64/include/asm/pgtable.h | 7 ++++---
 arch/arm64/mm/init.c             | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)
