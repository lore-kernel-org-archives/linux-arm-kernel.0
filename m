From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Oct 2013 23:07:29 +0100
Subject: [PATCH 0/5] Armada DRM stuff
Message-ID: <20131006220728.GG12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada DRM drivers again, along with the TDA998x HDMI output support,
and an illustration to show how to add Armada 610 support (and others.)

Rob has looked at this a couple of times since its last posting, and
has provided additional useful feedback which has been incorporated.
I believe all the major issues have been addressed now.

 drivers/gpu/drm/Kconfig                 |    2 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/armada/Kconfig          |   24 +
 drivers/gpu/drm/armada/Makefile         |    8 +
 drivers/gpu/drm/armada/armada_510.c     |   87 +++
 drivers/gpu/drm/armada/armada_610.c     |   49 ++
 drivers/gpu/drm/armada/armada_crtc.c    | 1099 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.h    |   83 +++
 drivers/gpu/drm/armada/armada_debugfs.c |  183 +++++
 drivers/gpu/drm/armada/armada_drm.h     |  114 ++++
 drivers/gpu/drm/armada/armada_drv.c     |  428 ++++++++++++
 drivers/gpu/drm/armada/armada_fb.c      |  170 +++++
 drivers/gpu/drm/armada/armada_fb.h      |   24 +
 drivers/gpu/drm/armada/armada_fbdev.c   |  202 ++++++
 drivers/gpu/drm/armada/armada_gem.c     |  616 +++++++++++++++++
 drivers/gpu/drm/armada/armada_gem.h     |   52 ++
 drivers/gpu/drm/armada/armada_hw.h      |  326 +++++++++
 drivers/gpu/drm/armada/armada_ioctlP.h  |   18 +
 drivers/gpu/drm/armada/armada_output.c  |  158 +++++
 drivers/gpu/drm/armada/armada_output.h  |   39 ++
 drivers/gpu/drm/armada/armada_overlay.c |  477 ++++++++++++++
 drivers/gpu/drm/armada/armada_slave.c   |  139 ++++
 drivers/gpu/drm/armada/armada_slave.h   |   26 +
 drivers/gpu/drm/i2c/tda998x_drv.c       |    2 +
 include/drm/drm_crtc.h                  |   17 +
 include/uapi/drm/armada_drm.h           |   45 ++
 26 files changed, 4389 insertions(+), 0 deletions(-)
