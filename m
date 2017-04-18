From: labbott@redhat.com (Laura Abbott)
Date: Tue, 18 Apr 2017 11:27:02 -0700
Subject: [PATCHv4 00/12] Ion cleanup in preparation for moving out of staging
Message-ID: <1492540034-5466-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v4 of the series to cleanup to Ion. Greg took some of the patches
that weren't CMA related already. There was a minor bisectability problem
with the CMA APIs so this is a new version to address that. I also
addressed some minor comments on the patch to collapse header files.

Thanks,
Laura

Laura Abbott (12):
  cma: Store a name in the cma structure
  cma: Introduce cma_for_each_area
  staging: android: ion: Use CMA APIs directly
  staging: android: ion: Stop butchering the DMA address
  staging: android: ion: Break the ABI in the name of forward progress
  staging: android: ion: Get rid of ion_phys_addr_t
  staging: android: ion: Collapse internal header files
  staging: android: ion: Rework heap registration/enumeration
  staging: android: ion: Drop ion_map_kernel interface
  staging: android: ion: Remove ion_handle and ion_client
  staging: android: ion: Set query return value
  staging/android: Update Ion TODO list

 arch/powerpc/kvm/book3s_hv_builtin.c            |   3 +-
 drivers/base/dma-contiguous.c                   |   5 +-
 drivers/staging/android/TODO                    |  21 +-
 drivers/staging/android/ion/Kconfig             |  32 +
 drivers/staging/android/ion/Makefile            |  11 +-
 drivers/staging/android/ion/compat_ion.c        | 152 -----
 drivers/staging/android/ion/compat_ion.h        |  29 -
 drivers/staging/android/ion/ion-ioctl.c         |  55 +-
 drivers/staging/android/ion/ion.c               | 812 ++----------------------
 drivers/staging/android/ion/ion.h               | 386 ++++++++---
 drivers/staging/android/ion/ion_carveout_heap.c |  21 +-
 drivers/staging/android/ion/ion_chunk_heap.c    |  16 +-
 drivers/staging/android/ion/ion_cma_heap.c      | 120 ++--
 drivers/staging/android/ion/ion_heap.c          |  68 --
 drivers/staging/android/ion/ion_page_pool.c     |   3 +-
 drivers/staging/android/ion/ion_priv.h          | 453 -------------
 drivers/staging/android/ion/ion_system_heap.c   |  39 +-
 drivers/staging/android/uapi/ion.h              |  36 +-
 include/linux/cma.h                             |   6 +-
 mm/cma.c                                        |  31 +-
 mm/cma.h                                        |   1 +
 mm/cma_debug.c                                  |   2 +-
 22 files changed, 524 insertions(+), 1778 deletions(-)
 delete mode 100644 drivers/staging/android/ion/compat_ion.c
 delete mode 100644 drivers/staging/android/ion/compat_ion.h
 delete mode 100644 drivers/staging/android/ion/ion_priv.h

-- 
2.7.4
