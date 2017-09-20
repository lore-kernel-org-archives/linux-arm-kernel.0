From: thomas@m3y3r.de (Thomas Meyer)
Date: Thu, 21 Sep 2017 00:29:36 +0200
Subject: [PATCH 7/7] drm/rockchip: Cocci spatch "vma_pages"
In-Reply-To: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1505946334393-988165015-7-diffsplit-thomas@m3y3r.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use vma_pages function on vma object instead of explicit computation.
Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -220,7 +220,7 @@ static int rockchip_drm_gem_object_mmap_
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 	unsigned int i, count = obj->size >> PAGE_SHIFT;
-	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long user_count = vma_pages(vma);
 	unsigned long uaddr = vma->vm_start;
 	unsigned long offset = vma->vm_pgoff;
 	unsigned long end = user_count + offset;
