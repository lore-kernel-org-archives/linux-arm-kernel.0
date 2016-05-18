From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 15:45:01 +0200
Subject: [PATCH 0/5] drm: fixes for merge-window regressions
Message-ID: <1463579106-400827-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of new warnings and build errors appeared through the DRM
tree in linux-next after the merge window opened. The first patch
here is for scripts/headers_check.pl, but as the bug is only
present in drm-next at the moment, it would be good to add all
five patches to that tree before they make it into mainline.

It's likely that some of these have already been fixed since
this morning's linux-next, so just ignore the ones are no
longer needed.

Arnd Bergmann (5):
  headers_check: don't warn about c++ guards
  drm: mediatek: add CONFIG_OF dependency
  drm: mediatek: fixup drm_gem_object_lookup API change
  drm: exynos: mark pm functions as __maybe_unused
  drm: remove unused dev variables

 drivers/gpu/drm/armada/armada_crtc.c   | 1 -
 drivers/gpu/drm/exynos/exynos_hdmi.c   | 6 ++----
 drivers/gpu/drm/mediatek/Kconfig       | 1 +
 drivers/gpu/drm/mediatek/mtk_drm_fb.c  | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c  | 1 -
 drivers/gpu/drm/nouveau/nv50_display.c | 1 -
 drivers/gpu/drm/radeon/radeon_cs.c     | 1 -
 scripts/headers_check.pl               | 4 ++++
 9 files changed, 9 insertions(+), 10 deletions(-)


Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian K?nig" <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: nouveau at lists.freedesktop.org

-- 
2.7.0
