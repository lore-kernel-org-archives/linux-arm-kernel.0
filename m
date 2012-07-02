From: mugunthanvnm@ti.com (N, Mugunthan V)
Date: Mon, 2 Jul 2012 07:16:04 +0000
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EAEE878@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206281031510.2338@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EAEE878@DBDE01.ent.ti.com>
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9C03C6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Bedia, Vaibhav
> Sent: Friday, June 29, 2012 4:54 PM
> To: Paul Walmsley
> Cc: N, Mugunthan V; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Cousson, Benoit; Hilman, Kevin
> Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
> 
> Hi Paul,
> 
> On Thu, Jun 28, 2012 at 22:02:46, Paul Walmsley wrote:
> > On Thu, 28 Jun 2012, Bedia, Vaibhav wrote:
> >
> > > On Thu, Jun 28, 2012 at 21:22:54, Paul Walmsley wrote:
> > > [...]
> > > >
> > > > dma_mask and coherent_dma_mask can be specified during
> > > > device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-
> musb.c
> > > > for an example.
> > > >
> > >
> > > Thanks for pointing this out. Should omap_device_build() start
> handling this
> > > or would that be an overkill?
> >
> > If both dma_mask and coherent_dma_mask are always 0xffffffff on all
> OMAPs
> > and we can set that safely even for devices that don't use it, then yeah
> > it sounds like we should set it.
> >
> > Care to send a patch?
> >
> 
> I just grepped for the any other user of this under mach-omap2 and plat-
> omap
> and there are a few other places where it's getting used. All of them are
> setting it to 0xffffffff and same is the case with the CPSW driver.
> 
> I don't know much about the dma stuff so I am bit reluctant in setting
> this
> unconditionally. I looked at setting the mask based on a flag during
> omap_device_build() but an additional flag in the API will cause all the
> users
> to be changed. We could perhaps extend the omap_hwmod structure for
> passing on
> this information. Or for CPSW we could stick with approach that's been
> adopted
> in usb_musb_init(). Which approach sounds better to you?
> 
> Regards,
> Vaibhav B.

Extending omap_device_build() to accommodate dma masks will endup with lot 
of code changes in other modules, so will follow the same from 
usb_musd_init().

Regards,
Mugunthan V N.
