From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Mon, 22 Apr 2013 14:07:40 +0900
Subject: [RFC/PATCH 0/4] dma-mapping: Define dma_{alloc,
 free}_attrs() for all archs
Message-ID: <1366607260-2852-1-git-send-email-dhobsong@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most architectures that define CONFIG_HAVE_DMA=y, have implementations for
both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
not define CONFIG_HAVE_DMA also have both of these definitions provided by
dma-mapping-broken.h.

Provide a default definition for the archs that define CONFIG_HAVE_DMA=y,
but have no implementation for dma_{alloc,free}_attrs() by simply calling
dma_{alloc,free}_coherent() and throwing away the attrs argument.

Damian Hobson-Garcia (4):
  Provide default implementation for dma_{alloc,free}_attrs on arm64
  Provide default implementation for dma_{alloc,free}_attrs on c6x
  Provide default implementation for dma_{alloc,free}_attrs on parisc
  Provide default implementation for dma_{alloc,free}_attrs on s390

 arch/arm64/include/asm/dma-mapping.h  |    3 +++
 arch/c6x/include/asm/dma-mapping.h    |    3 +++
 arch/parisc/include/asm/dma-mapping.h |    3 +++
 arch/s390/include/asm/dma-mapping.h   |    3 +++
 4 files changed, 12 insertions(+), 0 deletions(-)

-- 
1.7.5.4
