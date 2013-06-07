From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Jun 2013 12:04:18 +0200
Subject: [PATCH v4 0/2] ARM: PJ4B: fix for 3.10-rc
Message-ID: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path set allows to fix one errata for PJ4B CPUs.

Without this the Armada 370 based board can't boot anymore since
3.10-rc1. So this one really need to be applied on 3.10-rc.

As they were pending question for the second one, I preferred to keep
it apart awaiting the answers from the Marvell engineer.

Both of the patches of this series are needed to fix the issue. Indeed
if the CPU is not recognized as a PJ4B then the fix is not applied.

Thanks,

Changelog:
V1 -> V2;
 - Fixed various coding style and typo issues
 - Replaced the "mcr p15, 0, r0, c7, c10, 4" by  "dsb"

V2 -> v3:
 - As suggested by Russell, the first errata is now applied
   dynamically according to the processor type

v3->4
 - Moved the glob_equ maco into proc-macro.S
 - Split the patch in 2 parts, one for fixing the ID and mask of the
   PJ4B and the second for fixing the errata itself

Gregory CLEMENT (2):
  ARM: PJ4B: Fix the CPU ID and the mask associated to the PJ4B
  ARM PJ4B: Add support for errata 4742

 arch/arm/Kconfig                 | 13 +++++++++++++
 arch/arm/include/asm/glue-proc.h |  9 +++++++++
 arch/arm/mm/proc-macros.S        |  5 +++++
 arch/arm/mm/proc-v7.S            | 34 +++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 5 deletions(-)

-- 
1.8.1.2
