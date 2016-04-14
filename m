From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 09:27:25 +0200
Subject: [RESEND PULL] drm: atmel-hlcdc: various improvements
Message-ID: <20160414092725.0ee2fcdb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

I've reformated the PR to use a branch name instead of a commit hash.
Sorry for the inconvenience, I'll try to be more careful for my future
PRs.

This PR contains several improvement and cleanup patches for the
atmel-hlcdc driver to be applied on drm-next (targeting 4.7).

Best Regards,

Boris

The following changes since commit f9fd2adaacd8dc0ecbb38d96f3c62f20f0697176:

  Merge branch 'gma500-next' of git://github.com/patjak/drm-gma500 into drm-next (2016-04-14 13:07:12 +1000)

are available in the git repository at:

  https://github.com/bbrezillon/linux-at91.git drm-atmel-hlcdc-devel

for you to fetch changes up to ebab87ab7a130c2930b85695e01fc2944fab85c5:

  drm: atmel-hlcdc: route DMA accesses through AHB interfaces (2016-04-14 09:17:28 +0200)

----------------------------------------------------------------
Boris Brezillon (9):
      drm: atmel-hlcdc: add a ->cleanup_fb() operation
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  |  95 ++++++++-
 5 files changed, 481 insertions(+), 159 deletions(-)
