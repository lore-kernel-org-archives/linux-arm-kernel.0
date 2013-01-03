From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 3 Jan 2013 08:39:50 -0800
Subject: [PATCH 133/493] remove use of __devexit_p
In-Reply-To: <Pine.LNX.4.64.1301031235370.17494@axis700.grange>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
 <Pine.LNX.4.64.1301031235370.17494@axis700.grange>
Message-ID: <20130103163950.GA2350@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 12:43:10PM +0100, Guennadi Liakhovetski wrote:
> Hi Bill
> 
> On Mon, 19 Nov 2012, Bill Pemberton wrote:
> 
> > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > needed.
> 
> Doesn't this also make the use of __refdata in many locations like this
> 
> [snip]
> 
> > diff --git a/drivers/media/platform/soc_camera/sh_mobile_csi2.c b/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> > index 0528650..0d0344a 100644
> > --- a/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> > +++ b/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> > @@ -382,7 +382,7 @@ static __devexit int sh_csi2_remove(struct platform_device *pdev)
> >  }
> >  
> >  static struct platform_driver __refdata sh_csi2_pdrv = {
> > -	.remove	= __devexit_p(sh_csi2_remove),
> > +	.remove	= sh_csi2_remove,
> >  	.probe	= sh_csi2_probe,
> >  	.driver	= {
> >  		.name	= "sh-mobile-csi2",
> 
> superfluous? If so, I'm sure you'd be happy to make a couple more patches 
> to continue this series ;-)

Yes, it does make it superfluous.  I'm still working on getting most of
the original patches into Linus's tree, so let's wait for that to happen
first before cleaning up the reset of these :)

thanks,

greg k-h
