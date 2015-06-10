From: orca.chen@gmail.com (Min-Hua Chen)
Date: Thu, 11 Jun 2015 02:59:31 +0800
Subject: [PATCHv3 0/2] creating non-section aligned lowmem mappings
Message-ID: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found problems when I reserved non-section aligned memory blocks
by the device tree. The problem is that the memblock_set_current_limit()
point to the first section aligned memblock in the
first place (sanity_check_meminfo), but the memblock may be split
into non-section aligned memblocks because the memblock_reserve() calls
in arm_memblock_init().


*** BLURB HERE ***

Min-Hua Chen (2):
  arm: fix non-section-aligned low memory mapping
  arm: use max_lowmem_limit in find_limit()

 arch/arm/mm/init.c |    2 +-
 arch/arm/mm/mmu.c  |   48 ++++++++++++++----------------------------------
 2 files changed, 15 insertions(+), 35 deletions(-)

-- 
1.7.10.4
