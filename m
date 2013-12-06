From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 15:16:35 +0100
Subject: [PATCHv5][ 2/8] staging: imx-drm: Add RGB666 support for
 parallel display.
In-Reply-To: <1386336562.4088.5.camel@weser.hi.pengutronix.de>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-2-git-send-email-denis@eukrea.com>
 <20131206131403.GA30960@ulmo.nvidia.com>
 <1386336562.4088.5.camel@weser.hi.pengutronix.de>
Message-ID: <20131206141635.GB32313@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 02:29:22PM +0100, Lucas Stach wrote:
> Am Freitag, den 06.12.2013, 14:14 +0100 schrieb Thierry Reding:
> > On Thu, Dec 05, 2013 at 07:28:06PM +0100, Denis Carikli wrote:
> > [...]
> > > diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> > [...]
> > > @@ -155,6 +156,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
> > >  		return IPU_DC_MAP_BGR666;
> > >  	case V4L2_PIX_FMT_BGR24:
> > >  		return IPU_DC_MAP_BGR24;
> > > +	case V4L2_PIX_FMT_RGB666:
> > > +		return IPU_DC_MAP_RGB666;
> > 
> > Why is this DRM driver even using V4L2 pixel formats in the first place?
> > 
> Because imx-drm is actually a misnomer. The i.MX IPU is a multifunction
> device, which as one part has the display controllers, but also camera
> interfaces and mem-to-mem scaler devices, which are hooked up via the
> V4L2 interface.
> 
> The generic IPU part, which is used for example for programming the DMA
> channels is using V4L2 pixel formats as a common base. We have patches
> to split this out and make this fact more visible. (The IPU core will be
> placed aside the Tegra host1x driver)

Have you considered splitting thing up further and move out the display
controller driver to DRM and the camera driver to V4L2? I mean, if that
is even possible with a reasonable amount of work.

Is the "mem-to-mem" the same as the "DMA channels" you mentioned? If it
only does DMA, why does it even need to worry about pixel formats?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/1a271527/attachment.sig>
