From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 17 Dec 2012 15:56:27 +0200
Subject: [RFC] drm/lcdc: add TI LCD Controller DRM driver
In-Reply-To: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
Message-ID: <50CF248B.4010401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-12-14 02:04, Rob Clark wrote:
> A simple DRM/KMS driver for the TI LCD Controller found in various
> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
> CMA helpers.  Currently only the TFP410 DVI encoder is supported
> (tested with beaglebone + DVI cape).  There are also various LCD
> displays, for which support can be added (as I get hw to test on),
> and an external i2c HDMI encoder found on some boards.
> 
> The display controller supports a single CRTC.  And the encoder+
> connector are split out into sub-devices.  Depending on which LCD
> or external encoder is actually present, the appropriate output
> module(s) will be loaded.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig            |   2 +
>  drivers/gpu/drm/Makefile           |   1 +
>  drivers/gpu/drm/lcdc/Kconfig       |  11 +
>  drivers/gpu/drm/lcdc/Makefile      |   8 +
>  drivers/gpu/drm/lcdc/lcdc_crtc.c   | 544 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/lcdc/lcdc_drv.c    | 604 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/lcdc/lcdc_drv.h    | 162 ++++++++++
>  drivers/gpu/drm/lcdc/lcdc_regs.h   | 154 ++++++++++
>  drivers/gpu/drm/lcdc/lcdc_tfp410.c | 424 ++++++++++++++++++++++++++
>  drivers/gpu/drm/lcdc/lcdc_tfp410.h |  26 ++
>  10 files changed, 1936 insertions(+)
>  create mode 100644 drivers/gpu/drm/lcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/lcdc/Makefile
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.h
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_regs.h
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.h

"lcdc" is quite a common term. The directory should perhaps be something
like ti-lcdc?

Probably not relevant, but I wonder if the same LCDC was used in
omap1... It'd be nice to get rid of the omap1 fb driver.

I'm not very enthusiastic about adding ti-lcdc specific panel/chip
drivers. It's not really a big deal if it's only kernel code, but you
add device-tree bindings also, which is an external API that you need to
support after adding it.

I'd rather see the energy put to common display framework, and get this
whole panel/chip driver issue solved in a generic manner.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/8d319cc7/attachment-0001.sig>
