From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Oct 2013 16:15:57 +0100
Subject: [GIT PULL] Armada DRM support
In-Reply-To: <20131006220728.GG12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
Message-ID: <20131018151557.GA25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Rob Clark has now reviewed this and has given his blessing for it to be
pulled for the coming merge window.

This adds support for the Armada 510 display subsystem found on the
Marvell Dove devices.  This IP is re-used across several different Marvell
SoCs with various tweaks, and this driver has been structured to allow
the other IPs to re-use the bulk of this code; further work in this area
is expected from interested parties.

This has been extensively tested on the SolidRun Cubox platform and
appears to work well there.

Please pull this driver for the next merge window.  Thanks.

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://ftp.arm.linux.org.uk/~rmk/linux-cubox.git drm-tda998x-3.12

which is commit: 585b691e2180e1501637050290292f77f5c30c7b

Russell King (5):
      DRM: Armada: Add Armada DRM driver
      DRM: Armada: Add support for ARGB 32x64 or 64x32 hardware cursors
      drm/i2c: tda998x: set VIF for full range, underscanned display
      Merge branches 'drm-3.12' and 'tda998x-3.12' into drm-tda998x-3.12
      DRM: Armada: add support for drm tda19988 driver

 drivers/gpu/drm/Kconfig                 |    2 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/armada/Kconfig          |   24 +
 drivers/gpu/drm/armada/Makefile         |    7 +
 drivers/gpu/drm/armada/armada_510.c     |   87 +++
 drivers/gpu/drm/armada/armada_crtc.c    | 1098 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.h    |   83 +++
 drivers/gpu/drm/armada/armada_debugfs.c |  183 +++++
 drivers/gpu/drm/armada/armada_drm.h     |  113 ++++
 drivers/gpu/drm/armada/armada_drv.c     |  422 ++++++++++++
 drivers/gpu/drm/armada/armada_fb.c      |  170 +++++
 drivers/gpu/drm/armada/armada_fb.h      |   24 +
 drivers/gpu/drm/armada/armada_fbdev.c   |  202 ++++++
 drivers/gpu/drm/armada/armada_gem.c     |  611 +++++++++++++++++
 drivers/gpu/drm/armada/armada_gem.h     |   52 ++
 drivers/gpu/drm/armada/armada_hw.h      |  318 +++++++++
 drivers/gpu/drm/armada/armada_ioctlP.h  |   18 +
 drivers/gpu/drm/armada/armada_output.c  |  158 +++++
 drivers/gpu/drm/armada/armada_output.h  |   39 ++
 drivers/gpu/drm/armada/armada_overlay.c |  477 ++++++++++++++
 drivers/gpu/drm/armada/armada_slave.c   |  139 ++++
 drivers/gpu/drm/armada/armada_slave.h   |   26 +
 drivers/gpu/drm/i2c/tda998x_drv.c       |    3 +
 include/drm/drm_crtc.h                  |   17 +
 include/uapi/drm/armada_drm.h           |   45 ++
 25 files changed, 4319 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpu/drm/armada/Kconfig
 create mode 100644 drivers/gpu/drm/armada/Makefile
 create mode 100644 drivers/gpu/drm/armada/armada_510.c
 create mode 100644 drivers/gpu/drm/armada/armada_crtc.c
 create mode 100644 drivers/gpu/drm/armada/armada_crtc.h
 create mode 100644 drivers/gpu/drm/armada/armada_debugfs.c
 create mode 100644 drivers/gpu/drm/armada/armada_drm.h
 create mode 100644 drivers/gpu/drm/armada/armada_drv.c
 create mode 100644 drivers/gpu/drm/armada/armada_fb.c
 create mode 100644 drivers/gpu/drm/armada/armada_fb.h
 create mode 100644 drivers/gpu/drm/armada/armada_fbdev.c
 create mode 100644 drivers/gpu/drm/armada/armada_gem.c
 create mode 100644 drivers/gpu/drm/armada/armada_gem.h
 create mode 100644 drivers/gpu/drm/armada/armada_hw.h
 create mode 100644 drivers/gpu/drm/armada/armada_ioctlP.h
 create mode 100644 drivers/gpu/drm/armada/armada_output.c
 create mode 100644 drivers/gpu/drm/armada/armada_output.h
 create mode 100644 drivers/gpu/drm/armada/armada_overlay.c
 create mode 100644 drivers/gpu/drm/armada/armada_slave.c
 create mode 100644 drivers/gpu/drm/armada/armada_slave.h
 create mode 100644 include/uapi/drm/armada_drm.h
