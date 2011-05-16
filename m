From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 14:00:23 +0100
Subject: [PATCH v4 1/7] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305550364.30788.6.camel@e102391-lin.cambridge.arm.com>
References: <1300367028-3916-1-git-send-email-marc.zyngier@arm.com>
	<1300367028-3916-2-git-send-email-marc.zyngier@arm.com>
	<20110515074150.GA22975@n2100.arm.linux.org.uk>
	<1305550364.30788.6.camel@e102391-lin.cambridge.arm.com>
Message-ID: <20110516130023.GR30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 01:52:44PM +0100, Marc Zyngier wrote:
> On Sun, 2011-05-15 at 08:41 +0100, Russell King - ARM Linux wrote:
> > On Thu, Mar 17, 2011 at 01:03:42PM +0000, Marc Zyngier wrote:
> > > diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
> > > index bcfd9f7..d37cca0 100644
> > > --- a/include/linux/mtd/physmap.h
> > > +++ b/include/linux/mtd/physmap.h
> > > @@ -22,6 +22,8 @@ struct map_info;
> > >  
> > >  struct physmap_flash_data {
> > >  	unsigned int		width;
> > > +	int			(*init)(struct platform_device *);
> > > +	void			(*exit)(struct platform_device *);
> > >  	void			(*set_vpp)(struct map_info *, int);
> > 
> > Does anything use the map_info argument to set_vpp?  If not, passing a
> > platform_device pointer would be more consistent and useful here.
> 
> Good point. How about the following (untested) patch (on top of this
> serie)? It helps getting rid of a bit of code in the pismo driver.

Yup.

Now, I'd like to have acks from folk for the series - especially the mtd
folk who apparantly haven't yet done anything with this series.  I'm
happy to take it through my tree if they are.

This patch should get acks from the relevant platform people too.

David?
