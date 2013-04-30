From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Tue, 30 Apr 2013 12:01:39 +0900
Subject: [PATCH v2 0/4] dma-mapping: Define dma_{alloc,
 free}_attrs() for all archs
Message-ID: <1367290899-10410-1-git-send-email-dhobsong@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most architectures that define CONFIG_HAVE_DMA=y, have implementations for
both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
not define CONFIG_HAVE_DMA also have both of these definitions provided by
dma-mapping-broken.h.

Provide a default definition for the archs that define CONFIG_HAVE_DMA=y,
but have no implementation for dma_{alloc,free}_attrs(). 

As I don't have hardware for any of these systems, the patches are only
compile-tested where I could (arm64, s390) and untested for the archs
where I couldn't find a readily available prebuilt cross-compiler (c6x, parisc).

Changes from v1
---------------

arm64, s390:
 * Since these archs are using dma_ops, pass appropirate value for attrs to 
   dma_ops->alloc().
 * Indicate that these patches are compile teseted only (I don't have hardware)


c6x, parisc:
 * Indicate that these patches are untested (I don't have cross compilers)

Cheers,
Damian 


Damian Hobson-Garcia (4):
  arm64: Provide default implementation for dma_{alloc,free}_attrs
  c6x: Provide default implementation for dma_{alloc,free}_attrs
  parisc: Provide default implementation for dma_{alloc,free}_attrs
  s390: Provide default implementation for dma_{alloc,free}_attrs

 arch/arm64/include/asm/dma-mapping.h  |   17 +++++++++++------
 arch/c6x/include/asm/dma-mapping.h    |    3 +++
 arch/parisc/include/asm/dma-mapping.h |    3 +++
 arch/s390/include/asm/dma-mapping.h   |   17 +++++++++++------
 4 files changed, 28 insertions(+), 12 deletions(-)

-- 
1.7.5.4
