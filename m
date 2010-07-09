From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 12:07:56 +0100
Subject: [PATCH v2 0/3] Ordered I/O accessors
Message-ID: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This updated series fixes a bug in the L2x0 code causing a deadlock
(thanks to Adrian Kwong at Trident). The solution is to convert the
entire cache-l2x0.c file to the *_relaxed() I/O accessors.


Catalin Marinas (3):
      ARM: Introduce *_relaxed() I/O accessors
      ARM: Convert L2x0 to use the IO relaxed operations for cache sync
      ARM: Add barriers to the I/O accessors if ARM_DMA_MEM_BUFFERABLE


 arch/arm/include/asm/io.h |   39 +++++++++++++++++++++++++++------------
 arch/arm/mm/cache-l2x0.c  |   26 +++++++++++++-------------
 2 files changed, 40 insertions(+), 25 deletions(-)

-- 
Catalin
