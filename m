From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 21 Jan 2015 17:36:04 -0800
Subject: [PATCHv8 0/2] Better page protections for arm64
Message-ID: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This should be the final version of the series to add stricter page
protections for arm64. The goal is to have text be RO/X and everything
else be RW/NX.

v8: Minor tweaks, adding acks

Laura Abbott (2):
  arm64: use fixmap for text patching
  arm64: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  23 ++++
 arch/arm64/include/asm/cacheflush.h |   5 +
 arch/arm64/include/asm/fixmap.h     |   1 +
 arch/arm64/kernel/insn.c            |  47 +++++++-
 arch/arm64/kernel/vmlinux.lds.S     |  17 ++-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 211 ++++++++++++++++++++++++++++++++----
 8 files changed, 280 insertions(+), 27 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
