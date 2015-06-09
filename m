From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 09 Jun 2015 12:27:05 -0400
Subject: [PATCH 0/2] scatterlist cleanups
Message-ID: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

While working through a conversion of the scattlerlist data structure
I noticed that some users were open coding scatterlist manipulations.
Christoph recommended sending these for 4.1-rc inclusion.  These are
based on 4.1-rc7.

---

Dan Williams (2):
      scatterlist: use sg_phys()
      scatterlist: cleanup sg_chain() and sg_unmark_end()


 arch/arm/mm/dma-mapping.c                    |    2 +-
 arch/microblaze/kernel/dma.c                 |    2 +-
 block/blk-merge.c                            |    2 +-
 drivers/crypto/omap-sham.c                   |    2 +-
 drivers/dma/imx-dma.c                        |    8 ++------
 drivers/dma/ste_dma40.c                      |    5 +----
 drivers/iommu/intel-iommu.c                  |    4 ++--
 drivers/iommu/iommu.c                        |    2 +-
 drivers/mmc/card/queue.c                     |    4 ++--
 drivers/staging/android/ion/ion_chunk_heap.c |    4 ++--
 include/crypto/scatterwalk.h                 |    9 ++-------
 11 files changed, 16 insertions(+), 28 deletions(-)
