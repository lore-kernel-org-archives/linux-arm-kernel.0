From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jul 2012 17:01:06 +0100
Subject: [PATCH 0/2] Fix swap and page migration for LPAE
Message-ID: <1343318468-10412-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These two patches fix swapping and page migration for LPAE-enabled
kernels. Without these changes, we corrupt the offset stored in the file
pte when updating the page tables and may truncate the pfn when storing
it into a swp_entry_t.

I'll CC stable on the final patches.

All feedback welcome,

Will


Will Deacon (2):
  ARM: mm: avoid setting nG bit for user mappings that aren't present
  ARM: mm: use 5 bits for swapfile type encoding

 arch/arm/include/asm/pgtable.h |   40 +++++++++++++++++++++-------------------
 arch/arm/mm/flush.c            |    2 --
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
1.7.4.1
