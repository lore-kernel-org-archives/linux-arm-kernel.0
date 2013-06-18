From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jun 2013 11:29:40 +0200
Subject: [PATCH v5] ARM: PJ4B: fix for 3.10-rc
Message-ID: <1371547781-31097-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path allows to fix one errata for PJ4B CPUs.

Without this the Armada 370 based board can't boot anymore since
3.10-rc1. So this one really need to be applied on 3.10-rc.

As they were pending question for the second one, I preferred to keep
it apart awaiting the answers from the Marvell engineer.

As the patch fixing PJ4B ID have been merged in Russell King's git
tree. I only sent this one. I have tested a build with the
vexpress_defconfig and it no more failed.

Thanks,

Changelog:
V1 -> V2;
 - Fixed various coding style and typo issues
 - Replaced the "mcr p15, 0, r0, c7, c10, 4" by  "dsb"

V2 -> v3:
 - As suggested by Russell, the first errata is now applied
   dynamically according to the processor type

v3 -> v4:
 - Moved the glob_equ maco into proc-macro.S
 - Split the patch in 2 parts, one for fixing the ID and mask of the
   PJ4B and the second for fixing the errata itself

v4 -> v5:
- Added #ifdef all the places the new symbols conditionally defined
  are used.

Gregory CLEMENT (1):
  ARM PJ4B: Add support for errata 4742

 arch/arm/Kconfig                 | 13 +++++++++++++
 arch/arm/include/asm/glue-proc.h |  9 +++++++++
 arch/arm/mm/proc-macros.S        |  5 +++++
 arch/arm/mm/proc-v7.S            | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 58 insertions(+), 3 deletions(-)

-- 
1.8.1.2
