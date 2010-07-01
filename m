From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 1 Jul 2010 16:23:23 +0200 (CEST)
Subject: [PATCHv5] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <20100701122803.GE28535@pengutronix.de>
References: <47538fc4c6ffbc6a4c80ba55ecdd03603e67095c.1277981781.git.baruch@tkos.co.il>
	<20100701122803.GE28535@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1007011612580.17489@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe

On Thu, 1 Jul 2010, Uwe Kleine-K?nig wrote:

> > diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
> > index bdbc9d3..27e2acc 100644
> > --- a/drivers/media/video/Kconfig
> > +++ b/drivers/media/video/Kconfig
> > @@ -969,6 +969,19 @@ config VIDEO_OMAP2
> >  	---help---
> >  	  This is a v4l2 driver for the TI OMAP2 camera capture interface
> >  
> > +config VIDEO_MX2_HOSTSUPPORT
> > +        bool
> > +
> > +config VIDEO_MX2
> > +	tristate "i.MX27/i.MX25 Camera Sensor Interface driver"
> > +	depends on VIDEO_DEV && SOC_CAMERA && (MACH_MX27 || ARCH_MX25)
> > +	select VIDEOBUF_DMA_CONTIG
> CONTIG?

What exactly was your question here?

> > diff --git a/drivers/media/video/mx2_camera.c b/drivers/media/video/mx2_camera.c
> > new file mode 100644
> > index 0000000..98c93fa
> > --- /dev/null
> > +++ b/drivers/media/video/mx2_camera.c
> > @@ -0,0 +1,1513 @@
> 
> [...snip...]

> > +static struct platform_driver mx2_camera_driver = {
> > +	.driver 	= {
> > +		.name	= MX2_CAM_DRV_NAME,
> I'm always unsure if you need
> 
> 		.owner  = THIS_MODULE,
> 
> here.

It is not needed in this case. See the "owner" field in struct 
soc_camera_host_ops mx2_soc_camera_host_ops.

But that's not the reason why I'm replying. What I didn't like in these 
your reviews, was the fact, that this driver has been submitted a number 
of times to the arm-kernel ML, it has "mx2" in its subject, so, you had 
enough chances to review it, just like Sascha did. Instead, you review it 
now, making the author create new versions of his patch. You have been 
asked for advise, because this patch potentially collided with other your 
patches, your help in resolving this question is appreciated. But then you 
suddenly decide to review the whole patch... Several of my patches have 
been treated similarly in the past, so, I know how annoying it is to have 
to re-iterate them because at v5 someone suddenly decided to take part in 
the patch review process too...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
