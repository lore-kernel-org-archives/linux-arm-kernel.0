From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 2 Feb 2016 16:33:43 +0100
Subject: [PATCH v3 0/2] Add a DRM display driver to the Allwinner H3
Message-ID: <cover.1454427223.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proposed DRM driver works on a Orange PI 2 with a kernel 4.5.0-rc1
and some H3 patches found in Hans de Goede's GIT repository.

As there is no documentation about the HDMI of the H3,
the associated encoder/connector driver has not been included
in this patch series.
For test purpose, it may be built as a out-of-tree driver
from the tarball:
	http://moinejf.free.fr/opi2/h3-hdmi.tar.gz
and the DT files:
	http://moinejf.free.fr/opi2/sun8i-h3.dtsi
	http://moinejf.free.fr/opi2/sun8i-h3-orangepi-plus.dts

Jean-Francois Moine (2):
  clk: sunxi: Add sun6i/8i video support
  drm: sunxi: Add a basic DRM driver for Allwinner DE2

 Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
 .../devicetree/bindings/display/sunxi.txt          |  81 ++++
 drivers/clk/sunxi/clk-sun6i-display.c              | 106 +++++
 drivers/clk/sunxi/clk-sun6i-pll3.c                 | 174 +++++++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/sunxi/Kconfig                      |  20 +
 drivers/gpu/drm/sunxi/Makefile                     |   7 +
 drivers/gpu/drm/sunxi/de2_crtc.c                   | 421 +++++++++++++++++
 drivers/gpu/drm/sunxi/de2_crtc.h                   |  61 +++
 drivers/gpu/drm/sunxi/de2_de.c                     | 505 +++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_drm.h                    |  40 ++
 drivers/gpu/drm/sunxi/de2_drv.c                    | 377 +++++++++++++++
 drivers/gpu/drm/sunxi/de2_plane.c                  |  91 ++++
 14 files changed, 1888 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi.txt
 create mode 100644 drivers/clk/sunxi/clk-sun6i-display.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-pll3.c
 create mode 100644 drivers/gpu/drm/sunxi/Kconfig
 create mode 100644 drivers/gpu/drm/sunxi/Makefile
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c

-- 
2.7.0
