From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:11 +0000
Subject: [PATCH 0/6] Random collection of hyp-boot fixes and updates
Message-ID: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been collecting random patches to the hyp-boot code, but it's
reached the point where much of it should go in as fixes for 3.8, CC'd
to stable. I've included the full series here, with the fixes marked
for stable.

I plan to send the fixes to Russell next week and then the three updates
later for 3.9.

All feedback welcome,

Will


Dave Martin (1):
  ARM: virt: Avoid bx instruction for compatibility with <=ARMv4

Marc Zyngier (2):
  ARM: virt: boot secondary CPUs through the right entry point
  ARM: virt: simplify __hyp_stub_install epilog

Russell King (1):
  ARM: virt: avoid clobbering lr when forcing svc mode

Will Deacon (2):
  ARM: virt: use PSR_N_BIT for detecting boot CPU mode mismatch
  ARM: virt: hide CONFIG_ARM_VIRT_EXT from user

 arch/arm/include/asm/assembler.h | 10 +++-------
 arch/arm/include/asm/virt.h      |  4 ++--
 arch/arm/kernel/head.S           |  2 +-
 arch/arm/kernel/hyp-stub.S       | 18 ++++++------------
 arch/arm/mm/Kconfig              | 10 +++-------
 5 files changed, 15 insertions(+), 29 deletions(-)

-- 
1.8.0
