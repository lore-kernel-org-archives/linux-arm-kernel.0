From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 17 Apr 2014 17:47:00 -0700
Subject: [PATCH 0/3] Page protections for arm64
Message-ID: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are a couple of semi-related patches to set memory on arm64 to something
other than read/write/execute everywhere. The CONFIG_DEBUG_SET_MODULE_RONX is
actually v2 of the previous patch[1] but it seemed reasonable to put this with
the other work to map regular memory with better protections. The direction
for the arm64 work is roughly based on arm.

Thanks,
Laura


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/238246.html

Laura Abbott (3):
  arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
  arm64: Treat handle_arch_irq as a function pointer
  arm64: WIP: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  21 +++++
 arch/arm64/include/asm/cacheflush.h |   4 +
 arch/arm64/kernel/entry.S           |   4 +-
 arch/arm64/mm/Makefile              |   2 +-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 173 ++++++++++++++++++++++++++++++++----
 arch/arm64/mm/pageattr.c            | 120 +++++++++++++++++++++++++
 8 files changed, 309 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/mm/pageattr.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
