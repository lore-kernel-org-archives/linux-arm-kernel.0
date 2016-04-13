From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 11:45:14 +0200
Subject: [PULL] drm: atmel-hlcdc: various improvements
Message-ID: <20160413114514.710e85b3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a pull request containing several improvement and cleanup patches
for the atmel-hlcdc driver to be applied on drm-next (targeting 4.7).

Best Regards,

Boris

The following changes since commit c1cc68ae84bcce64e63d81b3531296728d407a16:

  drm: atmel-hlcdc: add a ->cleanup_fb() operation (2016-04-13 10:49:13 +0200)

are available in the git repository at:

  https://github.com/bbrezillon/linux-at91.git cba06c6

for you to fetch changes up to cba06c65983250d991b87eeade86b089c6bf2bc4:

  drm: atmel-hlcdc: route DMA accesses through AHB interfaces (2016-04-13 10:49:18 +0200)

----------------------------------------------------------------
Boris Brezillon (8):
      drm: atmel-hlcdc: support asynchronous atomic commit operations
      drm: atmel-hlcdc: fix connector and encoder types
      drm: atmel-hlcdc: remove leftovers from atomic mode setting migration
      drm: atmel-hlcdc: support extended timing ranges on sama5d4 and sama5d2
      drm: atmel-hlcdc: move output mode selection in CRTC implementation
      drm: atmel-hlcdc: rework the output code to support drm bridges
      drm: atmel-hlcdc: check display mode validity in crtc->mode_fixup()
      drm: atmel-hlcdc: route DMA accesses through AHB interfaces

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 158 +++++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 123 ++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  15 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 249 ++++++++++-------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  |  43 +++-
 5 files changed, 432 insertions(+), 156 deletions(-)
