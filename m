From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 07 Jul 2014 09:26:52 +0200
Subject: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <20140707072140.GB30458@sirena.org.uk>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <5578791.jcBVzrGadW@diego> <20140707072140.GB30458@sirena.org.uk>
Message-ID: <2620380.GejlhFPJDO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 7. Juli 2014, 08:21:40 schrieb Mark Brown:
> On Mon, Jul 07, 2014 at 09:08:41AM +0200, Heiko St?bner wrote:
> > Am Montag, 7. Juli 2014, 09:42:52 schrieb addy ke:
> > > > Your DT binding defined some additional compatible strings, please add
> > > > those to the driver.
> > 
> > citing Mark Rutland (one of the dt maintainers):
> > 
> > --
> > 
> >   That's why I said in addition to the common one. I'd only expect the
> >   
> >   driver to look for "rockchip,rk3066-spi", but a DTB could have:
> >         compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";
> >   
> >   Seeding the DTBs with the extra strings early makes it more likely that
> >   we can rely on them later. If we don't happen to need them they only
> >   clutter some DTBs.
> > 
> > --
> > 
> > so it looks like the driver is doing the right thing right now
> 
> The driver will work but it's better to list the strings that are
> supported explicitly if only to document that there's nothing specific
> Linux should be doing for them.

ok, makes sense :-)
