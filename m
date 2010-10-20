From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 20 Oct 2010 06:03:45 -0700
Subject: [PATCH] ARM: imx: change mx51.h into mx5x.h
In-Reply-To: <20101020113550.GL2562@matterhorn.lan>
References: <1287525423-22329-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101020090122.GH28166@pengutronix.de>
	<20101020113550.GL2562@matterhorn.lan>
Message-ID: <86A0E76937111F4C92FABEC0A2098851051D5B09@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

> -----Original Message-----
> From: Amit Kucheria [mailto:amit.kucheria at canonical.com]
> Sent: Wednesday, October 20, 2010 6:36 AM
> To: Uwe Kleine-K?nig
> Cc: Nguyen Dinh-R00091; linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; s.hauer at pengutronix.de;
> grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> daniel at caiaq.de; Zhang Lily-R58066; valentin.longchamp at epfl.ch
> Subject: Re: [PATCH] ARM: imx: change mx51.h into mx5x.h
> 
> On 10 Oct 20, Uwe Kleine-K?nig wrote:
> > Hello Dinh,
> >
> > On Tue, Oct 19, 2010 at 04:57:03PM -0500, Dinh.Nguyen at freescale.com
> wrote:
> > > From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > >
> > > In preparation for submitting i.MX53 support, change mx51.h to
> > > mx5x.h so that mx5x.h can contain MX53 information as well.
> > Last time I found time to clean up the imx ports I worked hard that
> e.g.
> > mx27 machines only used MX27_ prefixed symbols, not the MX2x_ ones.  (I
> > don't remember off-hand if I was done, so there might be a few users
> > left.)
> >
> > I'd prefer to just add an mx53.h instead.
> 
> Perhaps this is a good time to ask the question - Why?
> 
> mx53.h will duplicate (almost) everything in mx51.h. And any fixes made
> to
> mx51.h won't make it to mx53.h
> 

MX53 shares about 90% of what is in mx51.h, so I thought it would make more sense for to share a single mx5x.h file. Also, we are planning to add another part, MX50 in the very near future. The way that I am planning for mx5x.h is something like this:

MX5_MMC_ADDR	/*same address shared between both mx51 and mx53*/
MX51_IRAM_ADDR	/*IRAM address for mx51*/
MX53_IRAM_ADDR	/*IRAM address for mx53*/

Per Robert Schwebel's suggestion, I want to do small things at a time.

> Other sub-archs don't do this. e.g. omap uses one common header file and
> then
> a per-SoC file for the differences.
> 
> > > Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > >  #ifdef CONFIG_ARCH_MX3
> > > diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-
> mxc/include/mach/mx5x.h
> > > similarity index 100%
> > > rename from arch/arm/plat-mxc/include/mach/mx51.h
> > > rename to arch/arm/plat-mxc/include/mach/mx5x.h
> > > --
> > > 1.6.0.4
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> 
> --
> ----------------------------------------------------------------------
> Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
> ----------------------------------------------------------------------

Thanks,
Dinh
