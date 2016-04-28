From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Apr 2016 10:55:27 +0200
Subject: [GIT PULL] drm: Allwinner sun4i support
Message-ID: <20160428085527.GA4129@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Please consider the following pull request to introduce the support
for the Allwinner SoCs display engine.

This is based on my latest patch set, adressing the minor reviews made
during that latest round.

Thanks,
Maxime

The following changes since commit 152ef5fa9e14e93e7efc43adad7dbcf35d7780f5:

  drm: Switch blobs to the new generic modeset obj refcounting (2016-04-27 09:58:05 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sun4i-drm-for-4.7

for you to fetch changes up to bf1139dfe797c0d6037dd689219a431516490544:

  MAINTAINERS: Add a maintainer for the Allwinner DRM driver (2016-04-28 10:30:05 +0200)

----------------------------------------------------------------
Allwinner DRM driver for 4.7

This pull request introduces the sun4i driver, meant to be used on the
older Allwinner SoCs (A10, A13, A20, A23, A31 and A33).

It currently supports only the A13, which has one of the simplest video
pipeline. Support for other video components and SoCs will be added
eventually.

It supports only a RGB or composite output. It doesn't do HDMI, VGA, LVDS
or power management yet, but that will come in time as well.

----------------------------------------------------------------
Maxime Ripard (8):
      drm: fb: Add seq_file definition
      drm: sun4i: Add DT bindings documentation
      drm: Add Allwinner A10 Display Engine support
      drm: sun4i: Add RGB output
      drm: sun4i: Add composite output
      drm: sun4i: tv: Add PAL output standard
      drm: sun4i: tv: Add NTSC output standard
      MAINTAINERS: Add a maintainer for the Allwinner DRM driver

 .../bindings/display/sunxi/sun4i-drm.txt           | 258 ++++++++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   3 +-
 drivers/gpu/drm/sun4i/Kconfig                      |  14 +
 drivers/gpu/drm/sun4i/Makefile                     |  13 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              | 364 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h              | 165 +++++
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 | 120 ++++
 drivers/gpu/drm/sun4i/sun4i_crtc.h                 |  30 +
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             | 160 +++++
 drivers/gpu/drm/sun4i/sun4i_dotclock.h             |  21 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  | 358 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |  30 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  54 ++
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  19 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                | 161 +++++
 drivers/gpu/drm/sun4i/sun4i_layer.h                |  30 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 250 ++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.h                  |  18 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 561 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 | 186 ++++++
 drivers/gpu/drm/sun4i/sun4i_tv.c                   | 708 +++++++++++++++++++++
 include/drm/drm_fb_cma_helper.h                    |   2 +
 24 files changed, 3533 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
 create mode 100644 drivers/gpu/drm/sun4i/Kconfig
 create mode 100644 drivers/gpu/drm/sun4i/Makefile
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tv.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/2d553697/attachment.sig>
