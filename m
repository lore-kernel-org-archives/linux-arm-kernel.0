From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Aug 2015 11:34:40 +0200
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
Message-ID: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the single patch I posted on Aug 15th to ignore
RAM that cannot be covered by the linear mapping. Instead of clipping
the memory after the fact, this clips the memory before installing the
regions into the memblock memory table.

This is basically the approach that Mark Rutland suggested here

http://article.gmane.org/gmane.linux.ports.arm.kernel/430239

but modified to correctly consider the base of the kernel image as the
start of the linear mapping.

Ard Biesheuvel (2):
  of/fdt: make memblock maximum physical address arch configurable
  arm64: set MAX_MEMBLOCK_ADDR according to linear region size

 arch/arm64/include/asm/memory.h |  8 ++++++++
 drivers/of/fdt.c                | 12 +++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
1.9.1
