From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 14 Jan 2015 14:59:52 -0800
Subject: [PATCHv7 0/2] Better page protections for arm64
Message-ID: <1421276394-20402-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Happy New Year!

This is v7 of the series to add stricter page protections for arm64.
The goal is to have text be RO/X and everything else be RW/NX.
Most of the dependent patches have now merged. This series is based
on top of Ard's series[1] to have stable UEFI virtual mappings
for kexec.

This has been tested before and not much has changed so I've kept
Kees' Tested-by. I think this should be approaching a point
where it could be merged if it got a few more Tested-by but Catalin
had a few more questions about the approach so I don't think it will
make it this time.

[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314431.html

v7: Dropped the ioremap_exec addition because it's no longer needed
with Ard's series.

Laura Abbott (2):
  arm64: use fixmap for text patching when text is RO
  arm64: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  23 ++++
 arch/arm64/include/asm/cacheflush.h |   5 +
 arch/arm64/include/asm/fixmap.h     |   1 +
 arch/arm64/kernel/insn.c            |  50 ++++++++-
 arch/arm64/kernel/vmlinux.lds.S     |  17 ++-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 211 ++++++++++++++++++++++++++++++++----
 8 files changed, 283 insertions(+), 27 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
