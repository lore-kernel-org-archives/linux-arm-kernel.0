From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 21 Jan 2015 10:03:14 +0100
Subject: [GIT PULL] drm: Add Atmel HLCDC driver
Message-ID: <20150121100314.052c0693@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Here is the pull request for the Atmel HLCDC driver and its
dependencies (some modifications to drm/core and drm/panel to define
output bus format).
I've added Thierry's acks and rebased on drm-next, let me know if you
need something else.

Best Regards,

Boris

The following changes since commit fc83975348ebce07793e6b9f780edc3cbcffa9fc:

  Merge tag 'imx-drm-next-2015-01-09' of git://git.pengutronix.de/git/pza/linux into drm-next (2015-01-21 10:17:16 +1000)

are available in the git repository at:


  https://github.com/bbrezillon/linux-at91.git tags/atmel-hlcdc-drm-3.20

for you to fetch changes up to 5b7e944ec87da878ef828d06094720be8884d33a:

  drm: add DT bindings documentation for atmel-hlcdc-dc driver (2015-01-21 09:46:02 +0100)

----------------------------------------------------------------
Boris Brezillon (5):
      drm: add bus_formats and num_bus_formats fields to drm_display_info
      drm: panel: simple-panel: add support for bus_format retrieval
      drm: panel: simple-panel: add bus format information for foxlink panel
      drm: add Atmel HLCDC Display Controller support
      drm: add DT bindings documentation for atmel-hlcdc-dc driver

 .../devicetree/bindings/drm/atmel/hlcdc-dc.txt     |  53 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/atmel-hlcdc/Kconfig                |  11 +
 drivers/gpu/drm/atmel-hlcdc/Makefile               |   7 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 406 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 579 ++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       | 213 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c    | 667 ++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h    | 398 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 319 ++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 856 +++++++++++++++++++++
 drivers/gpu/drm/drm_crtc.c                         |  35 +
 drivers/gpu/drm/panel/panel-simple.c               |   6 +
 include/drm/drm_crtc.h                             |   8 +
 15 files changed, 3561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/atmel/hlcdc-dc.txt
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
