From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 17:16:07 +0100
Subject: [RESEND PATCH 0/3] New algorithm for ASID allocation and rollover
Message-ID: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a resend of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114344.html

I received some minor comments in that thread, but nothing that warranted
any changes to the code. Due to the nature of these changes, I would
very much like to put these into -next for some exposure prior to merging.

Again, all feedback welcome.

Will


Will Deacon (3):
  ARM: mm: remove IPI broadcasting on ASID rollover
  ARM: mm: avoid taking ASID spinlock on fastpath
  ARM: mm: use bitmap operations when allocating new ASIDs

 arch/arm/include/asm/mmu.h         |   11 +--
 arch/arm/include/asm/mmu_context.h |   82 +--------------
 arch/arm/mm/context.c              |  207 +++++++++++++++++++-----------------
 3 files changed, 115 insertions(+), 185 deletions(-)

-- 
1.7.4.1
