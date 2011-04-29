From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 29 Apr 2011 00:08:26 -0400 (EDT)
Subject: Git pull request: ARM kprobes fixes
Message-ID: <alpine.LFD.2.00.1104282345420.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull the following:

	git://git.linaro.org/people/nico/linux kprobes

This is the comprehensive patch series from Jon Medhurst aka Tixy fixing 
various issues with the kprobes emulation code, plus one fix from Viktor 
Rosendahl.  This is based on v2.6.39-rc2 so not to conflict with the 
first of Viktor's patches already in mainline.  All those patches were 
posted on LAK and reviewed by me.

Obviously, this is not a small set of patches.  They are all fixes and 
pretty well isolated as shown by the diffstat though.  Up to you to push 
that to Linus during this -rc period, or wait for the next merge window.  
People aren't typically installing probes on the problematic 
instructions it seems, so this is probably not a matter of urgency.

Jon Medhurst (29):
      ARM: kprobes: Fix probing of conditionally executed instructions
      ARM: kprobes: Remove redundant condition checks from simulation routines
      ARM: kprobes: Fix emulation of CMP, CMN, TST and TEQ instructions.
      ARM: kprobes: Fix emulation of Data-processing (immediate) instructions
      ARM: kprobes: Reject probing MRS instructions which read SPSR
      ARM: kprobes: Fix emulation of MRS instruction
      ARM: kprobes: Reject probing of instructions which write to PC unpredictably.
      ARM: kprobes: Fix error in comment
      ARM: kprobes: Reject probing of undefined multiply instructions
      ARM: kprobes: Reject probing of STREX and LDREX instructions
      ARM: kprobes: Fix emulation of LDRH, STRH, LDRSB and LDRSH instructions
      ARM: kprobes: Reject probing of LDR/STR instructions which update PC unpredictably
      ARM: kprobes: Fix emulation of LDRD and STRD instructions
      ARM: kprobes: Reject probing of LDRB instructions which load PC
      ARM: kprobes: Add emulation of RBIT instruction
      ARM: kprobes: Reject probing of undefined media instructions
      ARM: kprobes: Fix emulation of SXTB16, SXTB, SXTH, UXTB16, UXTB and UXTH instructions
      ARM: kprobes: Fix emulation of SMUAD, SMUSD and SMMUL instructions
      ARM: kprobes: Fix emulation of USAD8 instructions
      ARM: kprobes: Reject probing of all coprocessor instructions
      ARM: kprobes: Consolidate stub decoding functions
      ARM: kprobes: Reject probing of SETEND instructions
      ARM: kprobes: Fix emulation of PLD instructions
      ARM: kprobes: Remove redundant code in space_1111
      ARM: kprobes: Reject probing of undefined data processing instructions
      ARM: kprobes: Add emulation of MOVW and MOVT instructions
      ARM: kprobes: Add emulation of SBFX, UBFX, BFI and BFC instructions
      ARM: kprobes: Add emulation of hint instructions like NOP and WFI
      ARM: kprobes: Tidy-up kprobes-decode.c

Viktor Rosendahl (1):
      kprobes/arm: Fix ldrd/strd emulation

 arch/arm/include/asm/kprobes.h   |    3 +
 arch/arm/kernel/kprobes-decode.c |  777 +++++++++++++++++++-------------
 arch/arm/kernel/kprobes.c        |    3 +-
 3 files changed, 462 insertions(+), 321 deletions(-)


Nicolas
