From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 11:15:13 +0100
Subject: [PATCH 0/2] arm64: traps.c fix + cleanup
Message-ID: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir pointed out that we have an issue with handling undefined
instruction when both PAN & UAO are in use, due to dump_instr always
using KERNEL_DS, regardles of the context of the undefined instruction.
Patch 1 addresses this.

While investigating, I noticed that our dump_mem usage looked a bit
suspicious. It turns out that we try to handle a case that doesn't
happen in practice, and do so inconsistently, but as the code is never
called this is not harmful in practice. Patch 2 removes the redundant
code.

Thanks,
Mark.

Mark Rutland (2):
  arm64: fix dump_instr when PAN and UAO are in use
  arm64: simplify dump_mem

 arch/arm64/kernel/traps.c | 57 ++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

-- 
1.9.1
