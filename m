From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 5 Jan 2016 20:15:49 +0100
Subject: [PATCH RFC 0/2] Add a display driver to the Allwinner H3
Message-ID: <cover.1452021349.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proposed DRM driver works on a Orange PI 2 with a kernel 4.4-rc1
and the H3 patches found in Hans de Goede's GIT repository.

As there is no documentation about the DE2 nor about the HDMI which
are found in the H3, this driver has been built from Allwiiner's
sources.

So, there may be license problems, especially for the file
de2_hdmi_h3.c which contains a lot of magic values.

The associated DT and documentation will be submitted when the H3 DTs
will be in the kernel.

Jean-Francois Moine (2):
  clk: sunxi: Add sun8i display support
  drm: sunxi: Add a basic DRM driver for Allwinner DE2

 drivers/clk/sunxi/Makefile            |   1 +
 drivers/clk/sunxi/clk-sun8i-display.c | 257 ++++++++++++++++++
 drivers/gpu/drm/Kconfig               |   2 +
 drivers/gpu/drm/Makefile              |   1 +
 drivers/gpu/drm/sunxi/Kconfig         |  21 ++
 drivers/gpu/drm/sunxi/Makefile        |   8 +
 drivers/gpu/drm/sunxi/de2_crtc.c      | 409 +++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_crtc.h      |  42 +++
 drivers/gpu/drm/sunxi/de2_de.c        | 467 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_drm.h       |  51 ++++
 drivers/gpu/drm/sunxi/de2_drv.c       | 376 ++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi.c      | 381 +++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi.h      |  34 +++
 drivers/gpu/drm/sunxi/de2_hdmi_h3.c   | 478 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi_h3.h   |  14 +
 drivers/gpu/drm/sunxi/de2_plane.c     | 102 ++++++++
 16 files changed, 2644 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-display.c
 create mode 100644 drivers/gpu/drm/sunxi/Kconfig
 create mode 100644 drivers/gpu/drm/sunxi/Makefile
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_h3.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_h3.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c

-- 
2.6.4
