From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Mar 2012 13:26:01 +0100
Subject: [PATCH 0/2] ARM: dma-mapping: Fix mmap support for coherent buffers
In-Reply-To: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
Message-ID: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset contains patches to fix broken mmap operation for memory
buffers allocated from 'dma_declare_coherent' pool after applying my dma
mapping redesign patches [1]. These issues have been reported by Subash
Patel.

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/12819 

Patch summary:

Marek Szyprowski (2):
  common: add dma_mmap_from_coherent() function
  arm: dma-mapping: use dma_mmap_from_coherent()

 arch/arm/mm/dma-mapping.c          |    3 ++
 drivers/base/dma-coherent.c        |   42 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h |    4 ++-
 3 files changed, 48 insertions(+), 1 deletions(-)

-- 
1.7.1.569.g6f426
