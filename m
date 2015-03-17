From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 11:11:11 +0100
Subject: [PATCH 0/3] more arm64 early boot stuff
Message-ID: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a bit like washing your car: you make one clean spot, and you have
to go and wash the whole thing ...

Anyway, this is another couple of proposed improvements for head.S

Patch #1 removes the unnecessary split and branch of the MMU enable code.

Patch #2 is based on the kernel relocation preparatory patch that I sent
yesterday, but reworked into something coherent, i.e., replace the open coded
virt_to_phys() calculations with absolute/relative symbol references, as
appropriate

Patch #3 adds code to warn when x1 .. x3 are not all zero as the boot protocol
stipulates. This is to ensure the 'future use' these are reserved for can ever
become a reality.

Ard Biesheuvel (3):
  arm64: merge __enable_mmu and __turn_mmu_on
  arm64: remove __calc_phys_offset
  arm64: enforce x1|x2|x3 == 0 upon kernel entry as per boot protocol

 arch/arm64/kernel/head.S  | 87 +++++++++++++++--------------------------------
 arch/arm64/kernel/setup.c | 13 +++++++
 2 files changed, 41 insertions(+), 59 deletions(-)

-- 
1.8.3.2
