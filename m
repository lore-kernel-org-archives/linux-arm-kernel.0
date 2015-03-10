From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 16:39:37 +0100
Subject: [PATCH v4 0/5] arm64: head.S cleanup
Message-ID: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This some janitorial work on head.S, just stuff I noticed when making
changes to it for other reasons.

Changes since v3:
- added similar patch for secondary_holding_pen_release
- fixed bug in patch #1 (ldr_l)

Changes since v2:
- added separate patch to add macros for adrp/add, adrp/ldr and adrp/str
- added R-b's

Ard Biesheuvel (5):
  arm64: add macros for common adrp usages
  arm64: remove processor_id
  arm64: remove __switch_data object from head.S
  arm64: remove __lookup_processor_type_data object from head.S
  arm64: use PC-relative reference for secondary_holding_pen_release

 arch/arm64/include/asm/assembler.h | 29 ++++++++++++++++++
 arch/arm64/kernel/head.S           | 61 ++++++++------------------------------
 arch/arm64/kernel/setup.c          |  3 --
 3 files changed, 41 insertions(+), 52 deletions(-)

-- 
1.8.3.2
