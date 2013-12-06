From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 06 Dec 2013 14:29:22 +0100
Subject: [PATCHv5][ 2/8] staging: imx-drm: Add RGB666 support for
 parallel display.
In-Reply-To: <20131206131403.GA30960@ulmo.nvidia.com>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-2-git-send-email-denis@eukrea.com>
 <20131206131403.GA30960@ulmo.nvidia.com>
Message-ID: <1386336562.4088.5.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 06.12.2013, 14:14 +0100 schrieb Thierry Reding:
> On Thu, Dec 05, 2013 at 07:28:06PM +0100, Denis Carikli wrote:
> [...]
> > diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> [...]
> > @@ -155,6 +156,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
> >  		return IPU_DC_MAP_BGR666;
> >  	case V4L2_PIX_FMT_BGR24:
> >  		return IPU_DC_MAP_BGR24;
> > +	case V4L2_PIX_FMT_RGB666:
> > +		return IPU_DC_MAP_RGB666;
> 
> Why is this DRM driver even using V4L2 pixel formats in the first place?
> 
Because imx-drm is actually a misnomer. The i.MX IPU is a multifunction
device, which as one part has the display controllers, but also camera
interfaces and mem-to-mem scaler devices, which are hooked up via the
V4L2 interface.

The generic IPU part, which is used for example for programming the DMA
channels is using V4L2 pixel formats as a common base. We have patches
to split this out and make this fact more visible. (The IPU core will be
placed aside the Tegra host1x driver)

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
