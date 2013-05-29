From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 May 2013 12:16:55 +0200
Subject: [PATCH 0/3] ARM: PJ4B: fixes for 3.10-rc
Message-ID: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path set allows to fix some errata for PJ4B CPus.

Without the first one, the Armada 370 based board can't boot anymore
since 3.10-rc1 and the commit "ARM: 7691/1: mm: kill unused
TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead" . So this one
really need to be appplied on 3.10-rc.

It should be a good thing to apply the others on the 3.10-rc, even we
didn't observe yet a problem related to these errata, they may happen.

Note that currently PJ4B is a symbol for 2 different CPU:

- the one used in Armada 370 is a PJ4B
- the ones used in Armada XP are actually PJ4B-MP

So I planed to introduce a new symbol PJ4B-MP but for 3.11 as it is
not related to a critical fix. Awaiting this new symbol I made the
errata depends on ARMADA_370 or ARMADA_XP in the Kconfig.

I will resent this series once Russell will come back next week, but I
would like to have a first feedback on this series.

Thanks,

Lior Amsalem (3):
  ARM PJ4B: Add support for errata 4742
  ARM PJ4B: Add support for errata 6124
  ARM PJ4B: Add support for errata 4611

 arch/arm/Kconfig                | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/tlbflush.h | 30 ++++++++++++++++++++++++++++++
 arch/arm/mm/cache-v7.S          |  8 ++++++++
 arch/arm/mm/copypage-v6.c       | 11 +++++++++++
 arch/arm/mm/proc-macros.S       | 13 +++++++++++++
 arch/arm/mm/proc-v7-2level.S    |  4 ++++
 arch/arm/mm/proc-v7-3level.S    |  4 ++++
 arch/arm/mm/proc-v7.S           |  7 +++++++
 8 files changed, 113 insertions(+)

-- 
1.8.1.2
