From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Oct 2014 09:38:49 -0500
Subject: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing
 MODULE_ALIAS()
In-Reply-To: <543E6683.5040103@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
 <543E6683.5040103@ti.com>
Message-ID: <20141015143849.GC10888@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 03:20:19PM +0300, Tomi Valkeinen wrote:
> On 14/10/14 21:28, Felipe Balbi wrote:
> > without MODULE_ALIAS(), omapfb won't get loaded
> > automatically.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > index 9cbf1ce..b4b9244 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > @@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0);
> >  
> >  module_platform_driver(omapfb_driver);
> >  
> > +MODULE_ALIAS("platform:omapfb");
> >  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
> >  MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
> >  MODULE_LICENSE("GPL v2");
> > 
> 
> Thanks, I've queued this.
> 
> Unfortunately it's somewhat based on luck if the automatic loading works
> correctly. We can't add more displays after omapfb has been probed, so
> all the panel and encoder drivers have to be loaded before omapfb.
> 
> We have two workarounds there, which help the situation a bit. First is
> that if omapfb finds no displays, it returns EPROBE_DEFER. The second is
> that if there are displays, but no main display (display0), then omapfb
> returns EPROBE_DEFER.
> 
> So even with these workarounds it is possible that drivers for secondary
> displays are loaded after omapfb, causing them to be ignored.

then there is another case to fix, right ? :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/1cdee349/attachment.sig>
