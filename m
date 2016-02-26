From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 17:57:12 +0100
Subject: [PATCH v2 0/2] vmemmap fix for bug introduced by extending VA range
Message-ID: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to patch [1] (part of [2]) where I fixed an issue that I
identified related to commit dd006da21646 ("arm64: mm: increase VA range of
identity map").

Patch #1 fixes the issue in a way that should be compatible with v4.5 and
-stable, although it may conflict trivially on hunk context.

Patch #2 is a followup that changes memstart_addr to a signed type, which is
necessary when combining patch #1 with the linear region randomization patch
that is currently queued in -next.

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/481330
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/481327


Ard Biesheuvel (2):
  arm64: vmemmap: use virtual projection of linear region
  arm64: mm: treat memstart_addr as a signed quantity

 arch/arm64/include/asm/memory.h  | 2 +-
 arch/arm64/include/asm/pgtable.h | 7 ++++---
 arch/arm64/mm/init.c             | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.5.0
