From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:52 +0200
Subject: [PATCH 09/21] drm: export drm_vm_open_locked
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EXYNOS DRM driver uses drm_vm_open_locked in its mmap() function,
and it can be built as a loadable module, which currently fails.
This exports the symbol from the DRM core to avoid

ERROR: "drm_vm_open_locked" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/gpu/drm/drm_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index db7bd29..1d4f7c9 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -422,6 +422,7 @@ void drm_vm_open_locked(struct drm_device *dev,
 		list_add(&vma_entry->head, &dev->vmalist);
 	}
 }
+EXPORT_SYMBOL_GPL(drm_vm_open_locked);
 
 static void drm_vm_open(struct vm_area_struct *vma)
 {
-- 
1.8.1.2
