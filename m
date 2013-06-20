From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Jun 2013 14:06:13 +0200
Subject: [PATCH v6] ARM: PJ4B: fix for 3.10-rc
Message-ID: <1371729974-17950-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This path allows to fix one errata for PJ4B CPUs.

Without this the Armada 370 based board can't boot anymore since
3.10-rc1. So this one really need to be applied on 3.10-rc.

As the patch fixing PJ4B ID have been merged in Russell King's git
tree. I only sent this one. I have tested a build with the
vexpress_defconfig and it no more failed.

I have also removed the acked-by from Nicolas Pitre and the
Reviewed-by from Will Deacon as even the change are small it is still
a new version.

Nicolas, Will, would you agree to give your acked-by and reviewed-by
on this new version?

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

v5 -> v6:
- Selected the fix by default if MACH_ARMADA_370 is selected, as
  without it there is no point to use Armada 370 base board.

Gregory CLEMENT (1):
  ARM PJ4B: Add support for errata 4742

 arch/arm/Kconfig                 | 14 ++++++++++++++
 arch/arm/include/asm/glue-proc.h |  9 +++++++++
 arch/arm/mm/proc-macros.S        |  5 +++++
 arch/arm/mm/proc-v7.S            | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 59 insertions(+), 3 deletions(-)

-- 
1.8.1.2
