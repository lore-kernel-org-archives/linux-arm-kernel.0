From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:34 +0100
Subject: [PATCH 0/7] ARM: hw_breakpoint: fix reset sequence for debug arch v7.1
Message-ID: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches fixes the hw_breakpoint debug register reset sequence
for ARM debug architecture v7.1. This involves:

	- Probing of the save/restore registers on v7
	- Avoiding the use of DBGDSCRint.HDBGen, which is now UNKNOWN
	- Only attempt to enable monitor mode during boot, then check
	  whether it is still enabled during breakpoint validation
	- Some minor changes to remain compatible with v6 processors

All feedback welcome,

Will


Dietmar Eggemann (1):
  ARM: hw_breakpoint: use CRn as argument for debug reg accessor macros

Will Deacon (6):
  ARM: hw_breakpoint: only clear OS lock when implemented on v7
  ARM: hw_breakpoint: fix monitor mode detection with v7.1
  ARM: hw_breakpoint: fix ordering of debug register reset sequence
  ARM: hw_breakpoint: don't try to clear v6 debug registers during boot
  ARM: hw_breakpoint: make boot quieter without CPUID feature registers
  ARM: hw_breakpoint: check if monitor mode is enabled during
    validation

 arch/arm/include/asm/hw_breakpoint.h |    8 +-
 arch/arm/kernel/hw_breakpoint.c      |  146 ++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 72 deletions(-)

-- 
1.7.4.1
