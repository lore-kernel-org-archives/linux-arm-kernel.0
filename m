From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:14:59 -0800
Subject: [PATCHv2 07/14] drm: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-8-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 1 +
 drivers/gpu/drm/gma500/gtt.c             | 1 +
 drivers/gpu/drm/gma500/psb_drv.c         | 1 +
 drivers/gpu/drm/radeon/radeon_gart.c     | 1 +
 drivers/gpu/drm/ttm/ttm_page_alloc.c     | 1 +
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 1 +
 drivers/gpu/drm/ttm/ttm_tt.c             | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 964d2a94..2479ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/amdgpu_drm.h>
+#include <asm/set_memory.h>
 #include "amdgpu.h"
 
 /*
diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index 3f4f424..3949b09 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -21,6 +21,7 @@
 
 #include <drm/drmP.h>
 #include <linux/shmem_fs.h>
+#include <asm/set_memory.h>
 #include "psb_drv.h"
 #include "blitter.h"
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 5ee93ff..1f9b35a 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include <acpi/video.h>
 #include <linux/module.h>
+#include <asm/set_memory.h>
 
 static struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index c4777c8..dcf8042 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
+#include <asm/set_memory.h>
 #include "radeon.h"
 
 /*
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index a37de5d..04d8b43 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -51,6 +51,7 @@
 #if IS_ENABLED(CONFIG_AGP)
 #include <asm/agp.h>
 #endif
+#include <asm/set_memory.h>
 
 #define NUM_PAGES_TO_ALLOC		(PAGE_SIZE/sizeof(struct page *))
 #define SMALL_ALLOCATION		16
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index cec4b4b..d6e4cb7 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -53,6 +53,7 @@
 #if IS_ENABLED(CONFIG_AGP)
 #include <asm/agp.h>
 #endif
+#include <asm/set_memory.h>
 
 #define NUM_PAGES_TO_ALLOC		(PAGE_SIZE/sizeof(struct page *))
 #define SMALL_ALLOCATION		4
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index aee3c00..668ae6f 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -44,6 +44,7 @@
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_page_alloc.h>
+#include <asm/set_memory.h>
 
 /**
  * Allocates storage for pointers to the pages that back the ttm.
-- 
2.7.4
