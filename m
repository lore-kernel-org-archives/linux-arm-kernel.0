From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 16:45:33 +0200
Subject: [RFC] i.MX DRM devicetree binding
In-Reply-To: <20120614161016.20c79038@archvile>
References: <20120614130756.GS30400@pengutronix.de>
 <20120614161016.20c79038@archvile>
Message-ID: <20120614144533.GV30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 04:10:16PM +0200, David Jander wrote:
> On Thu, 14 Jun 2012 15:07:56 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx-parallel-display"
> > +- crtc: the crtc this display is connected to, see below
> > +Optional properties:
> > +- interface_pix_fmt: How this display is connected to the
> > +  crtc. Currently supported types: "rgb24", "rgb565"
> > +- edid: verbatim EDID data block describing attached display.
> 
> I never really understood why one should put EDID data in a device-tree. It
> carries a lot of irrelevant information and is in a quite hostile format. The
> only reason it exists actually is historically grown "intelligency" built into
> VESA compatible CRT monitors for PC's.... what do _we_ have to do with that?
> There isn't even a decent tool to generate this data on linux.
> On top of that, the examples I have seen of EDID blobs in device-trees so far
> are just plain wrong and even contain device id's from "Samsung SyncMaster"
> and other such stuff that IMHO has no place here.
> 
> But we need an alternative way of communicating timing parameters. Can't we
> use something more ad-hoc, like the data one would give to DRM_MODE() in
> drm_crtc.h?

Generally +1 for this.

I Just don't want to open up another front for now, but I am willing to
support a generic (not i.MX specific) format to describe display timings
in devicetree.

The only discussion I know about was here:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080683.html

The outcome was that the suggested format was not entirely generic and
that it would be better to use some existing format rather than
inventing something new. I disagree here. The thing called modeline,
drm_display_mode or fb_videomode is well established and it is known
which parameters (most) displays need, so it should be possible to have
a generic display description in the devicetree.

However, we need EDID data parsing anyway in the kernel and being able
to overwrite the (maybe broken monitor supplied) EDID data in the
devicetree might become handy. So having this way of supplying EDID data
is good to have even if there is a generic display description.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
