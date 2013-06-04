From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  4 Jun 2013 16:03:16 +0200
Subject: [PATCH v2 0/2] ARM: PJ4B: fixes for 3.10-rc
Message-ID: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path set allows to fix some errata for PJ4B CPUs.

Without the first one, the Armada 370 based board can't boot anymore
since 3.10-rc1 . So this one really need to be applied on 3.10-rc.

It should be a good thing to apply the other one on the 3.10-rc, even
if we didn't observe get feedback from user who had a problem related
to these errata, it may happen.

Note that currently PJ4B is a symbol for 2 different CPUs:

- the one used in Armada 370 is a PJ4B
- the ones used in Armada XP are actually PJ4B-MP

So I planed to introduce a new symbol PJ4B-MP but for 3.11 as it is
not related to a critical fix. Awaiting these new symbols I made the
errata depends on ARMADA_370 in the Kconfig.

Russell,

I am aware that you didn't read the first version as you were on not
available. But this first version was usefull as we get many
interesting comments from Will Deacon. I addressed all of them when it
was possible.

Thanks,

Changelog:
V1 -> V2;
 - Fixed various coding style and typo issues
 - Replaced the "mcr p15, 0, r0, c7, c10, 4" by  "dsb"
 - Removed the fix for errata 4611 in discard_old_kernel_data function,
   as we don't use it

Lior Amsalem (2):
  ARM PJ4B: Add support for errata 4742
  ARM PJ4B: Add support for errata 4611

 arch/arm/Kconfig                | 22 ++++++++++++++++++++++
 arch/arm/include/asm/tlbflush.h | 22 ++++++++++++++++++++++
 arch/arm/mm/proc-macros.S       | 13 +++++++++++++
 arch/arm/mm/proc-v7.S           |  3 +++
 4 files changed, 60 insertions(+)

-- 
1.8.1.2
