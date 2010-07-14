From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Jul 2010 16:01:12 +0100
Subject: [PATCH v3 0/3] Ordered I/O accessors
Message-ID: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This version replaces the do { ... } while (0) constructs in the final
patch with ({ ... }) to avoid errors in drivers putting brackets around
the write*() accessors. To avoid the write*() macro having a non-void
type (and possibly the compiler generating code to read a register), the
first patch explicitly casts the __raw_write*() accessors to (void).


Catalin Marinas (3):
      ARM: Introduce *_relaxed() I/O accessors
      ARM: Convert L2x0 to use the IO relaxed operations
      ARM: Add barriers to the I/O accessors if ARM_DMA_MEM_BUFFERABLE


 arch/arm/include/asm/io.h |   40 ++++++++++++++++++++++++++++------------
 arch/arm/mm/cache-l2x0.c  |   26 +++++++++++++-------------
 2 files changed, 41 insertions(+), 25 deletions(-)

-- 
Catalin
