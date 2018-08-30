From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 30 Aug 2018 23:00:01 +0200
Subject: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
In-Reply-To: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
Message-ID: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up duplicated code for replacing firmware FB
driver with proper DRI driver and adds handover support to
Tegra driver.

This is a sligtly updated version of a series sent on 24 Nov 2017.

v2:
 - rebased on current drm-next
 - dropped staging/sm750fb changes
 - added kernel docs for DRM helpers

Micha? Miros?aw (12):
  fbdev: show fbdev number for debugging
  fbdev: allow apertures == NULL in remove_conflicting_framebuffers()
  fbdev: add remove_conflicting_pci_framebuffers()
  drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
  drm/bochs: use simpler remove_conflicting_pci_framebuffers()
  drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
  drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
  drm/radeon: use simpler remove_conflicting_pci_framebuffers()
  drm/virtio: use simpler remove_conflicting_pci_framebuffers()
  drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
  drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
  drm/tegra: kick out simplefb

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +-------------
 drivers/gpu/drm/bochs/bochs_drv.c        | 18 +----------
 drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +-------------
 drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +------------
 drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ------
 drivers/gpu/drm/radeon/radeon_drv.c      | 23 +-------------
 drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +----------
 drivers/gpu/drm/tegra/drm.c              |  4 +++
 drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-----------
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++------------
 drivers/video/fbdev/core/fbmem.c         | 40 ++++++++++++++++++++++--
 include/drm/drm_fb_helper.h              | 34 ++++++++++++++++++++
 include/linux/fb.h                       |  2 ++
 13 files changed, 88 insertions(+), 172 deletions(-)

-- 
2.18.0
