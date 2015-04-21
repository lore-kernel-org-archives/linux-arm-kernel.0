From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 11:06:43 +0200
Subject: [PATCH 0/2] ARM: honor Thumb bit when calling procinfo setup functions
Message-ID: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This addresses the observed issue where we are inadvertently relying
on the procinfo setup function to use the same instruction set as the
call site instead of using the correct annotation (patch #1) and call
sequence (patch #2)

Ard Biesheuvel (2):
  ARM: include Thumb2 bit in PROCINFO setup function offset
  ARM: prefer "bx reg" over "mov pc, reg" for all registers

 arch/arm/include/asm/assembler.h | 4 ----
 arch/arm/mm/proc-v7.S            | 2 +-
 arch/arm/mm/proc-v7m.S           | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

-- 
1.8.3.2
