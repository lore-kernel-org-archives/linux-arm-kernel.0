From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 18 Jul 2016 14:44:12 +0530
Subject: [PATCH v2 0/8] Cache-coherent DMA access using UIO
Message-ID: <1468833260-5305-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this patchset is to improve UIO framework and UIO dmem
driver to allow cache-coherent DMA accesses from user-space.

This patchset is based on two previous patchsets:
1) [PATCH v5 0/6] UIO driver for APM X-Gene QMTM
(Refer, http://www.spinics.net/lists/devicetree/msg58244.html)
2) [PATCH 0/4] Fix and extend uio_dmem_genirq
(Refer, https://lkml.org/lkml/2016/5/17/141)

We have adopted only patch0-3 of patchset1 which was abandoned
long time back. We have taken care of last few unaddressed comments
on these patches.

The patchset2 is quite recent has been adopted entirely. We have
taken care review comments on these patches too.

This patchset is based on v4.7-rc7 tag and it is available in uio-v2
branch of https://github.com/Broadcom/arm64-linux.git

Changes since v1:
 - Make patch5 as first patch1 and mark it for linux-stable
 - Get UIO dmem dynamic region details as module parameter instead
   of getting it from DT node

Ankit Jindal (3):
  uio: code style cleanup
  uio: Add new UIO_MEM_PHYS_CACHE type for mem regions
  Documentation: Update documentation for UIO_MEM_PHYS_CACHE and
    UIO_MEM_DEVICE

Anup Patel (2):
  uio: Add new UIO_MEM_DEVICE type for mem regions
  uio: Use new memtypes in uio_dmem_genirq

Jan Viktorin (3):
  uio: fix dmem_region_start computation
  uio: UIO_IRQ_NONE is a valid option for uioinfo->irq
  uio: bind uio_dmem_genirq via OF

 Documentation/DocBook/uio-howto.tmpl |   6 +-
 drivers/uio/uio.c                    |  32 ++++--
 drivers/uio/uio_dmem_genirq.c        | 190 +++++++++++++++++++++++++++--------
 include/linux/uio_driver.h           |  10 +-
 4 files changed, 182 insertions(+), 56 deletions(-)

-- 
1.9.1
