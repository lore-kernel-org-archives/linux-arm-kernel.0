From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 20 Nov 2016 12:32:03 +0100
Subject: [PATCH v6 0/5] drm: sun8i: Add DE2 HDMI video support
Message-ID: <cover.1479641523.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset series adds HDMI video support to the Allwinner
sun8i SoCs which include the display engine 2 (DE2).
The driver contains the code for the A83T and H3, but it could be
used/extended for other SoCs as the A64, H2 and H5.

v6:
	- remove audio support (other patchset to come)
	- use DRM modeset data for HDMI configuration
		(thanks to Jernej ??krabec)
	- more meaningfull register names
	- use a mutex for DE I/O protection
	- merge DE and plane into one file
	- don't activate the video hardware when video not started
		(Maxime Ripard)
	- remove 'type = "video" in DT graph ports
		(Rob Herring)
	- change the I/O accesses by #define instead of struct
		(Maxime Ripard, Andr?? Przywara)
	- remove pm functions (Maxime Ripard)
	- set the pll-de/de clocks in the DT (Maxime Ripard)
	- use platform_get_irq instead of irq_of_parse_and_map
		(Maxime Ripard)
	- rename sunxi to sun8i (Maxime Ripard)
	- fix coding style errors (Maxime Ripard)
	- subclass the drm structure in private data (Daniel Vetter)
	- move drm_dev_register at end of init (Daniel Vetter)
v5:
	- add overlay plane
	- add audio support
	- add support for the A83T
	- add back the HDMI driver
	- many bug fixes
v4: 
	- drivers/clk/sunxi/Makefile was missing (Emil Velikov)
v3:
	- add the hardware cursor
	- simplify and fix the DE2 init sequences
	- generation for all SUNXI SoCs (Andre Przywara)
v2:
	- remove the HDMI driver
	- remarks from Chen-Yu Tsai and Russell King
	- DT documentation added

Jean-Francois Moine (5):
  drm: sun8i: Add a basic DRM driver for Allwinner DE2
  drm: sunxi: add HDMI video support to A83T and H3
  ARM: dts: sun8i-h3: add HDMI video nodes
  ARM: dts: sun8i-h3: Add HDMI video to the Banana Pi M2+
  ARM: dts: sun8i-h3: Add HDMI video to the Orange PI 2

 .../devicetree/bindings/display/sunxi/hdmi.txt     |  53 ++
 .../bindings/display/sunxi/sun8i-de2.txt           |  83 ++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  13 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  13 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  51 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/sun8i/Kconfig                      |  26 +
 drivers/gpu/drm/sun8i/Makefile                     |   9 +
 drivers/gpu/drm/sun8i/de2_crtc.c                   | 440 +++++++++++
 drivers/gpu/drm/sun8i/de2_crtc.h                   |  50 ++
 drivers/gpu/drm/sun8i/de2_drm.h                    |  48 ++
 drivers/gpu/drm/sun8i/de2_drv.c                    | 379 ++++++++++
 drivers/gpu/drm/sun8i/de2_hdmi.c                   | 394 ++++++++++
 drivers/gpu/drm/sun8i/de2_hdmi.h                   |  51 ++
 drivers/gpu/drm/sun8i/de2_hdmi_io.c                | 839 +++++++++++++++++++++
 drivers/gpu/drm/sun8i/de2_plane.c                  | 712 +++++++++++++++++
 17 files changed, 3164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
 create mode 100644 drivers/gpu/drm/sun8i/Kconfig
 create mode 100644 drivers/gpu/drm/sun8i/Makefile
 create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_drm.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_drv.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi_io.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_plane.c

-- 
2.10.2
