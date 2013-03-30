From: anton@enomsg.org (Anton Vorontsov)
Date: Sat, 30 Mar 2013 13:17:53 -0700
Subject: [GIT PULL] ARM: cns3xxx: v3.9-rc1_cns3xxx_fixes
Message-ID: <20130330201753.GA15370@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Please pull v3.9-rc1_cns3xxx_fixes tag from the cns3xxx git tree, the tag
includes Mac Lin's work to revive CNS3xxx booting:

 "Since commit 0536bdf33faf (ARM: move iotable mappings within the vmalloc
 region), [...] the pre-defined iotable mappings is not in the vmalloc
 region. [...] move the iotable mappings into the vmalloc region, and
 merge the MPCore private memory region (containing the SCU, the GIC and
 the TWD) as a single region."

Plus there is a small cosmetic fix, also from Mac Lin.

Thanks!


The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git tags/v3.9-rc1_cns3xxx_fixes

for you to fetch changes up to fc46d17c4a6b7aa2af11eb9275ed9791f2594ddf:

  ARM: cns3xxx: remove unused virtual address and iotable defines (2013-03-30 12:05:43 -0700)

----------------------------------------------------------------
Mac Lin (2):
      ARM: cns3xxx: fix mapping of private memory region
      ARM: cns3xxx: remove unused virtual address and iotable defines

 arch/arm/mach-cns3xxx/core.c                 | 26 +++-----------------------
 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h | 43 ++++++++-----------------------------------
 2 files changed, 11 insertions(+), 58 deletions(-)
