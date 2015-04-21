From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 12:59:41 +0200
Subject: [PATCH v2 0/2] ARM: honor Thumb bit when calling procinfo setup
 functions
Message-ID: <1429613983-22739-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This addresses the observed issue where we are inadvertently relying
on the procinfo setup function to use the same instruction set as the
call site instead of using the correct annotation (patch #1) and call
sequence (patch #2)

Changes since v1:
- do not use BSYM() but ENDPROC() to ensure the functions are correctly
  annotated
- use bx for all registers only when building a Thumb2 kernel

Ard Biesheuvel (2):
  ARM: use ENDPROC() to annotate all v7 asm setup functions
  ARM: Thumb2: use "bx reg" not "mov pc, reg" for all registers

 arch/arm/include/asm/assembler.h | 2 ++
 arch/arm/mm/proc-v7.S            | 9 +++++++++
 2 files changed, 11 insertions(+)

-- 
1.8.3.2
