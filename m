From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Feb 2011 16:37:16 +0100
Subject: [PATCH] i.MX23/28 framebuffer driver
In-Reply-To: <201102091547.12131.arnd@arndb.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091547.12131.arnd@arndb.de>
Message-ID: <20110209153716.GN9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Feb 09, 2011 at 03:47:11PM +0100, Arnd Bergmann wrote:
> On Wednesday 09 February 2011, Sascha Hauer wrote:
> > Hi all,
> > 
> > The following patches add framebuffer support for Freescale i.MX23/28
> > processors.
> 
> Hi Sascha,
> 
> The driver looks good as far as I can tell, but I'd recommend
> submitting it to linux-fbdev at vger.kernel.org for review in
> addition to linux-arm-kernel. The frame buffer layer is largely
> unmaintained these days, but there are still people on that
> list that care.

The driver patch itself is Cced to linux-fbdev, only the introductory
mail is not.

> 
> Did you consider making the driver a KMS driver instead of
> a frame buffer? I think the recommendation these days is
> to start out with KMS for new drivers, which will be somewhat
> simpler and give you a frame buffer device as well. I don't
> think that there is a need to change over any drivers from
> fb to kms though, since you've already done the work.

I tried doing so for the i.MX51 which supports multiple displays on dvi
and vga outputs and thus could make good use of KMS and friends. Anyway,
I got stuck quite fast. The KMS stuff is tightly coupled with DRM/DRI
and needs many many callbacks to implement. Additionally the userspace
tools expect a nvidia/amd/intel driver and do not have a generic
fallback. I think this stuff is good for implementing a full blown
graphics driver, but is lacking support for simple framebuffer grapics.
I'd love to go this way but it still requires a lot of work.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
