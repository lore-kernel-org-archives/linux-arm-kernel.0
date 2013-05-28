From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Tue, 28 May 2013 10:36:46 +0900
Subject: [PATCH v3 0/3] dma-mapping: Define dma_{alloc,
 free}_attrs() for all archs
Message-ID: <1369705006-16298-1-git-send-email-dhobsong@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most architectures that define CONFIG_HAS_DMA=y, have implementations for
both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
not define CONFIG_HAS_DMA also have both of these definitions provided by
dma-mapping-broken.h.

Provide a default definition for the archs that define CONFIG_HAS_DMA=y,
but have no implementation for dma_{alloc,free}_attrs(). 

As I don't have hardware for any of these systems, the patches are only
compile-tested where I could (arm64, s390) and untested for the archs
where I couldn't find a readily available prebuilt cross-compiler (c6x).

Changes from v2
---------------
Correct commit log. CONFIG_HAVE_DMA should be CONFIG_HAS_DMA.
Remove parisc from the patch series as it has already been merged.

Changes from v1
---------------
arm64, s390:
 * Since these archs are using dma_ops, pass appropirate value for attrs to 
   dma_ops->alloc().
 * Indicate that these patches are compile teseted only (I don't have hardware)

c6x:
 * Indicate that this patch is untested (I don't have a cross compiler)

Cheers,
Damian

Damian Hobson-Garcia (3):
  arm64: Provide default implementation for dma_{alloc,free}_attrs
  c6x: Provide default implementation for dma_{alloc,free}_attrs
  s390: Provide default implementation for dma_{alloc,free}_attrs

 arch/arm64/include/asm/dma-mapping.h |   17 +++++++++++------
 arch/c6x/include/asm/dma-mapping.h   |    3 +++
 arch/s390/include/asm/dma-mapping.h  |   17 +++++++++++------
 3 files changed, 25 insertions(+), 12 deletions(-)

-- 
1.7.9.5
